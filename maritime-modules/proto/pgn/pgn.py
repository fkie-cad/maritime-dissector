#!/usr/bin/env python3
"""
NMEA 2000 PGN Lua dissector generator.

Generates Wireshark Lua dissector files for NMEA 2000 protocol messages
based on the canboat.json database.

Usage:
    python3 pgn.py
    
Output:
    - pgn_XXXXX.lua files for each supported PGN
    - pgn.lua main dispatcher file
"""

import requests
import json
import os
from typing import List, Tuple, Optional

from field_handlers import parse_field, needs_bitfield_offset, _WARN_SEEN
from lua_codegen import CursorParseBuilder, safe_int

# ============================================================================
# Configuration
# ============================================================================

# Change to script directory
abspath = os.path.abspath(__file__)
dname = os.path.dirname(abspath)
os.chdir(dname)

# PGNs that have known issues or are not supported
UNSUPPORTED = [130817]

# Safety limits for repeating field parsing
MAX_REPEAT_COUNT = 100      # Maximum reasonable count for repeating fields (sentinel check)
MAX_LOOP_ITERATIONS = 1000  # Safety cap for while-loops without explicit count

# Variable-length field types that require cursor-based parsing
_VARIABLE_FIELD_TYPES = {"STRING_LAU", "STRING_LZ"}

# Field types that are genuinely unparseable without more complex logic
_UNPARSEABLE_FIELD_TYPES = {"VARIABLE", "DYNAMIC_FIELD_KEY", "DYNAMIC_FIELD_LENGTH", "DYNAMIC_FIELD_VALUE"}


# ============================================================================
# BitOffset Inference
# ============================================================================

def infer_bit_offsets(pgn: dict) -> None:
    """Fill in missing BitOffset/BitStart for byte/bit-aligned fields when possible."""
    current_bit = 0
    for field in sorted(pgn.get("Fields", []), key=lambda f: f.get("Order", 0)):
        bit_len = safe_int(field.get("BitLength"))
        bit_offset = safe_int(field.get("BitOffset"))

        # When BitOffset exists, trust it and advance pointer if possible
        if bit_offset is not None:
            if field.get("BitStart") is None:
                field["BitStart"] = bit_offset % 8
            if bit_len is not None:
                current_bit = bit_offset + bit_len
            else:
                current_bit = None if field.get("FieldType") not in ("RESERVED", "SPARE") else current_bit
            continue

        # Skip inference when we cannot rely on previous alignment
        if current_bit is None or bit_len is None:
            if field.get("FieldType") not in ("RESERVED", "SPARE"):
                current_bit = None
            continue

        field["BitOffset"] = current_bit
        if field.get("BitStart") is None:
            field["BitStart"] = current_bit % 8
        current_bit += bit_len


# ============================================================================
# Cursor-based Field Generation (for repeating fields)
# ============================================================================

def generate_cursor_field(field: dict, cursor_var: str = "cursor") -> Tuple[str, Optional[int]]:
    """
    Generate Lua code to parse a field using cursor-based offset tracking.
    
    Returns:
        (lua_block, fixed_bytes) where:
        - lua_block: string of Lua code (caller handles indentation)
        - fixed_bytes: int if fixed size, None if variable
    """
    fid = field.get("Id")
    ftype = field.get("FieldType")
    bit_len = safe_int(field.get("BitLength"))
    
    cpb = CursorParseBuilder(cursor_var)
    
    # STRING_LAU: 1 byte length (includes 2-byte header), 1 byte encoding, then string data
    if ftype == "STRING_LAU":
        return cpb.parse_string_lau(fid), None

    # STRING_LZ: null-terminated string (scan for \0)
    if ftype == "STRING_LZ":
        return cpb.parse_string_lz(fid), None

    # Fixed-size numeric types
    if ftype in ("NUMBER", "PGN", "ISO_NAME", "MMSI", "DATE", "TIME", "DURATION"):
        if bit_len is None or bit_len <= 0:
            return f"-- {fid}: missing BitLength", None

        byte_len = (bit_len + 7) // 8
        if byte_len > 8:
            return f"-- {fid}: field too large ({byte_len} bytes)", None

        scale = field.get("Resolution")
        if scale is not None and str(scale) == "1":
            scale = None
        signed = bool(field.get("Signed", False)) and ftype not in ("PGN", "ISO_NAME", "MMSI")

        return cpb.parse_numeric(fid, byte_len, bit_len, signed, scale), byte_len

    # LOOKUP / BITLOOKUP
    if ftype in ("LOOKUP", "BITLOOKUP"):
        if bit_len is None or bit_len <= 0:
            return f"-- {fid}: missing BitLength", None
        byte_len = (bit_len + 7) // 8
        if byte_len > 4:
            return f"-- {fid}: LOOKUP too large", None
        return cpb.parse_lookup(fid, byte_len), byte_len

    # STRING_FIX
    if ftype == "STRING_FIX":
        if bit_len is None or bit_len % 8 != 0:
            return f"-- {fid}: STRING_FIX needs byte-aligned BitLength", None
        byte_len = bit_len // 8
        return cpb.parse_string_fix(fid, byte_len), byte_len

    # FLOAT
    if ftype == "FLOAT":
        byte_len = 4 if bit_len == 32 or bit_len is None else (bit_len + 7) // 8
        return cpb.parse_float(fid, byte_len), byte_len

    # BINARY
    if ftype == "BINARY":
        if bit_len is None:
            return cpb.parse_binary(fid), None
        if bit_len % 8 != 0:
            return f"-- {fid}: BINARY needs byte-aligned BitLength", None
        byte_len = bit_len // 8
        return cpb.parse_binary(fid, byte_len), byte_len

    # RESERVED / SPARE - skip but advance cursor
    if ftype in ("RESERVED", "SPARE"):
        if bit_len and bit_len > 0:
            byte_len = (bit_len + 7) // 8
            return cpb.skip(byte_len, f"skip {ftype}"), byte_len
        return "", 0

    # FIELD_INDEX
    if ftype == "FIELD_INDEX":
        byte_len = (bit_len + 7) // 8 if bit_len else 1
        return cpb.parse_lookup(fid, byte_len), byte_len

    # Unknown/unsupported type
    return f"-- {fid}: unsupported field type {ftype}", None


# ============================================================================
# Repeating Field Set Handling
# ============================================================================

def count_read_expr(length_bytes: int) -> str:
    """Generate Lua read expression for count field by byte length."""
    if length_bytes == 1:
        return ":uint()"
    elif length_bytes in (2, 4):
        return ":le_uint()"
    elif length_bytes == 8:
        return ":le_uint64():tonumber()"
    else:
        return ":uint()"


def generate_tree_line_for_field(field: dict, pgn_number: int, base_var: str, 
                                  base_byte: int) -> Tuple[Optional[str], Optional[str]]:
    """
    Generate a tree add line for a field relative to a base offset variable.
    
    Used for fixed-size repeating field blocks.
    """
    f = field
    bit_len = safe_int(f.get("BitLength"))
    bit_offset = safe_int(f.get("BitOffset"))
    
    if bit_len is None or bit_offset is None:
        return None, None
    
    bit_start = safe_int(f.get("BitStart"))
    if bit_start is None:
        bit_start = bit_offset % 8
    
    start_byte = bit_offset // 8
    bit_offset_in_byte = bit_offset % 8
    byte_len = (bit_offset_in_byte + bit_len + 7) // 8
    delta = start_byte - base_byte
    fid = f["Id"]
    ftype = f.get("FieldType")
    
    numeric_types = {"NUMBER", "PGN", "ISO_NAME", "MMSI", "DATE", "TIME", "DURATION"}

    # Scaled numeric promoted to float (not for PGN/ISO_NAME/MMSI)
    if ftype in numeric_types:
        if bit_len <= 0 or bit_len > 64:
            return None, None
        
        scale = f.get("Resolution")
        if scale is not None and str(scale) == "1":
            scale = None
        signed = bool(f.get("Signed", False)) and ftype not in ("PGN", "ISO_NAME", "MMSI")
        
        if bit_len > 32 and bit_offset_in_byte != 0:
            return None, None
        
        byte_span = (bit_offset_in_byte + bit_len + 7) // 8
        if byte_span == 0:
            return None, None
        
        if byte_span == 1:
            raw_expr = "_rng:uint()"
        elif byte_span <= 4:
            raw_expr = "_rng:le_uint()"
        else:
            raw_expr = "_rng:le_uint64():tonumber()"

        start_expr = f"{base_var} + {delta}"
        if bit_offset_in_byte == 0 and bit_len == byte_span * 8:
            val_expr = "_raw"
        else:
            val_expr = f"math.floor(_raw / (2 ^ {bit_offset_in_byte})) % (2 ^ {bit_len})"

        block = ["do",
                 f"        local _start = {start_expr}",
                 f"        if buffer:len() >= (_start + {byte_span}) then",
                 f"            local _rng = buffer(_start, {byte_span})",
                 f"            local _raw = {raw_expr}",
                 f"            local _val = {val_expr}"]
        
        if signed and bit_len > 0:
            block.append(f"            if _val >= 2 ^ ({bit_len} - 1) then")
            block.append(f"                _val = _val - 2 ^ {bit_len}")
            block.append("            end")
        
        if scale is not None:
            block.append(f"            subtree:add({fid}, _rng, _val * {scale})")
        else:
            block.append(f"            subtree:add({fid}, _rng, _val)")
        
        block.append("        end")
        block.append("    end")
        return "\n".join(block), fid

    # Plain numeric, float, binary, decimal, lookup, bitlookup, string_fix
    if ftype in ["FLOAT", "BINARY", "DECIMAL", "LOOKUP", "BITLOOKUP", "STRING_FIX"]:
        if ftype not in ["LOOKUP", "BITLOOKUP"] and (bit_offset_in_byte != 0 or bit_len % 8 != 0):
            return None, None
        
        buf = f"buffer({base_var} + {delta}, {byte_len})"
        
        if ftype in ["LOOKUP", "BITLOOKUP"] and (bit_offset_in_byte != 0 or bit_len % 8 != 0):
            line = ("do\n"
                    f"        local _start = {base_var} + {delta}\n"
                    f"        if buffer:len() >= (_start + {byte_len}) then\n"
                    f"            local _rng = buffer(_start, {byte_len})\n"
                    "            local _raw = _rng:le_uint()\n"
                    f"            local _val = math.floor(_raw / (2 ^ {bit_start})) % (2 ^ {bit_len})\n"
                    f"            subtree:add({fid}, _rng, _val)\n"
                    "        end\n"
                    "    end")
            return line, fid
        
        line = (f"if buffer:len() >= ({base_var} + {delta} + {byte_len}) then\n"
                f"        subtree:add({fid}, buffer({base_var} + {delta}, {byte_len}))\n"
                "    end")
        return line, fid

    # Handle STRING_LAU/LZ by keeping relative movement responsibilities outside
    if ftype in ["STRING_LAU", "STRING_LZ"]:
        return None, None

    # Unsupported types in repeating block
    return None, None


def build_repeating_sets(pgn_data: dict, fields_gen: List[dict], 
                         default_proto_fields: List[str], 
                         default_tree_nodes: List[str],
                         default_fieldnames: List[str]) -> Tuple[List[str], List[str], List[str]]:
    """
    Generates Lua loop code for repeating field sets in PGNs.
    
    Handles three cases:
    1. Fixed-size repeating blocks: Uses computed offsets within a for-loop
    2. Variable-length strings (STRING_LAU, STRING_LZ): Uses cursor-based parsing
       that reads length prefixes and advances dynamically
    3. Truly unparseable fields (VARIABLE, DYNAMIC_FIELD_*): Falls back to default
       parsing since these require runtime context not available at generation time
    """
    pgn = pgn_data["PGN"]
    
    def warn_once(key, msg):
        if key not in _WARN_SEEN:
            print(msg)
            _WARN_SEEN.add(key)
    
    # Discover repeating sets
    sets = []
    idx = 1
    while True:
        size_key = f"RepeatingFieldSet{idx}Size"
        start_key = f"RepeatingFieldSet{idx}StartField"
        count_key = f"RepeatingFieldSet{idx}CountField"
        if size_key in pgn_data and start_key in pgn_data:
            sets.append({
                "idx": idx,
                "size": int(pgn_data[size_key]),
                "start_field": int(pgn_data[start_key]),  # 1-based
                "count_field": int(pgn_data[count_key]) if count_key in pgn_data else None,
            })
            idx += 1
        else:
            break

    if not sets:
        return default_proto_fields, default_tree_nodes, default_fieldnames

    # Build a new tree list, injecting loop blocks and skipping repeated field nodes
    new_tree_nodes = []

    # For skipping logic
    repeat_start_map = {s["start_field"] - 1: s for s in sets}

    i = 0
    n = len(fields_gen)
    while i < n:
        if i in repeat_start_map:
            s = repeat_start_map[i]
            start_idx0 = s["start_field"] - 1
            size = s["size"]
            end_idx0 = min(start_idx0 + size, n)
            rep_fields = [fields_gen[j]["raw_field"] for j in range(start_idx0, end_idx0)]

            # Check fixed-size (variable-length fields require cursor-based parsing)
            fixed = True
            entry_start_bit = None
            entry_end_bit = None
            for rf in rep_fields:
                if "BitLength" not in rf or "BitOffset" not in rf:
                    fixed = False
                    break
                # These field types have runtime-determined lengths
                if rf.get("FieldType") in ("STRING_LAU", "STRING_LZ", "DYNAMIC_FIELD_KEY", 
                                            "DYNAMIC_FIELD_LENGTH", "DYNAMIC_FIELD_VALUE", "VARIABLE"):
                    fixed = False
                    break
                bit_len = int(rf["BitLength"])
                bit_offset = int(rf["BitOffset"])
                if entry_start_bit is None or bit_offset < entry_start_bit:
                    entry_start_bit = bit_offset
                if entry_end_bit is None or (bit_offset + bit_len) > entry_end_bit:
                    entry_end_bit = bit_offset + bit_len

            if fixed and entry_start_bit is not None and entry_end_bit is not None:
                entry_size_bytes = (entry_end_bit - entry_start_bit + 7) // 8
            else:
                entry_size_bytes = 0

            # Check for variable-length fields that we CAN parse with cursor vs truly unparseable
            has_variable_parseable = any(rf.get("FieldType") in _VARIABLE_FIELD_TYPES for rf in rep_fields)
            has_unparseable = any(rf.get("FieldType") in _UNPARSEABLE_FIELD_TYPES for rf in rep_fields)

            # Determine base offset from the first byte-aligned field in the repeating block
            try:
                start_off_b = min(int(rf.get("BitOffset")) // 8 for rf in rep_fields 
                                  if rf.get("BitOffset") is not None and rf.get("BitLength") is not None)
            except ValueError:
                # No suitable field with BitOffset/BitLength
                if has_variable_parseable and not has_unparseable:
                    start_off_b = 0  # Will use str_offset as base
                else:
                    warn_once((pgn, s['idx'], 'no-offsets'), 
                              f"WARNING: PGN {pgn} repeating set {s['idx']} lacks byte offsets - using default parse")
                    for j in range(i, end_idx0):
                        new_tree_nodes.extend(fields_gen[j]["tree"])
                    i = end_idx0
                    continue

            # Count field info
            count_idx0 = (s["count_field"] - 1) if s.get("count_field") else None
            use_inferred_count = False
            count_len_b = None
            count_off_b = None
            
            if count_idx0 is None:
                # If fixed-size and we know start offset, we can infer count from remaining length
                if fixed and entry_size_bytes > 0:
                    use_inferred_count = True
                elif has_variable_parseable and not has_unparseable:
                    # Variable-length fields without count, will use while-loop with cursor
                    pass
                else:
                    warn_once((pgn, s['idx'], 'missing-count'), 
                              f"WARNING: PGN {pgn} repeating set {s['idx']} missing count field - using default parse")
                    for j in range(i, end_idx0):
                        new_tree_nodes.extend(fields_gen[j]["tree"])
                    i = end_idx0
                    continue

            if count_idx0 is not None and not use_inferred_count:
                count_field = fields_gen[count_idx0]["raw_field"]
                if "BitLength" not in count_field or "BitOffset" not in count_field:
                    warn_once((pgn, s['idx'], 'count-no-offset'), 
                              f"WARNING: PGN {pgn} repeating set {s['idx']} count field lacks byte offsets - using default parse")
                    for j in range(i, end_idx0):
                        new_tree_nodes.extend(fields_gen[j]["tree"])
                    i = end_idx0
                    continue

                count_len_b = int(count_field["BitLength"]) // 8
                if int(count_field["BitLength"]) % 8 != 0:
                    warn_once((pgn, s['idx'], 'count-not-byte'), 
                              f"WARNING: PGN {pgn} repeating set {s['idx']} count field not byte-aligned - using default parse")
                    for j in range(i, end_idx0):
                        new_tree_nodes.extend(fields_gen[j]["tree"])
                    i = end_idx0
                    continue

                count_off_b = int(count_field["BitOffset"]) // 8

            # Handle unparseable fields (VARIABLE, DYNAMIC_*)
            if has_unparseable:
                warn_once((pgn, s['idx'], 'unparseable'), 
                          f"WARNING: PGN {pgn} repeating set {s['idx']} contains dynamic/variable fields - using default parse")
                for j in range(i, end_idx0):
                    new_tree_nodes.extend(fields_gen[j]["tree"])
                i = end_idx0
                continue

            # Use cursor-based parsing for variable-length STRING_LAU/STRING_LZ fields
            if has_variable_parseable and not fixed:
                block = []
                cursor_var = f"cursor_{s['idx']}"

                if count_idx0 is not None and count_len_b and count_off_b is not None:
                    cnt_read = count_read_expr(count_len_b)
                    block.append(f"local count_{s['idx']} = buffer({count_off_b}, {count_len_b}){cnt_read}")
                    block.append(f"if count_{s['idx']} > {MAX_REPEAT_COUNT} then count_{s['idx']} = 0 end  -- sentinel check")
                    block.append(f"local {cursor_var} = str_offset")
                    block.append(f"for _i_{s['idx']} = 1, count_{s['idx']} do")
                    block.append(f"    if {cursor_var} >= buffer:len() then break end")
                else:
                    # No count field - use while loop with safety cap
                    block.append(f"local {cursor_var} = str_offset")
                    block.append(f"local _iter_{s['idx']} = 0")
                    block.append(f"while {cursor_var} < buffer:len() and _iter_{s['idx']} < {MAX_LOOP_ITERATIONS} do")
                    block.append(f"    _iter_{s['idx']} = _iter_{s['idx']} + 1")
                    block.append(f"    local _prev_cursor = {cursor_var}")

                # Generate cursor-based field parsing
                all_fields_ok = True
                for rf in rep_fields:
                    if rf.get("FieldType") in ("RESERVED", "SPARE"):
                        bit_len_rf = safe_int(rf.get("BitLength"))
                        if bit_len_rf and bit_len_rf > 0:
                            byte_skip = (bit_len_rf + 7) // 8
                            block.append(f"    {cursor_var} = {cursor_var} + {byte_skip}  -- skip {rf.get('FieldType')}")
                        continue
                    
                    field_block, _ = generate_cursor_field(rf, cursor_var)
                    # Check if field generation failed
                    if not field_block or field_block.strip().startswith("--"):
                        all_fields_ok = False
                        break
                    # Indent each line of the block for the loop body
                    for ln in field_block.split("\n"):
                        block.append("    " + ln)

                if not all_fields_ok:
                    warn_once((pgn, s['idx'], 'cursor-fail'), 
                              f"WARNING: PGN {pgn} repeating set {s['idx']} cursor-based parsing failed - using default parse")
                    for j in range(i, end_idx0):
                        new_tree_nodes.extend(fields_gen[j]["tree"])
                    i = end_idx0
                    continue

                if count_idx0 is None:
                    # Add infinite loop protection for while-loop
                    block.append(f"    if {cursor_var} == _prev_cursor then break end  -- no progress")

                block.append("end")

                # Inject cursor-based loop as a single multi-line node
                new_tree_nodes.append("\n".join(block))
                i = end_idx0
                continue

            # Fixed-size path 
            if not fixed:
                warn_once((pgn, s['idx'], 'variable'), 
                          f"WARNING: PGN {pgn} repeating set {s['idx']} contains unsupported fields - using default parse")
                for j in range(i, end_idx0):
                    new_tree_nodes.extend(fields_gen[j]["tree"])
                i = end_idx0
                continue

            # Build loop code
            block = []
            if use_inferred_count:
                # compute number of entries from remaining length
                block.append(f"local rem_{s['idx']} = buffer:len() - (str_offset + {start_off_b})")
                block.append(f"local count_{s['idx']} = math.floor(rem_{s['idx']} / {entry_size_bytes})")
            else:
                cnt_read = count_read_expr(count_len_b)
                block.append(f"local count_{s['idx']} = buffer(str_offset + {count_off_b}, {count_len_b}){cnt_read}")
                # Limit count to reasonable max and ensure we have data for at least one entry
                block.append(f"if count_{s['idx']} > {MAX_REPEAT_COUNT} then count_{s['idx']} = 0 end  -- likely 'not available' sentinel")
            
            block.append(f"local rep_offset_{s['idx']} = str_offset + {start_off_b}")
            block.append(f"for _i_{s['idx']} = 1, count_{s['idx']} do")
            block.append(f"    if rep_offset_{s['idx']} + {entry_size_bytes} > buffer:len() then break end")

            for rf in rep_fields:
                line, fid = generate_tree_line_for_field(rf, pgn, f"rep_offset_{s['idx']}", start_off_b)
                if line:
                    block.append("    " + line)
                elif rf.get("FieldType") in ("RESERVED", "SPARE"):
                    # Nothing to emit, but keep structured parsing
                    continue
                else:
                    # If any field could not be generated, abort block and fallback to original
                    block = None
                    break

            if block is None:
                warn_once((pgn, s['idx'], 'variable'), 
                          f"WARNING: PGN {pgn} repeating set {s['idx']} contains variable-sized or unsupported fields - using default parse")
                for j in range(i, end_idx0):
                    new_tree_nodes.extend(fields_gen[j]["tree"])
                i = end_idx0
                continue

            block.append(f"    rep_offset_{s['idx']} = rep_offset_{s['idx']} + {entry_size_bytes}")
            block.append("end")

            # Inject loop code at this position, skip original nodes for repeated fields
            for ln in block:
                new_tree_nodes.append(ln)
            i = end_idx0
        else:
            new_tree_nodes.extend(fields_gen[i]["tree"])
            i += 1

    return default_proto_fields, new_tree_nodes, default_fieldnames


# ============================================================================
# File Generation
# ============================================================================

def normalize_tree_node(node: str) -> List[str]:
    """Normalize indentation of a multi-line tree node string."""
    node_str = str(node)
    lines = node_str.splitlines()

    # Trim leading/trailing blank lines
    while lines and lines[0].strip() == "":
        lines.pop(0)
    while lines and lines[-1].strip() == "":
        lines.pop()

    if not lines:
        return []

    normalized = []
    # First line: remove any leading whitespace entirely
    normalized.append(lines[0].lstrip())

    # Determine minimum indentation across remaining lines (ignoring empty ones)
    min_indent = None
    for ln in lines[1:]:
        stripped = ln.lstrip()
        if stripped:
            indent = len(ln) - len(stripped)
            if min_indent is None or indent < min_indent:
                min_indent = indent
    if min_indent is None:
        min_indent = 0

    # Apply indentation normalization for remaining lines
    for ln in lines[1:]:
        if ln.strip():
            normalized.append(ln[min_indent:])
        else:
            normalized.append("")

    return normalized


def sanitize_field_id(field: dict) -> None:
    """Sanitize field ID to be a valid Lua identifier."""
    fid = field.get("Id", "")
    if fid.startswith("1st"):
        field["Id"] = "first" + fid[3:]
    # Re-read after potential modification
    fid = field.get("Id", "")
    try:
        if fid and fid[0].isdigit():
            field["Id"] = "_" + fid
    except Exception:
        pass


def should_skip_pgn(pgn_num: int) -> bool:
    """Check if PGN should be skipped."""
    if pgn_num in UNSUPPORTED:
        return True
    # Ignore ISO 11783 protocol definition
    if 59392 <= pgn_num <= 60928:
        return True
    # Ignore Manufacturer proprietary
    if pgn_num == 61184:
        return True
    if 65280 <= pgn_num <= 65535:
        return True
    return False


def write_pgn_lua_file(pgn: dict, proto_fields: List[str], tree_nodes: List[str], 
                       fieldnames: List[str]) -> None:
    """Write a single pgn_XXXXX.lua file."""
    pgn_num = pgn["PGN"]
    bitfield_decl = "    local bitfield_offset = 0\n" if needs_bitfield_offset(pgn_num) else ""
    
    with open(f"pgn_{pgn_num}.lua", "w") as f:
        f.write(f"""-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_{pgn_num} = Proto("nmea-2000-{pgn_num}", "{pgn["Description"]} ({pgn_num})")\n""")

        for field in proto_fields:
            f.write(f"{field}\n")

        f.write(f"""\nNMEA_2000_{pgn_num}.fields = {{{",".join(fieldnames)}}}

function NMEA_2000_{pgn_num}.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN {pgn_num} ({pgn["Description"]})"
    local subtree = tree:add(NMEA_2000_{pgn_num}, buffer(), subtree_title)
    local str_offset = 0
{bitfield_decl}
""")

        for node in tree_nodes:
            for ln in normalize_tree_node(node):
                f.write(f"    {ln}\n")

        f.write(f"""end

return NMEA_2000_{pgn_num}
""")


def write_main_pgn_lua_file(created: List[int]) -> None:
    """Write the main pgn.lua dispatcher file."""
    with open("pgn.lua", "w") as f:
        f.write("""-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

local pgn_dissector = {}

""")

        for c in created:
            f.write(f'NMEA_2000_{c} = require "maritime-modules.proto.pgn.pgn_{c}"\n')

        f.write("\nfunction pgn_dissector.dissector(buffer, pinfo, tree, pgn)\n")

        for i, c in enumerate(created):
            keyword = "if" if i == 0 else "elseif"
            f.write(f"""    {keyword} pgn == {c} then
        NMEA_2000_{c}.dissector(buffer, pinfo, tree)\n""")

        f.write("""    else
        return false
    end

    return true
end

return pgn_dissector""")


# ============================================================================
# Main Entry Point
# ============================================================================

def load_canboat_data() -> dict:
    """Load canboat.json from local file or download if not present."""
    if os.path.isfile("../../../docs/canboat.json"):
        with open("../../../docs/canboat.json", "r") as f:
            return json.load(f)
    
    print("Downloading NMEA2000 definition ...")
    url = "https://raw.githubusercontent.com/canboat/canboat/refs/heads/master/docs/canboat.json"
    response = requests.get(url)
    return json.loads(response.content)


def main():
    """Generate all PGN Lua dissector files."""
    data = load_canboat_data()
    
    created = []
    
    for pgn in data["PGNs"]:
        pgn_num = pgn["PGN"]
        
        if should_skip_pgn(pgn_num):
            continue
        
        created.append(pgn_num)
        infer_bit_offsets(pgn)
        
        # Collect per-field generation outputs
        fields_generated = []
        for field in pgn["Fields"]:
            sanitize_field_id(field)
            proto, tree, name = parse_field(field, pgn_num)
            fields_generated.append({
                "order": field.get("Order"),
                "id": field.get("Id"),
                "proto": proto,
                "tree": tree,
                "fieldnames": name,
                "raw_field": field,
            })

        # Flatten defaults
        proto_fields = [pf for fg in fields_generated for pf in fg["proto"]]
        fieldnames = [nm for fg in fields_generated for nm in fg["fieldnames"]]
        tree_nodes = [tn for fg in fields_generated for tn in fg["tree"]]

        # Handle repeating field sets
        proto_fields, tree_nodes, fieldnames = build_repeating_sets(
            pgn, fields_generated, proto_fields, tree_nodes, fieldnames
        )
        
        # Write individual PGN file
        write_pgn_lua_file(pgn, proto_fields, tree_nodes, fieldnames)

    # Write main dispatcher file
    write_main_pgn_lua_file(created)
    
    print(f"Generated {len(created)} PGN dissector files")


if __name__ == "__main__":
    main()
