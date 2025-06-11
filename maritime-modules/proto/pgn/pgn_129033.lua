-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129033 = Proto("nmea-2000-129033", "Time & Date (129033)")
local date = ProtoField.float("nmea-2000-129033.date", "Date (d)")
local time = ProtoField.float("nmea-2000-129033.time", "Time (s)")
local localOffset = ProtoField.float("nmea-2000-129033.localOffset", "Local Offset (s)")

NMEA_2000_129033.fields = {date,time,localOffset}

function NMEA_2000_129033.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129033 (Time & Date)"
    local subtree = tree:add(NMEA_2000_129033, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(date, buffer(str_offset + 0, 2), buffer(str_offset + 0, 2):le_uint() * 1)
    subtree:add(time, buffer(str_offset + 2, 4), buffer(str_offset + 2, 4):le_uint() * 0.0001)
    subtree:add(localOffset, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_int() * 60)
end

return NMEA_2000_129033
