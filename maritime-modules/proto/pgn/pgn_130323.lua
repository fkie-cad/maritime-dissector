-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130323 = Proto("nmea-2000-130323", "Meteorological Station Data (130323)")
local mode = ProtoField.uint8("nmea-2000-130323.mode", "Mode", base.DEC, NULL, 0xf)
local measurementDate = ProtoField.float("nmea-2000-130323.measurementDate", "Measurement Date (d)")
local measurementTime = ProtoField.float("nmea-2000-130323.measurementTime", "Measurement Time (s)")
local stationLatitude = ProtoField.float("nmea-2000-130323.stationLatitude", "Station Latitude (deg)")
local stationLongitude = ProtoField.float("nmea-2000-130323.stationLongitude", "Station Longitude (deg)")
local windSpeed = ProtoField.float("nmea-2000-130323.windSpeed", "Wind Speed (m/s)")
local windDirection = ProtoField.float("nmea-2000-130323.windDirection", "Wind Direction (rad)")
local windReference = ProtoField.uint8("nmea-2000-130323.windReference", "Wind Reference", base.DEC, NULL, 0x7)
local windGusts = ProtoField.float("nmea-2000-130323.windGusts", "Wind Gusts (m/s)")
local atmosphericPressure = ProtoField.float("nmea-2000-130323.atmosphericPressure", "Atmospheric Pressure (Pa)")
local ambientTemperature = ProtoField.float("nmea-2000-130323.ambientTemperature", "Ambient Temperature (K)")
local stationId = ProtoField.string("nmea-2000-130323.stationId", "Station ID")
local stationName = ProtoField.string("nmea-2000-130323.stationName", "Station Name")

NMEA_2000_130323.fields = {mode,measurementDate,measurementTime,stationLatitude,stationLongitude,windSpeed,windDirection,windReference,windGusts,atmosphericPressure,ambientTemperature,stationId,stationName}

function NMEA_2000_130323.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130323 (Meteorological Station Data)"
    local subtree = tree:add(NMEA_2000_130323, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(mode, buffer(str_offset + 0, 1))
    subtree:add(measurementDate, buffer(str_offset + 1, 2), buffer(str_offset + 1, 2):le_uint() * 1)
    subtree:add(measurementTime, buffer(str_offset + 3, 4), buffer(str_offset + 3, 4):le_uint() * 0.0001)
    subtree:add(stationLatitude, buffer(str_offset + 7, 4), buffer(str_offset + 7, 4):le_int() * 1e-07)
    subtree:add(stationLongitude, buffer(str_offset + 11, 4), buffer(str_offset + 11, 4):le_int() * 1e-07)
    subtree:add(windSpeed, buffer(str_offset + 15, 2), buffer(str_offset + 15, 2):le_uint() * 0.01)
    subtree:add(windDirection, buffer(str_offset + 17, 2), buffer(str_offset + 17, 2):le_uint() * 0.0001)
    subtree:add(windReference, buffer(str_offset + 19, 1))
    subtree:add(windGusts, buffer(str_offset + 20, 2), buffer(str_offset + 20, 2):le_uint() * 0.01)
    subtree:add(atmosphericPressure, buffer(str_offset + 22, 2), buffer(str_offset + 22, 2):le_uint() * 100)
    subtree:add(ambientTemperature, buffer(str_offset + 24, 2), buffer(str_offset + 24, 2):le_uint() * 0.01)
    length = buffer(str_offset + 26, 1):uint() - 2
    -- type = buffer(str_offset + 26 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(stationId, buffer(str_offset + 26 + 2, length))
    str_offset = str_offset + length + 2
    length = buffer(str_offset + 0, 1):uint() - 2
    -- type = buffer(str_offset + 0 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(stationName, buffer(str_offset + 0 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_130323
