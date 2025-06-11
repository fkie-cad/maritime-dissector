-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127250 = Proto("nmea-2000-127250", "Vessel Heading (127250)")
local sid = ProtoField.float("nmea-2000-127250.sid", "SID")
local heading = ProtoField.float("nmea-2000-127250.heading", "Heading (rad)")
local deviation = ProtoField.float("nmea-2000-127250.deviation", "Deviation (rad)")
local variation = ProtoField.float("nmea-2000-127250.variation", "Variation (rad)")
local reference = ProtoField.uint8("nmea-2000-127250.reference", "Reference", base.DEC, NULL, 0x3)

NMEA_2000_127250.fields = {sid,heading,deviation,variation,reference}

function NMEA_2000_127250.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127250 (Vessel Heading)"
    local subtree = tree:add(NMEA_2000_127250, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(heading, buffer(str_offset + 1, 2), buffer(str_offset + 1, 2):le_uint() * 0.0001)
    subtree:add(deviation, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_int() * 0.0001)
    subtree:add(variation, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_int() * 0.0001)
    subtree:add(reference, buffer(str_offset + 7, 1))
end

return NMEA_2000_127250
