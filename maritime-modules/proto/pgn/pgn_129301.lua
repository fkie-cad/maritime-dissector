-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129301 = Proto("nmea-2000-129301", "Navigation - Route / Time to+from Mark (129301)")
local sid = ProtoField.float("nmea-2000-129301.sid", "SID")
local timeToMark = ProtoField.float("nmea-2000-129301.timeToMark", "Time to mark (s)")
local markType = ProtoField.uint8("nmea-2000-129301.markType", "Mark Type", base.DEC, NULL, 0xf)
local markId = ProtoField.float("nmea-2000-129301.markId", "Mark ID")

NMEA_2000_129301.fields = {sid,timeToMark,markType,markId}

function NMEA_2000_129301.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129301 (Navigation - Route / Time to+from Mark)"
    local subtree = tree:add(NMEA_2000_129301, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(timeToMark, buffer(str_offset + 1, 4), buffer(str_offset + 1, 4):le_int() * 0.001)
    subtree:add(markType, buffer(str_offset + 5, 1))
    subtree:add(markId, buffer(str_offset + 6, 4), buffer(str_offset + 6, 4):le_uint() * 1)
end

return NMEA_2000_129301
