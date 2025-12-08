-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130320 = Proto("nmea-2000-130320", "Tide Station Data (130320)")
local mode = ProtoField.uint8("nmea-2000-130320.mode", "Mode", base.DEC, NULL, 0xf)
local tideTendency = ProtoField.uint8("nmea-2000-130320.tideTendency", "Tide Tendency", base.DEC, NULL, 0x30)
local measurementDate = ProtoField.uint16("nmea-2000-130320.measurementDate", "Measurement Date (d)")
local measurementTime = ProtoField.float("nmea-2000-130320.measurementTime", "Measurement Time (s)")
local stationLatitude = ProtoField.float("nmea-2000-130320.stationLatitude", "Station Latitude (deg)")
local stationLongitude = ProtoField.float("nmea-2000-130320.stationLongitude", "Station Longitude (deg)")
local tideLevel = ProtoField.float("nmea-2000-130320.tideLevel", "Tide Level (m)")
local tideLevelStandardDeviation = ProtoField.float("nmea-2000-130320.tideLevelStandardDeviation", "Tide Level standard deviation (m)")
local stationId = ProtoField.string("nmea-2000-130320.stationId", "Station ID")
local stationName = ProtoField.string("nmea-2000-130320.stationName", "Station Name")

NMEA_2000_130320.fields = {mode,tideTendency,measurementDate,measurementTime,stationLatitude,stationLongitude,tideLevel,tideLevelStandardDeviation,stationId,stationName}

function NMEA_2000_130320.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130320 (Tide Station Data)"
    local subtree = tree:add(NMEA_2000_130320, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(mode, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(tideTendency, buffer(str_offset, 1))
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
        subtree:add(tideLevel, buffer(str_offset + 15, 2), buffer(str_offset + 15, 2):le_int() * 0.001)
    end
    if buffer:len() >= (str_offset + 17 + 2) then
        subtree:add(tideLevelStandardDeviation, buffer(str_offset + 17, 2), buffer(str_offset + 17, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 19 + 1) then
        length = buffer(str_offset + 19, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 19 + 2 + length) then
            -- type = buffer(str_offset + 19 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(stationId, buffer(str_offset + 19 + 2, length))
            str_offset = str_offset + 19 + length + 2
        end
    end
    if buffer:len() >= (str_offset + 1) then
        length = buffer(str_offset, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 2 + length) then
            -- type = buffer(str_offset + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(stationName, buffer(str_offset + 2, length))
            str_offset = str_offset + length + 2
        end
    end
end

return NMEA_2000_130320
