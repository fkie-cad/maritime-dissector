"""
Lua code generation utilities for NMEA 2000 Wireshark dissector.

This module provides builders and helpers for generating Lua code snippets
used in Wireshark protocol dissectors, including:
- ProtoField declarations
- Buffer operations (reads, length checks)
- Tree add operations
- Value manipulation (masking, scaling, sign extension)
"""

from typing import Optional, List
from enum import Enum


class DisplayBase(Enum):
    """Display base for numeric fields."""
    DEC = "DEC"
    HEX = "HEX"


def offset_expr(byte_offset: int, base_var: str = "str_offset") -> str:
    """Generate offset expression.
    
    Args:
        byte_offset: The byte offset from base
        base_var: The base variable name (default: "str_offset")
    
    Returns:
        Optimized offset expression string
    """
    if byte_offset == 0:
        return base_var
    return f"{base_var} + {byte_offset}"


class LuaFieldTypes:
    """Mapping from byte lengths to Lua ProtoField type names."""
    
    UNSIGNED = {1: "uint8", 2: "uint16", 3: "uint24", 4: "uint32", 8: "uint64"}
    SIGNED = {1: "int8", 2: "int16", 3: "int24", 4: "int32", 8: "int64"}
    
    @classmethod
    def get_int_type(cls, byte_length: int, signed: bool = False) -> Optional[str]:
        """Get the Lua ProtoField type for an integer of given byte length."""
        type_map = cls.SIGNED if signed else cls.UNSIGNED
        return type_map.get(byte_length)


# ============================================================================
# ProtoField Builders
# ============================================================================

class ProtoFieldBuilder:
    """Builder for Lua ProtoField declarations."""
    
    def __init__(self, pgn: int, field_id: str, label: str):
        self.pgn = pgn
        self.field_id = field_id
        self.label = label
    
    def _proto_name(self) -> str:
        return f"nmea-2000-{self.pgn}.{self.field_id}"
    
    def _base(self) -> str:
        """Generate local variable declaration prefix."""
        return f'local {self.field_id} = ProtoField'
    
    def integer(self, byte_length: int, signed: bool = False, 
                base: DisplayBase = DisplayBase.DEC, bitmask: Optional[str] = None) -> str:
        """Generate integer ProtoField (uint8, int16, etc.)."""
        field_type = LuaFieldTypes.get_int_type(byte_length, signed)
        if not field_type:
            field_type = "int32" if signed else "uint32"
        
        if bitmask:
            return f'{self._base()}.{field_type}("{self._proto_name()}", "{self.label}", base.{base.value}, NULL, {bitmask})'
        return f'{self._base()}.{field_type}("{self._proto_name()}", "{self.label}", base.{base.value})'
    
    def integer_simple(self, byte_length: int, signed: bool = False) -> str:
        """Generate integer ProtoField without display base (uses Wireshark default)."""
        field_type = LuaFieldTypes.get_int_type(byte_length, signed)
        if not field_type:
            field_type = "int32" if signed else "uint32"
        return f'{self._base()}.{field_type}("{self._proto_name()}", "{self.label}")'
    
    def int32(self, signed: bool = False) -> str:
        """Generate int32/uint32 ProtoField without base."""
        field_type = "int32" if signed else "uint32"
        return f'{self._base()}.{field_type}("{self._proto_name()}", "{self.label}")'
    
    def uint8_with_mask(self, bitmask: str) -> str:
        """Generate uint8 ProtoField with bitmask for sub-byte fields."""
        return f'{self._base()}.uint8("{self._proto_name()}", "{self.label}", base.DEC, NULL, {bitmask})'
    
    def uint8_simple(self) -> str:
        """Generate uint8 ProtoField without base or mask."""
        return f'{self._base()}.uint8("{self._proto_name()}", "{self.label}")'
    
    def uint32_computed(self, base: DisplayBase = DisplayBase.DEC) -> str:
        """Generate uint32 ProtoField for computed/masked values with display base."""
        return f'{self._base()}.uint32("{self._proto_name()}", "{self.label}", base.{base.value})'
    
    def uint32_no_base(self) -> str:
        """Generate uint32 ProtoField without display base (used for non byte-aligned LOOKUP)."""
        return f'{self._base()}.uint32("{self._proto_name()}", "{self.label}")'
    
    def uint_for_bits(self, bit_length: int, base: DisplayBase = DisplayBase.DEC) -> str:
        """Generate uint ProtoField sized appropriately for the bit length."""
        if bit_length <= 8:
            field_type = "uint8"
        elif bit_length <= 16:
            field_type = "uint16"
        elif bit_length <= 32:
            field_type = "uint32"
        else:
            field_type = "uint64"
        return f'{self._base()}.{field_type}("{self._proto_name()}", "{self.label}", base.{base.value})'
    
    def for_byte_length(self, byte_length: int) -> str:
        """Generate appropriately sized uint ProtoField for given byte length (no base)."""
        field_type = LuaFieldTypes.get_int_type(byte_length, signed=False)
        if not field_type:
            field_type = "uint32" if byte_length <= 4 else "uint64"
        return f'{self._base()}.{field_type}("{self._proto_name()}", "{self.label}")'
    
    def for_byte_length_with_base(self, byte_length: int, base: DisplayBase = DisplayBase.DEC) -> str:
        """Generate appropriately sized uint ProtoField for given byte length with display base."""
        field_type = LuaFieldTypes.get_int_type(byte_length, signed=False)
        if not field_type:
            field_type = "uint32" if byte_length <= 4 else "uint64"
        return f'{self._base()}.{field_type}("{self._proto_name()}", "{self.label}", base.{base.value})'
    
    def float(self) -> str:
        """Generate float ProtoField."""
        return f'{self._base()}.float("{self._proto_name()}", "{self.label}")'
    
    def string(self) -> str:
        """Generate string ProtoField."""
        return f'{self._base()}.string("{self._proto_name()}", "{self.label}")'
    
    def bytes(self) -> str:
        """Generate bytes ProtoField."""
        return f'{self._base()}.bytes("{self._proto_name()}", "{self.label}")'


# ============================================================================
# Buffer Operations
# ============================================================================

class BufferOps:
    """Generate Lua buffer read operations."""
    
    @staticmethod
    def length_check(offset_expr: str, length: int) -> str:
        """Generate buffer length check condition."""
        return f"buffer:len() >= ({offset_expr} + {length})"
    
    @staticmethod
    def read_uint(offset_expr: str, byte_length: int) -> str:
        """Generate unsigned integer read expression."""
        if byte_length == 1:
            return f"buffer({offset_expr}, 1):uint()"
        elif byte_length <= 4:
            return f"buffer({offset_expr}, {byte_length}):le_uint()"
        else:
            return f"buffer({offset_expr}, {byte_length}):le_uint64():tonumber()"
    
    @staticmethod
    def read_int(offset_expr: str, byte_length: int) -> str:
        """Generate signed integer read expression."""
        if byte_length == 1:
            return f"buffer({offset_expr}, 1):uint()"  # Need sign extension for 1 byte
        elif byte_length <= 4:
            return f"buffer({offset_expr}, {byte_length}):le_int()"
        else:
            return f"buffer({offset_expr}, {byte_length}):le_int64():tonumber()"
    
    @staticmethod
    def range_expr(offset_expr: str, length: int) -> str:
        """Generate buffer range expression."""
        return f"buffer({offset_expr}, {length})"


# ============================================================================
# Value Operations
# ============================================================================

class ValueOps:
    """Generate Lua value manipulation expressions."""
    
    @staticmethod
    def mask_bits(raw_var: str, bit_start: int, bit_length: int) -> str:
        """Generate bit masking expression."""
        return f"math.floor({raw_var} / (2 ^ {bit_start})) % (2 ^ {bit_length})"
    
    @staticmethod
    def sign_extend_lines(val_var: str, bit_length: int, indent: str = "    ") -> List[str]:
        """Generate sign extension code for signed bit fields."""
        return [
            f"{indent}if {val_var} >= 2 ^ ({bit_length} - 1) then",
            f"{indent}    {val_var} = {val_var} - 2 ^ {bit_length}",
            f"{indent}end"
        ]
    
    @staticmethod
    def scale(val_var: str, resolution) -> str:
        """Generate scaling expression."""
        return f"{val_var} * {resolution}"


# ============================================================================
# Tree Add Operations
# ============================================================================

class TreeAddBuilder:
    """Builder for Lua tree:add operations."""
    
    @staticmethod
    def add_simple(field_id: str, buffer_expr: str, use_le: bool = False) -> str:
        """Generate simple tree add."""
        func = "add_le" if use_le else "add"
        return f"subtree:{func}({field_id}, {buffer_expr})"
    
    @staticmethod
    def add_with_value(field_id: str, buffer_expr: str, value_expr: str) -> str:
        """Generate tree add with explicit value."""
        return f"subtree:add({field_id}, {buffer_expr}, {value_expr})"
    
    @staticmethod
    def add_mmsi(field_id: str, buffer_expr: str, value_var: str) -> List[str]:
        """Generate tree add with MMSI formatting."""
        return [
            f"local _ti = subtree:add({field_id}, {buffer_expr}, {value_var})",
            f'_ti:append_text(string.format(" (%09d)", {value_var}))'
        ]


# ============================================================================
# Parsing Builders
# ============================================================================

class SequentialParseBuilder:
    """Builder for sequential/cursor-based field parsing."""
    
    def __init__(self, offset_var: str = "str_offset"):
        self.offset_var = offset_var
    
    def _offset_expr(self, additional: int = 0) -> str:
        """Return cursor expression for length checks."""
        return offset_expr(additional, self.offset_var)
    
    def _offset_expr_simple(self, byte_offset: int) -> str:
        """Return cursor expression for buffer access."""
        return offset_expr(byte_offset, self.offset_var)
    
    def parse_fixed_int(self, field_id: str, byte_length: int, 
                        signed: bool = False, scale: Optional[float] = None,
                        mmsi_format: bool = False) -> str:
        """Generate code to parse a fixed-size integer at current offset."""
        lines = []
        check = BufferOps.length_check(self.offset_var, byte_length)
        buf_expr = f"buffer({self.offset_var}, {byte_length})"
        
        lines.append(f"if {check} then")
        
        if mmsi_format:
            read_expr = BufferOps.read_uint(self.offset_var, byte_length)
            lines.append(f"    local {field_id}_val = {read_expr}")
            lines.extend(["    " + ln for ln in TreeAddBuilder.add_mmsi(field_id, buf_expr, f"{field_id}_val")])
        elif scale:
            read_expr = BufferOps.read_int(self.offset_var, byte_length) if signed else BufferOps.read_uint(self.offset_var, byte_length)
            lines.append(f"    {TreeAddBuilder.add_with_value(field_id, buf_expr, f'{read_expr} * {scale}')}")
        else:
            use_le = byte_length > 1
            lines.append(f"    {TreeAddBuilder.add_simple(field_id, buf_expr, use_le)}")
        
        lines.append(f"    {self.offset_var} = {self.offset_var} + {byte_length}")
        lines.append("end")
        
        return "\n".join(lines)
    
    def parse_masked_value(self, field_id: str, byte_length: int, bit_start: int,
                           bit_length: int, signed: bool = False, 
                           scale: Optional[float] = None) -> str:
        """Generate code to parse a masked/bitfield value at current offset."""
        lines = []
        check = BufferOps.length_check(self.offset_var, byte_length)
        
        lines.append(f"if {check} then")
        lines.append(f"    local _rng = buffer({self.offset_var}, {byte_length})")
        lines.append("    local _raw = _rng:le_uint()")
        lines.append(f"    local _val = {ValueOps.mask_bits('_raw', bit_start, bit_length)}")
        
        if signed:
            lines.extend(ValueOps.sign_extend_lines("_val", bit_length))
        
        if scale:
            lines.append(f"    {TreeAddBuilder.add_with_value(field_id, '_rng', f'_val * {scale}')}")
        else:
            lines.append(f"    {TreeAddBuilder.add_with_value(field_id, '_rng', '_val')}")
        
        lines.append(f"    {self.offset_var} = {self.offset_var} + {byte_length}")
        lines.append("end")
        
        return "\n".join(lines)
    
    def parse_string_lau(self, field_id: str, byte_offset: int = 0) -> str:
        """Generate STRING_LAU parsing (length-prefixed with encoding byte)."""
        off = self._offset_expr(byte_offset)
        cursor_advance = self._offset_expr_simple(byte_offset)
        return f"""if buffer:len() >= ({off} + 1) then
    length = buffer({off}, 1):uint() - 2
    if length and length >= 0 and buffer:len() >= ({off} + 2 + length) then
        -- type = buffer({off} + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
        subtree:add({field_id}, buffer({off} + 2, length))
        {self.offset_var} = {cursor_advance} + length + 2
    end
end"""
    
    def parse_string_lz(self, field_id: str, byte_offset: int = 0) -> str:
        """Generate STRING_LZ parsing (length byte + data + null)."""
        off = self._offset_expr(byte_offset)
        return f"""if buffer:len() >= ({off} + 1) then
    length = buffer({off}, 1):uint()
    if length > 0 then
        if buffer:len() >= ({off} + 1 + length + 1) then
            subtree:add({field_id}, buffer({off} + 1, length))
            {self.offset_var} = {self.offset_var} + length + 2  -- length byte + string + zero terminator
        end
    else
        if buffer:len() >= ({off} + 2) then
            {self.offset_var} = {self.offset_var} + 2  -- just length byte + zero terminator
        end
    end
end"""
    
    def parse_string_fixed(self, field_id: str, byte_length: int, 
                           strip_padding: bool = True) -> str:
        """Generate fixed-length string parsing."""
        check = BufferOps.length_check(self.offset_var, byte_length)
        buf_expr = f"buffer({self.offset_var}, {byte_length})"
        
        if strip_padding:
            return f"""if {check} then
    local _{field_id}_raw = {buf_expr}:string()
    local _{field_id}_clean = _{field_id}_raw:gsub("[%s@%z\\xff]+$", "")
    subtree:add({field_id}, {buf_expr}, _{field_id}_clean)
    {self.offset_var} = {self.offset_var} + {byte_length}
end"""
        return f"""if {check} then
    subtree:add({field_id}, {buf_expr})
    {self.offset_var} = {self.offset_var} + {byte_length}
end"""
    
    def parse_binary(self, field_id: str, byte_length: int) -> str:
        """Generate fixed-length binary parsing."""
        check = BufferOps.length_check(self.offset_var, byte_length)
        return f"""if {check} then
    subtree:add({field_id}, buffer({self.offset_var}, {byte_length}))
    {self.offset_var} = {self.offset_var} + {byte_length}
end"""
    
    def parse_binary_rest(self, field_id: str) -> str:
        """Generate parsing for remaining buffer as binary."""
        return f"""local _rem = buffer:len() - {self.offset_var}
if _rem > 0 then
    subtree:add({field_id}, buffer({self.offset_var}, _rem))
    {self.offset_var} = {self.offset_var} + _rem
end"""
    
    def advance(self, byte_count: int, comment: str = "") -> str:
        """Generate offset advancement."""
        cmt = f"  -- {comment}" if comment else ""
        return f"{self.offset_var} = {self.offset_var} + {byte_count}{cmt}"


class BitfieldParseBuilder:
    """Builder for sequential bitfield parsing using bitfield_offset tracking."""
    
    def __init__(self, str_offset_var: str = "str_offset", 
                 bitfield_offset_var: str = "bitfield_offset"):
        self.str_offset = str_offset_var
        self.bitfield_offset = bitfield_offset_var
    
    def parse_bitfield(self, field_id: str, bit_length: int, signed: bool = False) -> str:
        """Generate code to parse a bitfield at current bitfield offset."""
        sign_check = "true" if signed else "false"
        return f"""do
    local _bit_len = {bit_length}
    local _bit_byte = math.floor({self.bitfield_offset} / 8)
    local _bit_start = {self.bitfield_offset} % 8
    local _bytes = math.floor((_bit_start + _bit_len + 7) / 8)
    if buffer:len() >= ({self.str_offset} + _bit_byte + _bytes) then
        local _rng = buffer({self.str_offset} + _bit_byte, _bytes)
        local _raw
        if _bytes <= 4 then
            _raw = _rng:le_uint()
        else
            _raw = _rng:le_uint64():tonumber()
        end
        local _val = math.floor(_raw / (2 ^ _bit_start)) % (2 ^ _bit_len)
        if {sign_check} and _bit_len > 0 then
            local _sign_bit = 2 ^ (_bit_len - 1)
            if _val >= _sign_bit then
                _val = _val - 2 ^ _bit_len
            end
        end
        subtree:add({field_id}, _rng, _val)
        {self.bitfield_offset} = {self.bitfield_offset} + _bit_len
        {self.str_offset} = {self.str_offset} + math.floor({self.bitfield_offset} / 8)
        {self.bitfield_offset} = {self.bitfield_offset} % 8
    end
end"""


class FixedOffsetParseBuilder:
    """Builder for fixed-offset field parsing (when BitOffset is known)."""
    
    def __init__(self, base_offset_var: str = "str_offset"):
        self.base_offset = base_offset_var
    
    def _offset_expr(self, byte_offset: int) -> str:
        """Build offset expression using module-level helper."""
        return offset_expr(byte_offset, self.base_offset)
    
    def parse_int_aligned(self, field_id: str, byte_offset: int, byte_length: int,
                          signed: bool = False, scale: Optional[float] = None,
                          mmsi_format: bool = False) -> str:
        """Parse a byte-aligned integer at fixed offset."""
        offset_expr = self._offset_expr(byte_offset)
        check = BufferOps.length_check(offset_expr, byte_length)
        buf_expr = BufferOps.range_expr(offset_expr, byte_length)
        
        lines = [f"if {check} then"]
        
        if mmsi_format:
            read_expr = BufferOps.read_uint(offset_expr, byte_length)
            lines.append(f"    local {field_id}_val = {read_expr}")
            lines.extend(["    " + ln for ln in TreeAddBuilder.add_mmsi(field_id, buf_expr, f"{field_id}_val")])
        elif scale:
            read_expr = BufferOps.read_int(offset_expr, byte_length) if signed else BufferOps.read_uint(offset_expr, byte_length)
            lines.append(f"    {TreeAddBuilder.add_with_value(field_id, buf_expr, f'{read_expr} * {scale}')}")
        else:
            use_le = byte_length > 1
            lines.append(f"    {TreeAddBuilder.add_simple(field_id, buf_expr, use_le)}")
        
        lines.append("end")
        return "\n".join(lines)
    
    def parse_masked_value(self, field_id: str, byte_offset: int, bit_start: int,
                           bit_length: int, local_bytes: int, signed: bool = False,
                           scale: Optional[float] = None, wrap_in_do: bool = False) -> str:
        """Parse a masked/bitfield value at fixed offset.
        
        This is the common pattern used for LOOKUP, BITLOOKUP, non-aligned integers, etc.
        """
        offset_expr = self._offset_expr(byte_offset)
        check = BufferOps.length_check(offset_expr, local_bytes)
        
        lines = []
        indent = "    "
        
        if wrap_in_do:
            lines.append("do")
        
        lines.append(f"if {check} then")
        lines.append(f"{indent}local _rng = buffer({offset_expr}, {local_bytes})")
        lines.append(f"{indent}local _raw = _rng:le_uint()")
        lines.append(f"{indent}local _val = {ValueOps.mask_bits('_raw', bit_start, bit_length)}")
        
        if signed:
            lines.extend([indent + ln.lstrip() for ln in ValueOps.sign_extend_lines("_val", bit_length, "")])
        
        if scale:
            lines.append(f"{indent}{TreeAddBuilder.add_with_value(field_id, '_rng', f'_val * {scale}')}")
        else:
            lines.append(f"{indent}{TreeAddBuilder.add_with_value(field_id, '_rng', '_val')}")
        
        lines.append("end")
        
        if wrap_in_do:
            lines.append("end")
        
        return "\n".join(lines)
    
    def parse_lookup_with_mask(self, field_id: str, byte_offset: int) -> str:
        """Parse a lookup field that uses ProtoField bitmask."""
        offset_expr = self._offset_expr(byte_offset)
        check = BufferOps.length_check(offset_expr, 1)
        return f"""if {check} then
    subtree:add({field_id}, buffer({offset_expr}, 1))
end"""
    
    def parse_string_fixed(self, field_id: str, byte_offset: int, byte_length: int,
                           strip_padding: bool = True) -> str:
        """Parse a fixed-length string."""
        offset_expr = self._offset_expr(byte_offset)
        check = BufferOps.length_check(offset_expr, byte_length)
        buf_expr = BufferOps.range_expr(offset_expr, byte_length)
        
        if strip_padding:
            return f"""if {check} then
    local _{field_id}_raw = {buf_expr}:string()
    local _{field_id}_clean = _{field_id}_raw:gsub("[%s@%z\\xff]+$", "")
    subtree:add({field_id}, {buf_expr}, _{field_id}_clean)
end"""
        return f"""if {check} then
    subtree:add({field_id}, {buf_expr})
end"""
    
    def parse_binary(self, field_id: str, byte_offset: int, byte_length: int) -> str:
        """Parse fixed-length binary data."""
        offset_expr = self._offset_expr(byte_offset)
        check = BufferOps.length_check(offset_expr, byte_length)
        return f"""if {check} then
    subtree:add({field_id}, buffer({offset_expr}, {byte_length}))
end"""
    
    def parse_float(self, field_id: str, byte_offset: int, byte_length: int = 4) -> str:
        """Parse a float value."""
        offset_expr = self._offset_expr(byte_offset)
        check = BufferOps.length_check(offset_expr, byte_length)
        return f"""if {check} then
    subtree:add_le({field_id}, buffer({offset_expr}, {byte_length}))
end"""
    
    def parse_simple(self, field_id: str, byte_offset: int, byte_length: int,
                     use_le: bool = True) -> str:
        """Parse a simple field with no value transformation."""
        offset_expr = self._offset_expr(byte_offset)
        check = BufferOps.length_check(offset_expr, byte_length)
        add_func = "add_le" if use_le and byte_length > 1 else "add"
        return f"""if {check} then
    subtree:{add_func}({field_id}, buffer({offset_expr}, {byte_length}))
end"""


# ============================================================================
# Cursor-based Parsing (for repeating fields)
# ============================================================================

class CursorParseBuilder:
    """Builder for cursor-based field parsing used in repeating field sets."""
    
    def __init__(self, cursor_var: str = "cursor"):
        self.cursor = cursor_var
    
    def parse_numeric(self, field_id: str, byte_length: int, bit_length: int,
                      signed: bool = False, scale: Optional[float] = None) -> str:
        """Generate numeric field parsing with cursor advancement."""
        check = BufferOps.length_check(self.cursor, byte_length)
        
        # Determine read expression
        if byte_length == 1:
            raw_expr = f"buffer({self.cursor}, 1):uint()"
        elif byte_length == 8:
            raw_expr = f"buffer({self.cursor}, 8):le_int64():tonumber()" if signed else f"buffer({self.cursor}, 8):le_uint64():tonumber()"
        elif byte_length <= 4:
            raw_expr = f"buffer({self.cursor}, {byte_length}):le_int()" if signed else f"buffer({self.cursor}, {byte_length}):le_uint()"
        else:
            raw_expr = f"buffer({self.cursor}, {byte_length}):le_uint64():tonumber()"
        
        lines = [f"if {check} then"]
        
        needs_val = scale or (bit_length % 8 != 0)
        if needs_val:
            lines.append(f"    local _val = {raw_expr}")
            if bit_length % 8 != 0:
                lines.append(f"    _val = _val % (2 ^ {bit_length})")
                if signed:
                    lines.append(f"    if _val >= 2 ^ ({bit_length} - 1) then _val = _val - 2 ^ {bit_length} end")
            if scale:
                lines.append(f"    subtree:add({field_id}, buffer({self.cursor}, {byte_length}), _val * {scale})")
            else:
                lines.append(f"    subtree:add({field_id}, buffer({self.cursor}, {byte_length}), _val)")
        else:
            add_func = "add_le" if byte_length > 1 else "add"
            lines.append(f"    subtree:{add_func}({field_id}, buffer({self.cursor}, {byte_length}))")
        
        lines.append(f"    {self.cursor} = {self.cursor} + {byte_length}")
        lines.append("end")
        
        return "\n".join(lines)
    
    def parse_lookup(self, field_id: str, byte_length: int) -> str:
        """Generate lookup field parsing."""
        check = BufferOps.length_check(self.cursor, byte_length)
        add_func = "add_le" if byte_length > 1 else "add"
        return f"""if {check} then
    subtree:{add_func}({field_id}, buffer({self.cursor}, {byte_length}))
    {self.cursor} = {self.cursor} + {byte_length}
end"""
    
    def parse_string_fix(self, field_id: str, byte_length: int) -> str:
        """Generate fixed string parsing."""
        check = BufferOps.length_check(self.cursor, byte_length)
        return f"""if {check} then
    subtree:add({field_id}, buffer({self.cursor}, {byte_length}))
    {self.cursor} = {self.cursor} + {byte_length}
end"""
    
    def parse_string_lau(self, field_id: str) -> str:
        """Generate STRING_LAU parsing."""
        return f"""if buffer:len() > {self.cursor} then
    local _{field_id}_len = buffer({self.cursor}, 1):uint()
    if _{field_id}_len >= 2 and buffer:len() >= ({self.cursor} + _{field_id}_len) then
        subtree:add({field_id}, buffer({self.cursor} + 2, _{field_id}_len - 2))
        {self.cursor} = {self.cursor} + _{field_id}_len
    elseif _{field_id}_len == 0 or _{field_id}_len == 1 then
        {self.cursor} = {self.cursor} + math.max(1, _{field_id}_len)  -- empty string
    else
        {self.cursor} = {self.cursor} + 1  -- malformed, skip length byte
    end
end"""
    
    def parse_string_lz(self, field_id: str) -> str:
        """Generate STRING_LZ parsing (null-terminated)."""
        return f"""do
    local _{field_id}_start = {self.cursor}
    local _{field_id}_end = _{field_id}_start
    while _{field_id}_end < buffer:len() and buffer(_{field_id}_end, 1):uint() ~= 0 do
        _{field_id}_end = _{field_id}_end + 1
    end
    if _{field_id}_end > _{field_id}_start then
        subtree:add({field_id}, buffer(_{field_id}_start, _{field_id}_end - _{field_id}_start))
    end
    {self.cursor} = _{field_id}_end + 1  -- skip null terminator
end"""
    
    def parse_float(self, field_id: str, byte_length: int = 4) -> str:
        """Generate float parsing."""
        check = BufferOps.length_check(self.cursor, byte_length)
        return f"""if {check} then
    subtree:add_le({field_id}, buffer({self.cursor}, {byte_length}))
    {self.cursor} = {self.cursor} + {byte_length}
end"""
    
    def parse_binary(self, field_id: str, byte_length: Optional[int] = None) -> str:
        """Generate binary parsing."""
        if byte_length is None:
            # Rest of buffer
            return f"""local _rem = buffer:len() - {self.cursor}
if _rem > 0 then
    subtree:add({field_id}, buffer({self.cursor}, _rem))
    {self.cursor} = {self.cursor} + _rem
end"""
        check = BufferOps.length_check(self.cursor, byte_length)
        return f"""if {check} then
    subtree:add({field_id}, buffer({self.cursor}, {byte_length}))
    {self.cursor} = {self.cursor} + {byte_length}
end"""
    
    def skip(self, byte_count: int, comment: str = "") -> str:
        """Generate cursor skip."""
        cmt = f"  -- {comment}" if comment else ""
        return f"{self.cursor} = {self.cursor} + {byte_count}{cmt}"


# ============================================================================
# Utility Functions
# ============================================================================

def get_bitmask(length: int, offset: int) -> str:
    """Calculate bitmask for a field (little-endian style)."""
    mask = 0x00
    for _ in range(length):
        mask = (mask << 1) | 0x01
    for _ in range(offset):
        mask = mask << 1
    return hex(mask)


def field_label(field: dict) -> str:
    """Build display label for a field (name with optional unit)."""
    name = field.get("Name") or field.get("Id") or ""
    unit = field.get("Unit")
    if unit:
        return f"{name} ({unit})"
    return name


def safe_int(value) -> Optional[int]:
    """Safely convert a value to int, returning None on failure."""
    try:
        if value is None:
            return None
        return int(value)
    except (TypeError, ValueError):
        return None
