-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128267 = Proto("nmea-2000-128267", "Water Depth (128267)")
local sid = ProtoField.float("nmea-2000-128267.sid", "SID")
local depth = ProtoField.float("nmea-2000-128267.depth", "Depth (m)")
local offset = ProtoField.float("nmea-2000-128267.offset", "Offset (m)")
local range = ProtoField.float("nmea-2000-128267.range", "Range (m)")

NMEA_2000_128267.fields = {sid,depth,offset,range}

function NMEA_2000_128267.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128267 (Water Depth)"
    local subtree = tree:add(NMEA_2000_128267, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(depth, buffer(str_offset + 1, 4), buffer(str_offset + 1, 4):le_uint() * 0.01)
    subtree:add(offset, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_int() * 0.001)
    subtree:add(range, buffer(str_offset + 7, 1), buffer(str_offset + 7, 1):le_uint() * 10)
end

return NMEA_2000_128267
