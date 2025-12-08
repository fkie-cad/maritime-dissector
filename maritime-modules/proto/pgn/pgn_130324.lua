-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130324 = Proto("nmea-2000-130324", "Moored Buoy Station Data (130324)")
local mode = ProtoField.uint8("nmea-2000-130324.mode", "Mode", base.DEC, NULL, 0xf)
local measurementDate = ProtoField.uint16("nmea-2000-130324.measurementDate", "Measurement Date (d)")
local measurementTime = ProtoField.float("nmea-2000-130324.measurementTime", "Measurement Time (s)")
local stationLatitude = ProtoField.float("nmea-2000-130324.stationLatitude", "Station Latitude (deg)")
local stationLongitude = ProtoField.float("nmea-2000-130324.stationLongitude", "Station Longitude (deg)")
local windSpeed = ProtoField.float("nmea-2000-130324.windSpeed", "Wind Speed (m/s)")
local windDirection = ProtoField.float("nmea-2000-130324.windDirection", "Wind Direction (rad)")
local windReference = ProtoField.uint8("nmea-2000-130324.windReference", "Wind Reference", base.DEC, NULL, 0x7)
local windGusts = ProtoField.float("nmea-2000-130324.windGusts", "Wind Gusts (m/s)")
local waveHeight = ProtoField.float("nmea-2000-130324.waveHeight", "Wave Height (m)")
local dominantWavePeriod = ProtoField.float("nmea-2000-130324.dominantWavePeriod", "Dominant Wave Period (s)")
local atmosphericPressure = ProtoField.float("nmea-2000-130324.atmosphericPressure", "Atmospheric Pressure (Pa)")
local pressureTendencyRate = ProtoField.float("nmea-2000-130324.pressureTendencyRate", "Pressure Tendency Rate (Pa/hr)")
local airTemperature = ProtoField.float("nmea-2000-130324.airTemperature", "Air Temperature (K)")
local waterTemperature = ProtoField.float("nmea-2000-130324.waterTemperature", "Water Temperature (K)")
local stationId = ProtoField.string("nmea-2000-130324.stationId", "Station ID")

NMEA_2000_130324.fields = {mode,measurementDate,measurementTime,stationLatitude,stationLongitude,windSpeed,windDirection,windReference,windGusts,waveHeight,dominantWavePeriod,atmosphericPressure,pressureTendencyRate,airTemperature,waterTemperature,stationId}

function NMEA_2000_130324.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130324 (Moored Buoy Station Data)"
    local subtree = tree:add(NMEA_2000_130324, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(mode, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 2) then
        subtree:add_le(measurementDate, buffer(str_offset + 1, 2))
    end
    if buffer:len() >= (str_offset + 3 + 4) then
        subtree:add(measurementTime, buffer(str_offset + 3, 4), buffer(str_offset + 3, 4):le_uint() * 0.0001)
    end
    if buffer:len() >= (str_offset + 7 + 4) then
        subtree:add(stationLatitude, buffer(str_offset + 7, 4), buffer(str_offset + 7, 4):le_int() * 1e-07)
    end
    if buffer:len() >= (str_offset + 11 + 4) then
        subtree:add(stationLongitude, buffer(str_offset + 11, 4), buffer(str_offset + 11, 4):le_int() * 1e-07)
    end
    if buffer:len() >= (str_offset + 15 + 2) then
        subtree:add(windSpeed, buffer(str_offset + 15, 2), buffer(str_offset + 15, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 17 + 2) then
        subtree:add(windDirection, buffer(str_offset + 17, 2), buffer(str_offset + 17, 2):le_uint() * 0.0001)
    end
    if buffer:len() >= (str_offset + 19 + 1) then
        subtree:add(windReference, buffer(str_offset + 19, 1))
    end
    if buffer:len() >= (str_offset + 20 + 2) then
        subtree:add(windGusts, buffer(str_offset + 20, 2), buffer(str_offset + 20, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 22 + 2) then
        subtree:add(waveHeight, buffer(str_offset + 22, 2), buffer(str_offset + 22, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 24 + 2) then
        subtree:add(dominantWavePeriod, buffer(str_offset + 24, 2), buffer(str_offset + 24, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 26 + 2) then
        subtree:add(atmosphericPressure, buffer(str_offset + 26, 2), buffer(str_offset + 26, 2):le_uint() * 100)
    end
    if buffer:len() >= (str_offset + 28 + 2) then
        subtree:add(pressureTendencyRate, buffer(str_offset + 28, 2), buffer(str_offset + 28, 2):le_int() * 10)
    end
    if buffer:len() >= (str_offset + 30 + 2) then
        subtree:add(airTemperature, buffer(str_offset + 30, 2), buffer(str_offset + 30, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 32 + 2) then
        subtree:add(waterTemperature, buffer(str_offset + 32, 2), buffer(str_offset + 32, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 34 + 1) then
        length = buffer(str_offset + 34, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 34 + 2 + length) then
            -- type = buffer(str_offset + 34 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(stationId, buffer(str_offset + 34 + 2, length))
            str_offset = str_offset + 34 + length + 2
        end
    end
end

return NMEA_2000_130324
