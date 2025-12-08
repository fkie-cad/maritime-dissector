-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128275 = Proto("nmea-2000-128275", "Distance Log (128275)")
local date = ProtoField.uint16("nmea-2000-128275.date", "Date (d)")
local time = ProtoField.float("nmea-2000-128275.time", "Time (s)")
local log = ProtoField.uint32("nmea-2000-128275.log", "Log (m)")
local tripLog = ProtoField.uint32("nmea-2000-128275.tripLog", "Trip Log (m)")

NMEA_2000_128275.fields = {date,time,log,tripLog}

function NMEA_2000_128275.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128275 (Distance Log)"
    local subtree = tree:add(NMEA_2000_128275, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 2) then
        subtree:add_le(date, buffer(str_offset, 2))
    end
    if buffer:len() >= (str_offset + 2 + 4) then
        subtree:add(time, buffer(str_offset + 2, 4), buffer(str_offset + 2, 4):le_uint() * 0.0001)
    end
    if buffer:len() >= (str_offset + 6 + 4) then
        subtree:add_le(log, buffer(str_offset + 6, 4))
    end
    if buffer:len() >= (str_offset + 10 + 4) then
        subtree:add_le(tripLog, buffer(str_offset + 10, 4))
    end
end

return NMEA_2000_128275
