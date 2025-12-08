"""
Field handlers for NMEA 2000 PGN Lua dissector generation.

Each handler processes a specific field type and returns (proto_fields, tree_nodes, fieldnames).
Handlers use the builders from lua_codegen.py for consistent Lua code generation.
"""

from dataclasses import dataclass, field as dataclass_field
from typing import List, Tuple, Optional, Dict, Any, Callable
from lua_codegen import (
    ProtoFieldBuilder, FixedOffsetParseBuilder, SequentialParseBuilder,
    BitfieldParseBuilder, BufferOps, DisplayBase, LuaFieldTypes, 
    field_label, safe_int, get_bitmask, offset_expr
)

# Re-export safe_int for backward compatibility
__all__ = ['parse_field', 'needs_bitfield_offset', 'warn_field', 'FieldContext', 
           'reset_warnings', '_WARN_SEEN', '_PGNS_NEED_BITFIELD_OFFSET', 'safe_int']


# ============================================================================
# Field Context - encapsulates field parsing state
# ============================================================================

@dataclass
class FieldContext:
    """Context for field code generation."""
    field: Dict[str, Any]
    pgn: int
    offset_var: str = "str_offset"
    
    # Cached computed values
    _bit_length: Optional[int] = dataclass_field(default=None, repr=False)
    _bit_offset: Optional[int] = dataclass_field(default=None, repr=False)
    _bit_start: Optional[int] = dataclass_field(default=None, repr=False)
    _byte_offset: Optional[int] = dataclass_field(default=None, repr=False)
    _byte_length: Optional[int] = dataclass_field(default=None, repr=False)
    
    def __post_init__(self):
        self._bit_length = safe_int(self.field.get("BitLength"))
        self._bit_offset = safe_int(self.field.get("BitOffset"))
        self._bit_start = safe_int(self.field.get("BitStart"))
        if self._bit_offset is not None:
            self._byte_offset = self._bit_offset // 8
        if self._bit_length is not None:
            self._byte_length = (self._bit_length + 7) // 8
    
    @property
    def field_id(self) -> str:
        return self.field.get("Id", "")
    
    @property
    def field_type(self) -> str:
        return self.field.get("FieldType", "")
    
    @property
    def label(self) -> str:
        return field_label(self.field)
    
    @property
    def bit_length(self) -> Optional[int]:
        return self._bit_length
    
    @property
    def bit_offset(self) -> Optional[int]:
        return self._bit_offset
    
    @property
    def bit_start(self) -> Optional[int]:
        return self._bit_start
    
    @property
    def byte_offset(self) -> Optional[int]:
        return self._byte_offset
    
    @property
    def byte_length(self) -> Optional[int]:
        return self._byte_length
    
    @property
    def has_bit_offset(self) -> bool:
        return "BitOffset" in self.field
    
    @property
    def is_signed(self) -> bool:
        return bool(self.field.get("Signed", False))
    
    @property
    def resolution(self) -> Optional[float]:
        res = self.field.get("Resolution")
        if res is not None and str(res) != "1":
            return res
        return None
    
    @property
    def is_byte_aligned(self) -> bool:
        """Check if field is byte-aligned (both offset and length)."""
        if self._bit_length is None:
            return False
        if self._bit_start is not None and self._bit_start % 8 != 0:
            return False
        if self._bit_offset is not None and self._bit_offset % 8 != 0:
            return False
        return self._bit_length % 8 == 0
    
    @property
    def local_bytes(self) -> int:
        """Calculate bytes needed to read this field including bit offset."""
        bit_start = self._bit_start or 0
        if self._bit_length:
            return (bit_start + self._bit_length + 7) // 8
        return 0
    
    def build_length_check(self, length: int, offset_expr: Optional[str] = None) -> str:
        """Build buffer length check expression."""
        off = offset_expr or self.offset_var
        return BufferOps.length_check(off, length)
    
    def build_buffer_read(self, length: int, offset_expr: Optional[str] = None, 
                          signed: bool = False) -> str:
        """Build buffer read expression."""
        off = offset_expr or self.offset_var
        if signed:
            return BufferOps.read_int(off, length)
        return BufferOps.read_uint(off, length)
    
    def proto_builder(self) -> ProtoFieldBuilder:
        """Get a ProtoFieldBuilder for this field."""
        return ProtoFieldBuilder(self.pgn, self.field_id, self.label)
    
    def fixed_parse_builder(self) -> FixedOffsetParseBuilder:
        """Get a FixedOffsetParseBuilder for this field."""
        return FixedOffsetParseBuilder(self.offset_var)
    
    def sequential_parse_builder(self) -> SequentialParseBuilder:
        """Get a SequentialParseBuilder for this field."""
        return SequentialParseBuilder(self.offset_var)


# ============================================================================
# Warning Management
# ============================================================================

_WARN_SEEN = set()
_PGNS_NEED_BITFIELD_OFFSET = set()


# Use offset_expr imported from lua_codegen (aliased as _offset_expr for internal use)
_offset_expr = offset_expr


def warn_field(ctx: FieldContext, msg: str):
    """Issue a warning for a field, deduplicating by (pgn, field_id, msg)."""
    key = (ctx.pgn, ctx.field_id, msg)
    if key not in _WARN_SEEN:
        _WARN_SEEN.add(key)
        fid_str = f" field {ctx.field_id}" if ctx.field_id else ""
        print(f"WARNING: PGN {ctx.pgn}{fid_str}: {msg}")


def needs_bitfield_offset(pgn: int) -> bool:
    """Check if PGN needs bitfield_offset tracking."""
    return pgn in _PGNS_NEED_BITFIELD_OFFSET


def reset_warnings():
    """Reset warning state (for testing)."""
    global _WARN_SEEN, _PGNS_NEED_BITFIELD_OFFSET
    _WARN_SEEN = set()
    _PGNS_NEED_BITFIELD_OFFSET = set()


# ============================================================================
# Result Type
# ============================================================================

ParseResult = Tuple[List[str], List[str], List[str]]  # (protos, trees, fieldnames)

def empty_result() -> ParseResult:
    return [], [], []


# ============================================================================
# Sequential Field Helpers (no BitOffset)
# ============================================================================

def _sequential_byte_field(ctx: FieldContext, byte_length: int, 
                           base: DisplayBase = DisplayBase.DEC) -> ParseResult:
    """Handle byte-aligned sequential field (advances str_offset)."""
    if not byte_length or byte_length <= 0:
        warn_field(ctx, "Unsupported sequential byte length")
        return empty_result()
    
    field_type = LuaFieldTypes.get_int_type(byte_length)
    if field_type is None:
        warn_field(ctx, f"Unsupported sequential field size {byte_length} bytes")
        return empty_result()
    
    pb = ctx.proto_builder()
    proto = pb.integer(byte_length, base=base)
    
    add_func = "add_le" if byte_length > 1 else "add"
    tree = f"""if buffer:len() >= (str_offset + {byte_length}) then
        subtree:{add_func}({ctx.field_id}, buffer(str_offset, {byte_length}))
        str_offset = str_offset + {byte_length}
    end"""
    
    return [proto], [tree], [ctx.field_id]


def _sequential_bitfield(ctx: FieldContext, base: DisplayBase = DisplayBase.DEC,
                         signed: bool = False) -> ParseResult:
    """Handle non-byte-aligned sequential field using bitfield_offset tracking."""
    bit_len = ctx.bit_length
    if bit_len is None:
        warn_field(ctx, "Missing BitLength for sequential bitfield")
        return empty_result()
    if bit_len <= 0 or bit_len > 32:
        warn_field(ctx, f"BitLength {bit_len} unsupported for sequential bitfield")
        return empty_result()
    
    _PGNS_NEED_BITFIELD_OFFSET.add(ctx.pgn)
    
    pb = ctx.proto_builder()
    proto = pb.uint32_computed(base)
    
    # Use BitfieldParseBuilder for the parsing code
    bpb = BitfieldParseBuilder(ctx.offset_var, "bitfield_offset")
    tree = bpb.parse_bitfield(ctx.field_id, bit_len, signed)
    
    return [proto], [tree], [ctx.field_id]


# ============================================================================
# Unified Lookup Handler (LOOKUP and BITLOOKUP)
# ============================================================================

def handle_lookup_field(ctx: FieldContext, 
                        display_base: DisplayBase = DisplayBase.DEC) -> ParseResult:
    """
    Handle LOOKUP and BITLOOKUP fields.
    
    These are similar in structure: both are enumerated values stored in a bit range.
    The main difference is display format (DEC for LOOKUP, HEX for BITLOOKUP).
    """
    bit_len = ctx.bit_length
    
    # Sequential case (no BitOffset)
    if not ctx.has_bit_offset:
        if bit_len is None:
            warn_field(ctx, "Missing BitLength")
            return empty_result()
        if bit_len % 8 == 0:
            return _sequential_byte_field(ctx, bit_len // 8, base=display_base)
        return _sequential_bitfield(ctx, base=display_base)
    
    if bit_len is None:
        warn_field(ctx, "Missing BitLength")
        return empty_result()
    
    pb = ctx.proto_builder()
    fpb = ctx.fixed_parse_builder()
    bit_offset = safe_int(ctx.field.get("BitOffset")) or 0
    bit_start = ctx.bit_start or 0
    
    # Check if byte-aligned (both offset and length are multiples of 8)
    is_byte_aligned = (bit_offset % 8 == 0) and (bit_len % 8 == 0)
    
    # LOOKUP: <= 8 bits uses bitmask, > 8 bits uses uint32 with computed value
    if display_base == DisplayBase.DEC:
        if bit_len <= 8:
            bitmask = get_bitmask(bit_len, bit_start)
            proto = pb.uint8_with_mask(bitmask)
            tree = fpb.parse_lookup_with_mask(ctx.field_id, ctx.byte_offset)
            return [proto], [tree], [ctx.field_id]
        elif bit_len <= 32:
            local_bytes = (bit_start + bit_len + 7) // 8
            if local_bytes > 4:
                warn_field(ctx, "LOOKUP spans >4 bytes; not supported")
                return empty_result()
            proto = pb.uint32_no_base()
            tree = fpb.parse_masked_value(
                ctx.field_id, ctx.byte_offset, bit_start, bit_len, local_bytes
            )
            return [proto], [tree], [ctx.field_id]
    
    # BITLOOKUP: byte-aligned uses proper sized uint, non-aligned uses uint32 computed
    if display_base == DisplayBase.HEX:
        if is_byte_aligned:
            byte_length = bit_len // 8
            off = _offset_expr(ctx.byte_offset)
            proto = pb.uint_for_bits(bit_len, DisplayBase.HEX)
            tree = f"subtree:add({ctx.field_id}, buffer({off}, {byte_length}))"
            return [proto], [tree], [ctx.field_id]
        else:
            local_bytes = (bit_start + bit_len + 7) // 8
            if local_bytes > 4:
                warn_field(ctx, "BITLOOKUP spans >4 bytes; not supported")
                return empty_result()
            proto = pb.uint32_computed(DisplayBase.HEX)
            tree = fpb.parse_masked_value(
                ctx.field_id, ctx.byte_offset, bit_start, bit_len, local_bytes
            )
            return [proto], [tree], [ctx.field_id]
    
    warn_field(ctx, f"{ctx.field_type} BitLength {bit_len} too large")
    return empty_result()


# ============================================================================
# Unified String Handler (STRING_LAU and STRING_LZ)
# ============================================================================

def handle_string_variable(ctx: FieldContext, string_type: str) -> ParseResult:
    """
    Handle STRING_LAU and STRING_LZ fields.
    
    Both are variable-length strings that require cursor-based parsing:
    - STRING_LAU: length byte (includes 2-byte header), encoding byte, then data
    - STRING_LZ: length byte, data, null terminator
    """
    if not ctx.has_bit_offset:
        ctx.field["BitOffset"] = 0  # Hack: rely on str_offset
    
    byte_offset = ctx.byte_offset or 0
    
    pb = ctx.proto_builder()
    proto = pb.string()
    
    spb = ctx.sequential_parse_builder()
    
    if string_type == "STRING_LAU":
        tree = spb.parse_string_lau(ctx.field_id, byte_offset)
    else:  # STRING_LZ
        tree = spb.parse_string_lz(ctx.field_id, byte_offset)
    
    return [proto], [tree], [ctx.field_id]


# ============================================================================
# Integer Handler (NUMBER, DATE, TIME, DURATION, PGN, ISO_NAME, MMSI)
# ============================================================================

def handle_integer_field(ctx: FieldContext) -> ParseResult:
    """Handle integer-like fields with various display formats."""
    ftype = ctx.field_type
    bit_len = ctx.bit_length
    
    # Sequential case (no BitOffset)
    if not ctx.has_bit_offset:
        if bit_len is None:
            warn_field(ctx, "Missing BitOffset")
            return empty_result()
        
        if bit_len % 8 == 0:
            return _handle_sequential_byte_int(ctx)
        elif bit_len <= 32:
            return _handle_sequential_bitfield_int(ctx)
        else:
            warn_field(ctx, "BitLength too large for sequential bit parse")
            return empty_result()
    
    # Fixed offset case
    bit_start = ctx.bit_start or 0
    
    # Non-byte-aligned integers
    if (bit_len % 8 != 0) or (bit_start % 8 != 0):
        return _handle_masked_int(ctx)
    
    # Byte-aligned integers
    return _handle_aligned_int(ctx)


def _handle_sequential_byte_int(ctx: FieldContext) -> ParseResult:
    """Handle byte-aligned sequential integer."""
    byte_length = ctx.bit_length // 8
    signed = ctx.is_signed and ctx.field_type not in ("PGN", "ISO_NAME", "MMSI")
    
    field_type = LuaFieldTypes.get_int_type(byte_length, signed)
    if not field_type:
        warn_field(ctx, f"Unsupported integer size {byte_length} bytes (sequential)")
        return empty_result()
    
    pb = ctx.proto_builder()
    proto = pb.integer_simple(byte_length, signed)
    
    if ctx.field_type == "MMSI":
        tree = f"""if buffer:len() >= (str_offset + {byte_length}) then
                    local {ctx.field_id}_val = buffer(str_offset, {byte_length}):le_uint()
                    local _ti = subtree:add({ctx.field_id}, buffer(str_offset, {byte_length}), {ctx.field_id}_val)
                    _ti:append_text(string.format(" (%09d)", {ctx.field_id}_val))
                    str_offset = str_offset + {byte_length}
                end"""
    elif ctx.resolution:
        proto = pb.float()
        conv = ":le_int()" if signed else ":le_uint()"
        if byte_length == 8:
            conv = ":le_int64():tonumber()" if signed else ":le_uint64():tonumber()"
        tree = f"""if buffer:len() >= (str_offset + {byte_length}) then
                        subtree:add({ctx.field_id}, buffer(str_offset, {byte_length}), buffer(str_offset, {byte_length}){conv} * {ctx.resolution})
                        str_offset = str_offset + {byte_length}
                    end"""
    else:
        add_func = "add_le" if byte_length > 1 else "add"
        tree = f"""if buffer:len() >= (str_offset + {byte_length}) then
                        subtree:{add_func}({ctx.field_id}, buffer(str_offset, {byte_length}))
                        str_offset = str_offset + {byte_length}
                    end"""
    
    return [proto], [tree], [ctx.field_id]


def _handle_sequential_bitfield_int(ctx: FieldContext) -> ParseResult:
    """Handle non-byte-aligned sequential integer."""
    # Only support unscaled sequential bitfields
    if ctx.resolution:
        warn_field(ctx, "Scaled sequential bitfields not supported")
        return empty_result()
    
    signed = ctx.is_signed and ctx.field_type not in ("PGN", "ISO_NAME", "MMSI")
    return _sequential_bitfield(ctx, base=DisplayBase.DEC, signed=signed)


def _handle_masked_int(ctx: FieldContext) -> ParseResult:
    """Handle non-byte-aligned integer with fixed offset."""
    bit_len = ctx.bit_length
    bit_start = ctx.bit_start or 0
    
    if bit_len == 0 or bit_len > 32:
        warn_field(ctx, "Integer BitLength missing or too large for non-aligned parse")
        return empty_result()
    
    start_b = ctx.byte_offset
    off = _offset_expr(start_b)
    local_bytes = (bit_start + bit_len + 7) // 8
    
    if local_bytes > 4:
        warn_field(ctx, "Integer spans >4 bytes; not supported")
        return empty_result()
    
    ftype = ctx.field_type
    fpb = ctx.fixed_parse_builder()
    pb = ctx.proto_builder()
    
    # PGN/ISO_NAME/MMSI special handling
    if ftype in ("PGN", "ISO_NAME", "MMSI"):
        proto = pb.int32(signed=False)
        
        if ftype == "MMSI":
            tree = f"""if buffer:len() >= ({off} + {local_bytes}) then
                        local _rng = buffer({off}, {local_bytes})
                        local _raw = _rng:le_uint()
                        local {ctx.field_id}_val = math.floor(_raw / (2 ^ {bit_start})) % (2 ^ {bit_len})
                        local _ti = subtree:add({ctx.field_id}, _rng, {ctx.field_id}_val)
                        _ti:append_text(string.format(" (%09d)", {ctx.field_id}_val))
                    end"""
        else:
            tree = fpb.parse_masked_value(ctx.field_id, start_b, bit_start, bit_len, local_bytes)
        return [proto], [tree], [ctx.field_id]
    
    # Scaled value
    if ctx.resolution:
        proto = pb.float()
        tree = f"""if buffer:len() >= ({off} + {local_bytes}) then
                    local _rng = buffer({off}, {local_bytes})
                    local _raw = _rng:le_uint()
                    local _val = math.floor(_raw / (2 ^ {bit_start})) % (2 ^ {bit_len})"""
        
        signed = ctx.is_signed
        if signed:
            tree += f"""
                    if _val >= 2 ^ ({bit_len} - 1) then
                        _val = _val - 2 ^ {bit_len}
                    end"""
        
        tree += f"""
                    subtree:add({ctx.field_id}, _rng, _val * {ctx.resolution})
                end"""
        return [proto], [tree], [ctx.field_id]
    
    # Plain signed/unsigned integer
    signed = ctx.is_signed
    proto = pb.int32(signed=signed)
    
    tree = fpb.parse_masked_value(ctx.field_id, start_b, bit_start, bit_len, local_bytes, signed=signed)
    return [proto], [tree], [ctx.field_id]


def _handle_aligned_int(ctx: FieldContext) -> ParseResult:
    """Handle byte-aligned integer with fixed offset."""
    bit_len = ctx.bit_length
    byte_length = bit_len // 8
    byte_offset = ctx.byte_offset
    ftype = ctx.field_type
    off = _offset_expr(byte_offset)
    pb = ctx.proto_builder()
    
    # PGN/ISO_NAME/MMSI special handling
    if ftype in ("PGN", "ISO_NAME", "MMSI"):
        if ftype == "PGN":
            field_type = {3: "uint24", 4: "uint32"}.get(byte_length, "uint32" if byte_length >= 3 else ("uint16" if byte_length == 2 else "uint8"))
            proto = f'{pb._base()}.{field_type}("{pb._proto_name()}", "{pb.label}")'
        elif ftype == "ISO_NAME":
            proto = f'{pb._base()}.uint64("{pb._proto_name()}", "{pb.label}")'
        else:  # MMSI
            proto = pb.int32(signed=False)
        
        if ftype == "MMSI":
            conv = ":le_uint()" if byte_length <= 4 else ":le_uint64():tonumber()"
            tree = f"""if buffer:len() >= ({off} + {byte_length}) then
                    local {ctx.field_id}_val = buffer({off}, {byte_length}){conv}
                    local _ti = subtree:add({ctx.field_id}, buffer({off}, {byte_length}), {ctx.field_id}_val)
                    _ti:append_text(string.format(" (%09d)", {ctx.field_id}_val))
                end"""
        else:
            add_func = "add_le" if byte_length > 1 else "add"
            tree = f"""if buffer:len() >= ({off} + {byte_length}) then
                    subtree:{add_func}({ctx.field_id}, buffer({off}, {byte_length}))
                end"""
        return [proto], [tree], [ctx.field_id]
    
    # Scaled value
    if ctx.resolution:
        signed = ctx.is_signed
        proto = pb.float()
        
        if byte_length == 8:
            conv = ":le_int64():tonumber()" if signed else ":le_uint64():tonumber()"
        else:
            conv = ":le_int()" if signed else ":le_uint()"
        
        tree = f"""if buffer:len() >= ({off} + {byte_length}) then
                        subtree:add({ctx.field_id}, buffer({off}, {byte_length}), buffer({off}, {byte_length}){conv} * {ctx.resolution})
                    end"""
        return [proto], [tree], [ctx.field_id]
    
    # Plain integer
    signed = ctx.is_signed
    field_type = LuaFieldTypes.get_int_type(byte_length, signed)
    if not field_type:
        warn_field(ctx, f"Unsupported integer size {byte_length} bytes")
        return empty_result()
    
    proto = pb.integer_simple(byte_length, signed)
    add_func = "add_le" if byte_length > 1 else "add"
    tree = f"""if buffer:len() >= ({off} + {byte_length}) then
                subtree:{add_func}({ctx.field_id}, buffer({off}, {byte_length}))
            end"""
    return [proto], [tree], [ctx.field_id]


# ============================================================================
# Float Handler
# ============================================================================

def handle_float_field(ctx: FieldContext) -> ParseResult:
    """Handle FLOAT field type."""
    pb = ctx.proto_builder()
    fpb = ctx.fixed_parse_builder()
    
    bit_len = ctx.bit_length or 32
    byte_length = bit_len // 8
    byte_offset = ctx.byte_offset or 0
    
    proto = pb.float()
    tree = fpb.parse_float(ctx.field_id, byte_offset, byte_length)
    
    return [proto], [tree], [ctx.field_id]


# ============================================================================
# String FIX Handler
# ============================================================================

def handle_string_fix_field(ctx: FieldContext) -> ParseResult:
    """Handle STRING_FIX field type."""
    bit_len = ctx.bit_length
    
    # Sequential case
    if bit_len and bit_len % 8 == 0 and not ctx.has_bit_offset:
        byte_length = bit_len // 8
        pb = ctx.proto_builder()
        proto = pb.string()
        
        tree = f"""if buffer:len() >= (str_offset + {byte_length}) then
                local _{ctx.field_id}_raw = buffer(str_offset, {byte_length}):string()
                local _{ctx.field_id}_clean = _{ctx.field_id}_raw:gsub("[%s@%z\\xff]+$", "")
                subtree:add({ctx.field_id}, buffer(str_offset, {byte_length}), _{ctx.field_id}_clean)
                str_offset = str_offset + {byte_length}
            end"""
        return [proto], [tree], [ctx.field_id]
    
    if not ctx.has_bit_offset:
        warn_field(ctx, "Missing BitOffset")
        return empty_result()
    
    if bit_len is None:
        warn_field(ctx, "Missing BitLength")
        return empty_result()
    
    if bit_len % 8 != 0:
        warn_field(ctx, "STRING_FIX BitLength not divisible by 8")
        return empty_result()
    
    byte_offset = ctx.byte_offset
    byte_length = bit_len // 8
    off = _offset_expr(byte_offset)
    
    pb = ctx.proto_builder()
    proto = pb.string()
    
    tree = f"""if buffer:len() >= ({off} + {byte_length}) then
            local _{ctx.field_id}_raw = buffer({off}, {byte_length}):string()
            local _{ctx.field_id}_clean = _{ctx.field_id}_raw:gsub("[%s@%z\\xff]+$", "")
            subtree:add({ctx.field_id}, buffer({off}, {byte_length}), _{ctx.field_id}_clean)
        end"""
    
    return [proto], [tree], [ctx.field_id]


# ============================================================================
# Binary Handler
# ============================================================================

def handle_binary_field(ctx: FieldContext) -> ParseResult:
    """Handle BINARY field type."""
    pb = ctx.proto_builder()
    bit_len = ctx.bit_length
    
    # No length, so rest of buffer
    if bit_len is None:
        proto = pb.bytes()
        tree = f"""local _rem = buffer:len() - str_offset
    if _rem > 0 then
        subtree:add({ctx.field_id}, buffer(str_offset, _rem))
        str_offset = str_offset + _rem
    end"""
        return [proto], [tree], [ctx.field_id]
    
    # Sequential case
    if not ctx.has_bit_offset and bit_len % 8 == 0:
        byte_length = bit_len // 8
        proto = pb.bytes()
        tree = f"""if buffer:len() >= (str_offset + {byte_length}) then
                subtree:add({ctx.field_id}, buffer(str_offset, {byte_length}))
                str_offset = str_offset + {byte_length}
            end"""
        return [proto], [tree], [ctx.field_id]
    
    if not ctx.has_bit_offset:
        warn_field(ctx, "Missing BitOffset for BINARY")
        return empty_result()
    
    bit_start = ctx.bit_start or 0
    
    # Non-byte-aligned binary -> expose as uint32 HEX
    if (bit_len % 8 != 0) or (bit_start % 8 != 0):
        if bit_len == 0 or bit_len > 32:
            warn_field(ctx, "BINARY BitLength not divisible by 8")
            return empty_result()
        
        start_b = ctx.byte_offset
        off = _offset_expr(start_b)
        local_bytes = (bit_start + bit_len + 7) // 8
        
        if local_bytes > 4:
            warn_field(ctx, "BINARY spans >4 bytes; not supported")
            return empty_result()
        
        proto = pb.uint32_computed(DisplayBase.HEX)
        tree = f"""do
        local _rng = buffer({off}, {local_bytes})
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ {bit_start})) % (2 ^ {bit_len})
        subtree:add({ctx.field_id}, _rng, _val)
    end"""
        return [proto], [tree], [ctx.field_id]
    
    # Byte-aligned fixed-size binary
    if bit_len % 8 != 0:
        warn_field(ctx, "BINARY BitLength not divisible by 8")
        return empty_result()
    
    byte_length = bit_len // 8
    byte_offset = ctx.byte_offset
    off = _offset_expr(byte_offset)
    
    proto = pb.bytes()
    tree = f"""if buffer:len() >= ({off} + {byte_length}) then
            subtree:add({ctx.field_id}, buffer({off}, {byte_length}))
        end"""
    
    return [proto], [tree], [ctx.field_id]


# ============================================================================
# Decimal (BCD) Handler
# ============================================================================

def handle_decimal_field(ctx: FieldContext) -> ParseResult:
    """Handle DECIMAL (BCD) field type."""
    bit_len = ctx.bit_length
    pb = ctx.proto_builder()
    
    # Sequential case
    if bit_len and bit_len % 8 == 0 and not ctx.has_bit_offset:
        byte_length = bit_len // 8
        proto = pb.bytes()
        tree = f"""subtree:add({ctx.field_id}, buffer(str_offset, {byte_length}))
    str_offset = str_offset + {byte_length}"""
        return [proto], [tree], [ctx.field_id]
    
    if not ctx.has_bit_offset:
        warn_field(ctx, "Missing BitOffset for DECIMAL")
        return empty_result()
    
    if bit_len is None:
        warn_field(ctx, "Missing BitLength for DECIMAL")
        return empty_result()
    
    if bit_len % 8 != 0:
        warn_field(ctx, "DECIMAL BitLength not divisible by 8")
        return empty_result()
    
    byte_offset = ctx.byte_offset
    byte_length = bit_len // 8
    off = _offset_expr(byte_offset)
    
    proto = pb.bytes()
    tree = f"subtree:add({ctx.field_id}, buffer({off}, {byte_length}))"
    
    return [proto], [tree], [ctx.field_id]


# ============================================================================
# Dynamic Field Handlers
# ============================================================================

def handle_dynamic_field_key(ctx: FieldContext) -> ParseResult:
    """Handle DYNAMIC_FIELD_KEY field type."""
    if not ctx.has_bit_offset:
        warn_field(ctx, "Missing BitOffset for DYNAMIC_FIELD_KEY")
        return empty_result()
    
    bit_len = ctx.bit_length
    if bit_len is None:
        warn_field(ctx, "Missing BitLength for DYNAMIC_FIELD_KEY")
        return empty_result()
    
    pb = ctx.proto_builder()
    bit_start = ctx.bit_start or 0
    
    # Non-byte-aligned
    if (bit_len % 8 != 0) or (bit_start % 8 != 0):
        if bit_len == 0 or bit_len > 32:
            warn_field(ctx, "DYNAMIC_FIELD_KEY BitLength too large for non-aligned parse")
            return empty_result()
        
        start_b = ctx.byte_offset
        off = _offset_expr(start_b)
        local_bytes = (bit_start + bit_len + 7) // 8
        
        if local_bytes > 4:
            warn_field(ctx, "DYNAMIC_FIELD_KEY spans >4 bytes; not supported")
            return empty_result()
        
        proto = pb.int32(signed=False)
        tree = f"""do
        local _rng = buffer({off}, {local_bytes})
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ {bit_start})) % (2 ^ {bit_len})
        subtree:add({ctx.field_id}, _rng, _val)
    end"""
        return [proto], [tree], [ctx.field_id]
    
    # Byte-aligned
    byte_length = bit_len // 8
    byte_offset = ctx.byte_offset
    off = _offset_expr(byte_offset)
    
    proto = pb.for_byte_length(byte_length)
    tree = f"subtree:add({ctx.field_id}, buffer({off}, {byte_length}))"
    
    return [proto], [tree], [ctx.field_id]


def handle_dynamic_field_length(ctx: FieldContext) -> ParseResult:
    """Handle DYNAMIC_FIELD_LENGTH field type."""
    if not ctx.has_bit_offset:
        warn_field(ctx, "Missing BitOffset for DYNAMIC_FIELD_LENGTH")
        return empty_result()
    
    bit_len = ctx.bit_length
    if bit_len is None:
        warn_field(ctx, "Missing BitLength for DYNAMIC_FIELD_LENGTH")
        return empty_result()
    
    if bit_len > 8:
        warn_field(ctx, "DYNAMIC_FIELD_LENGTH BitLength too large")
        return empty_result()
    
    byte_offset = ctx.byte_offset
    off = _offset_expr(byte_offset)
    pb = ctx.proto_builder()
    
    if bit_len < 8:
        local_start = ctx.bit_start or 0
        bitmask = get_bitmask(bit_len, local_start)
        proto = pb.uint8_with_mask(bitmask)
        tree = f"""if buffer:len() >= ({off} + 1) then
                local _b = buffer({off}, 1):uint()
                dynamic_length = math.floor(_b / (2 ^ {local_start})) % (2 ^ {bit_len})
                subtree:add({ctx.field_id}, buffer({off}, 1))
            end"""
    else:
        proto = pb.uint8_simple()
        tree = f"""if buffer:len() >= ({off} + 1) then
            dynamic_length = buffer({off}, 1):uint()
            subtree:add({ctx.field_id}, buffer({off}, 1))
        end"""
    
    return [proto], [tree], [ctx.field_id]


def handle_dynamic_field_value(ctx: FieldContext) -> ParseResult:
    """Handle DYNAMIC_FIELD_VALUE field type."""
    if not ctx.has_bit_offset:
        warn_field(ctx, "Missing BitOffset for DYNAMIC_FIELD_VALUE")
        return empty_result()
    
    byte_offset = ctx.byte_offset
    off = _offset_expr(byte_offset)
    pb = ctx.proto_builder()
    
    proto = pb.bytes()
    tree = f"""if dynamic_length and dynamic_length > 0 then
            if buffer:len() >= ({off} + dynamic_length) then
                subtree:add({ctx.field_id}, buffer({off}, dynamic_length))
                str_offset = str_offset + dynamic_length
            else
                local _rem = buffer:len() - ({off})
                if _rem > 0 then
                    subtree:add({ctx.field_id}, buffer({off}, _rem))
                    str_offset = str_offset + _rem
                end
            end
        end"""
    
    return [proto], [tree], [ctx.field_id]


def handle_variable_field(ctx: FieldContext) -> ParseResult:
    """Handle VARIABLE field type."""
    byte_off = ctx.byte_offset or 0
    off = _offset_expr(byte_off)
    pb = ctx.proto_builder()
    
    proto = pb.bytes()
    tree = f"""local _vlen = dynamic_length
    if _vlen and _vlen > 0 then
        subtree:add({ctx.field_id}, buffer({off}, _vlen))
        str_offset = str_offset + _vlen
    else
        local _rem = buffer:len() - ({off})
        if _rem > 0 then
            subtree:add({ctx.field_id}, buffer({off}, _rem))
            str_offset = str_offset + _rem
        end
    end"""
    
    return [proto], [tree], [ctx.field_id]


# ============================================================================
# Other Field Handlers
# ============================================================================

def handle_indirect_lookup_field(ctx: FieldContext) -> ParseResult:
    """Handle INDIRECT_LOOKUP field type."""
    if not ctx.has_bit_offset or ctx.bit_length is None:
        warn_field(ctx, "Missing BitOffset/BitLength for INDIRECT_LOOKUP")
        return empty_result()
    
    if ctx.bit_offset % 8 != 0 or ctx.bit_length % 8 != 0:
        warn_field(ctx, "INDIRECT_LOOKUP not byte-aligned")
        return empty_result()
    
    byte_length = ctx.bit_length // 8
    byte_offset = ctx.byte_offset
    off = _offset_expr(byte_offset)
    pb = ctx.proto_builder()
    
    proto = pb.for_byte_length_with_base(byte_length, DisplayBase.DEC)
    tree = f"""if buffer:len() >= ({off} + {byte_length}) then
            subtree:add({ctx.field_id}, buffer({off}, {byte_length}))
        end"""
    
    return [proto], [tree], [ctx.field_id]


def handle_field_index(ctx: FieldContext) -> ParseResult:
    """Handle FIELD_INDEX field type."""
    if not ctx.has_bit_offset:
        return empty_result()
    
    bl = (ctx.bit_length or 8) // 8
    if bl < 1:
        bl = 1
    byte_offset = ctx.byte_offset
    off = _offset_expr(byte_offset)
    
    # Use field Name for label in FIELD_INDEX
    pb = ProtoFieldBuilder(ctx.pgn, ctx.field_id, ctx.field.get("Name", ""))
    proto = pb.uint8_simple()
    tree = f"""if buffer:len() >= ({off} + {bl}) then
            subtree:add({ctx.field_id}, buffer({off}, {bl}))
        end"""
    
    return [proto], [tree], [ctx.field_id]


def handle_reserved_spare(ctx: FieldContext) -> ParseResult:
    """Handle RESERVED/SPARE field types."""
    if not ctx.has_bit_offset and ctx.bit_length:
        bit_len = ctx.bit_length
        if bit_len > 0:
            byte_len = (bit_len + 7) // 8
            tree = f"str_offset = str_offset + {byte_len}  -- skip {ctx.field_type}"
            return [], [tree], []
    return empty_result()


# ============================================================================
# Field Handler Dispatch
# ============================================================================

FIELD_HANDLERS: Dict[str, Callable[[FieldContext], ParseResult]] = {
    # Integer types
    "NUMBER": handle_integer_field,
    "DATE": handle_integer_field,
    "TIME": handle_integer_field,
    "DURATION": handle_integer_field,
    "PGN": handle_integer_field,
    "ISO_NAME": handle_integer_field,
    "MMSI": handle_integer_field,
    
    # Float
    "FLOAT": handle_float_field,
    
    # Lookups (unified handler with different display bases)
    "LOOKUP": lambda ctx: handle_lookup_field(ctx, DisplayBase.DEC),
    "BITLOOKUP": lambda ctx: handle_lookup_field(ctx, DisplayBase.HEX),
    
    # Strings
    "STRING_FIX": handle_string_fix_field,
    "STRING_LAU": lambda ctx: handle_string_variable(ctx, "STRING_LAU"),
    "STRING_LZ": lambda ctx: handle_string_variable(ctx, "STRING_LZ"),
    
    # Binary/Decimal
    "BINARY": handle_binary_field,
    "DECIMAL": handle_decimal_field,
    
    # Dynamic fields
    "DYNAMIC_FIELD_KEY": handle_dynamic_field_key,
    "DYNAMIC_FIELD_LENGTH": handle_dynamic_field_length,
    "DYNAMIC_FIELD_VALUE": handle_dynamic_field_value,
    "VARIABLE": handle_variable_field,
    
    # Other
    "INDIRECT_LOOKUP": handle_indirect_lookup_field,
    "FIELD_INDEX": handle_field_index,
    "RESERVED": handle_reserved_spare,
    "SPARE": handle_reserved_spare,
}


def parse_field(field: dict, pgn: int) -> ParseResult:
    """
    Parse a field and generate Lua code for proto declaration and tree add.
    
    Returns: (proto_fields, tree_nodes, fieldnames)
    """
    if "FieldType" not in field:
        print(f"WARNING: Missing FieldType for field {field.get('Id', '?')} in PGN {pgn}")
        return empty_result()
    
    ctx = FieldContext(field, pgn)
    field_type = ctx.field_type
    
    handler = FIELD_HANDLERS.get(field_type)
    if handler:
        return handler(ctx)
    
    # Unknown field type
    if field_type not in ("RESERVED", "SPARE"):
        warn_field(ctx, f"Unknown field type {field_type}")
    
    return empty_result()
