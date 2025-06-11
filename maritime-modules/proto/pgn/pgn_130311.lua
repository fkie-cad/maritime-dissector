-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130311 = Proto("nmea-2000-130311", "Environmental Parameters (130311)")
local sid = ProtoField.float("nmea-2000-130311.sid", "SID")
local temperatureSource = ProtoField.uint8("nmea-2000-130311.temperatureSource", "Temperature Source", base.DEC, NULL, 0x3f)
local humiditySource = ProtoField.uint8("nmea-2000-130311.humiditySource", "Humidity Source", base.DEC, NULL, 0xc0)
local temperature = ProtoField.float("nmea-2000-130311.temperature", "Temperature (K)")
local humidity = ProtoField.float("nmea-2000-130311.humidity", "Humidity (%)")
local atmosphericPressure = ProtoField.float("nmea-2000-130311.atmosphericPressure", "Atmospheric Pressure (Pa)")

NMEA_2000_130311.fields = {sid,temperatureSource,humiditySource,temperature,humidity,atmosphericPressure}

function NMEA_2000_130311.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130311 (Environmental Parameters)"
    local subtree = tree:add(NMEA_2000_130311, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(temperatureSource, buffer(str_offset + 1, 1))
    subtree:add(humiditySource, buffer(str_offset + 1, 1))
    subtree:add(temperature, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 0.01)
    subtree:add(humidity, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_int() * 0.004)
    subtree:add(atmosphericPressure, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 100)
end

return NMEA_2000_130311
