-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127744 = Proto("nmea-2000-127744", "AC Power / Current - Phase A (127744)")
local sid = ProtoField.uint8("nmea-2000-127744.sid", "SID")
local connectionNumber = ProtoField.uint8("nmea-2000-127744.connectionNumber", "Connection Number")
local acRmsCurrent = ProtoField.float("nmea-2000-127744.acRmsCurrent", "AC RMS Current (A)")
local power = ProtoField.int32("nmea-2000-127744.power", "Power (W)")

NMEA_2000_127744.fields = {sid,connectionNumber,acRmsCurrent,power}

function NMEA_2000_127744.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127744 (AC Power / Current - Phase A)"
    local subtree = tree:add(NMEA_2000_127744, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sid, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(connectionNumber, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add(acRmsCurrent, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 0.1)
    end
    if buffer:len() >= (str_offset + 4 + 4) then
        subtree:add_le(power, buffer(str_offset + 4, 4))
    end
end

return NMEA_2000_127744
