-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_126992 = Proto("nmea-2000-126992", "System Time (126992)")
local sid = ProtoField.float("nmea-2000-126992.sid", "SID")
local source = ProtoField.uint8("nmea-2000-126992.source", "Source", base.DEC, NULL, 0xf)
local date = ProtoField.float("nmea-2000-126992.date", "Date (d)")
local time = ProtoField.float("nmea-2000-126992.time", "Time (s)")

NMEA_2000_126992.fields = {sid,source,date,time}

function NMEA_2000_126992.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 126992 (System Time)"
    local subtree = tree:add(NMEA_2000_126992, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(source, buffer(str_offset + 1, 1))
    subtree:add(date, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 1)
    subtree:add(time, buffer(str_offset + 4, 4), buffer(str_offset + 4, 4):le_uint() * 0.0001)
end

return NMEA_2000_126992
