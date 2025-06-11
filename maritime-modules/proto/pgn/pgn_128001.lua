-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128001 = Proto("nmea-2000-128001", "Vessel Acceleration (128001)")
local sid = ProtoField.float("nmea-2000-128001.sid", "SID")
local longitudinalAcceleration = ProtoField.float("nmea-2000-128001.longitudinalAcceleration", "Longitudinal Acceleration")
local transverseAcceleration = ProtoField.float("nmea-2000-128001.transverseAcceleration", "Transverse Acceleration")
local verticalAcceleration = ProtoField.float("nmea-2000-128001.verticalAcceleration", "Vertical Acceleration")

NMEA_2000_128001.fields = {sid,longitudinalAcceleration,transverseAcceleration,verticalAcceleration}

function NMEA_2000_128001.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128001 (Vessel Acceleration)"
    local subtree = tree:add(NMEA_2000_128001, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(longitudinalAcceleration, buffer(str_offset + 1, 2), buffer(str_offset + 1, 2):le_int() * 1)
    subtree:add(transverseAcceleration, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_int() * 1)
    subtree:add(verticalAcceleration, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_int() * 1)
end

return NMEA_2000_128001
