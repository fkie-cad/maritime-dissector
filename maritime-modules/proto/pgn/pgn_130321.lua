-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130321 = Proto("nmea-2000-130321", "Salinity Station Data (130321)")
local mode = ProtoField.uint8("nmea-2000-130321.mode", "Mode", base.DEC, NULL, 0xf)
local measurementDate = ProtoField.uint16("nmea-2000-130321.measurementDate", "Measurement Date (d)")
local measurementTime = ProtoField.float("nmea-2000-130321.measurementTime", "Measurement Time (s)")
local stationLatitude = ProtoField.float("nmea-2000-130321.stationLatitude", "Station Latitude (deg)")
local stationLongitude = ProtoField.float("nmea-2000-130321.stationLongitude", "Station Longitude (deg)")
local salinity = ProtoField.float("nmea-2000-130321.salinity", "Salinity (ppt)")
local waterTemperature = ProtoField.float("nmea-2000-130321.waterTemperature", "Water Temperature (K)")
local stationId = ProtoField.string("nmea-2000-130321.stationId", "Station ID")
local stationName = ProtoField.string("nmea-2000-130321.stationName", "Station Name")

NMEA_2000_130321.fields = {mode,measurementDate,measurementTime,stationLatitude,stationLongitude,salinity,waterTemperature,stationId,stationName}

function NMEA_2000_130321.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130321 (Salinity Station Data)"
    local subtree = tree:add(NMEA_2000_130321, buffer(), subtree_title)
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
    if buffer:len() >= (str_offset + 15 + 4) then
        subtree:add_le(salinity, buffer(str_offset + 15, 4))
    end
    if buffer:len() >= (str_offset + 19 + 2) then
        subtree:add(waterTemperature, buffer(str_offset + 19, 2), buffer(str_offset + 19, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 21 + 1) then
        length = buffer(str_offset + 21, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 21 + 2 + length) then
            -- type = buffer(str_offset + 21 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(stationId, buffer(str_offset + 21 + 2, length))
            str_offset = str_offset + 21 + length + 2
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

return NMEA_2000_130321
