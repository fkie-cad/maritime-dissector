-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128001 = Proto("nmea-2000-128001", "Vessel Acceleration (128001)")
local sid = ProtoField.uint8("nmea-2000-128001.sid", "SID")
local longitudinalAcceleration = ProtoField.int16("nmea-2000-128001.longitudinalAcceleration", "Longitudinal Acceleration")
local transverseAcceleration = ProtoField.int16("nmea-2000-128001.transverseAcceleration", "Transverse Acceleration")
local verticalAcceleration = ProtoField.int16("nmea-2000-128001.verticalAcceleration", "Vertical Acceleration")

NMEA_2000_128001.fields = {sid,longitudinalAcceleration,transverseAcceleration,verticalAcceleration}

function NMEA_2000_128001.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128001 (Vessel Acceleration)"
    local subtree = tree:add(NMEA_2000_128001, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sid, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 2) then
        subtree:add_le(longitudinalAcceleration, buffer(str_offset + 1, 2))
    end
    if buffer:len() >= (str_offset + 3 + 2) then
        subtree:add_le(transverseAcceleration, buffer(str_offset + 3, 2))
    end
    if buffer:len() >= (str_offset + 5 + 2) then
        subtree:add_le(verticalAcceleration, buffer(str_offset + 5, 2))
    end
end

return NMEA_2000_128001
