-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127745 = Proto("nmea-2000-127745", "AC Power / Current - Phase B (127745)")
local sid = ProtoField.float("nmea-2000-127745.sid", "SID")
local connectionNumber = ProtoField.float("nmea-2000-127745.connectionNumber", "Connection Number")
local acRmsCurrent = ProtoField.float("nmea-2000-127745.acRmsCurrent", "AC RMS Current (A)")
local power = ProtoField.float("nmea-2000-127745.power", "Power (W)")

NMEA_2000_127745.fields = {sid,connectionNumber,acRmsCurrent,power}

function NMEA_2000_127745.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127745 (AC Power / Current - Phase B)"
    local subtree = tree:add(NMEA_2000_127745, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(connectionNumber, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(acRmsCurrent, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 0.1)
    subtree:add(power, buffer(str_offset + 4, 4), buffer(str_offset + 4, 4):le_int() * 1)
end

return NMEA_2000_127745
