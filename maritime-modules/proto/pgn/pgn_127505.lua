-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127505 = Proto("nmea-2000-127505", "Fluid Level (127505)")
local type = ProtoField.uint8("nmea-2000-127505.type", "Type", base.DEC, NULL, 0xf0)
local level = ProtoField.float("nmea-2000-127505.level", "Level (%)")
local capacity = ProtoField.float("nmea-2000-127505.capacity", "Capacity (L)")

NMEA_2000_127505.fields = {type,level,capacity}

function NMEA_2000_127505.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127505 (Fluid Level)"
    local subtree = tree:add(NMEA_2000_127505, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(type, buffer(str_offset + 0, 1))
    subtree:add(level, buffer(str_offset + 1, 2), buffer(str_offset + 1, 2):le_int() * 0.004)
    subtree:add(capacity, buffer(str_offset + 3, 4), buffer(str_offset + 3, 4):le_uint() * 0.1)
end

return NMEA_2000_127505
