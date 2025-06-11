-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130322 = Proto("nmea-2000-130322", "Current Station Data (130322)")
local mode = ProtoField.uint8("nmea-2000-130322.mode", "Mode", base.DEC, NULL, 0xf)
local state = ProtoField.uint8("nmea-2000-130322.state", "State", base.DEC, NULL, 0x70)
local measurementDate = ProtoField.float("nmea-2000-130322.measurementDate", "Measurement Date (d)")
local measurementTime = ProtoField.float("nmea-2000-130322.measurementTime", "Measurement Time (s)")
local stationLatitude = ProtoField.float("nmea-2000-130322.stationLatitude", "Station Latitude (deg)")
local stationLongitude = ProtoField.float("nmea-2000-130322.stationLongitude", "Station Longitude (deg)")
local measurementDepth = ProtoField.float("nmea-2000-130322.measurementDepth", "Measurement Depth (m)")
local currentSpeed = ProtoField.float("nmea-2000-130322.currentSpeed", "Current speed (m/s)")
local currentFlowDirection = ProtoField.float("nmea-2000-130322.currentFlowDirection", "Current flow direction (rad)")
local waterTemperature = ProtoField.float("nmea-2000-130322.waterTemperature", "Water Temperature (K)")
local stationId = ProtoField.string("nmea-2000-130322.stationId", "Station ID")
local stationName = ProtoField.string("nmea-2000-130322.stationName", "Station Name")

NMEA_2000_130322.fields = {mode,state,measurementDate,measurementTime,stationLatitude,stationLongitude,measurementDepth,currentSpeed,currentFlowDirection,waterTemperature,stationId,stationName}

function NMEA_2000_130322.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130322 (Current Station Data)"
    local subtree = tree:add(NMEA_2000_130322, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(mode, buffer(str_offset + 0, 1))
    subtree:add(state, buffer(str_offset + 0, 1))
    subtree:add(measurementDate, buffer(str_offset + 1, 2), buffer(str_offset + 1, 2):le_uint() * 1)
    subtree:add(measurementTime, buffer(str_offset + 3, 4), buffer(str_offset + 3, 4):le_uint() * 0.0001)
    subtree:add(stationLatitude, buffer(str_offset + 7, 4), buffer(str_offset + 7, 4):le_int() * 1e-07)
    subtree:add(stationLongitude, buffer(str_offset + 11, 4), buffer(str_offset + 11, 4):le_int() * 1e-07)
    subtree:add(measurementDepth, buffer(str_offset + 15, 4), buffer(str_offset + 15, 4):le_uint() * 0.01)
    subtree:add(currentSpeed, buffer(str_offset + 19, 2), buffer(str_offset + 19, 2):le_uint() * 0.01)
    subtree:add(currentFlowDirection, buffer(str_offset + 21, 2), buffer(str_offset + 21, 2):le_uint() * 0.0001)
    subtree:add(waterTemperature, buffer(str_offset + 23, 2), buffer(str_offset + 23, 2):le_uint() * 0.01)
    length = buffer(str_offset + 25, 1):uint() - 2
    -- type = buffer(str_offset + 25 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(stationId, buffer(str_offset + 25 + 2, length))
    str_offset = str_offset + length + 2
    length = buffer(str_offset + 0, 1):uint() - 2
    -- type = buffer(str_offset + 0 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(stationName, buffer(str_offset + 0 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_130322
