-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127488 = Proto("nmea-2000-127488", "Engine Parameters, Rapid Update (127488)")
local instance = ProtoField.uint8("nmea-2000-127488.instance", "Instance", base.DEC, NULL, 0xff)
local speed = ProtoField.float("nmea-2000-127488.speed", "Speed (rpm)")
local boostPressure = ProtoField.float("nmea-2000-127488.boostPressure", "Boost Pressure (Pa)")
local tiltTrim = ProtoField.float("nmea-2000-127488.tiltTrim", "Tilt/Trim (%)")

NMEA_2000_127488.fields = {instance,speed,boostPressure,tiltTrim}

function NMEA_2000_127488.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127488 (Engine Parameters, Rapid Update)"
    local subtree = tree:add(NMEA_2000_127488, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(instance, buffer(str_offset + 0, 1))
    subtree:add(speed, buffer(str_offset + 1, 2), buffer(str_offset + 1, 2):le_uint() * 0.25)
    subtree:add(boostPressure, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_uint() * 100)
    subtree:add(tiltTrim, buffer(str_offset + 5, 1), buffer(str_offset + 5, 1):le_int() * 1)
end

return NMEA_2000_127488
