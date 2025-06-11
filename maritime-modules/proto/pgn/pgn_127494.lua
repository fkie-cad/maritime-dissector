-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127494 = Proto("nmea-2000-127494", "Electric Drive Information (127494)")
local inverterMotorIdentifier = ProtoField.float("nmea-2000-127494.inverterMotorIdentifier", "Inverter/Motor Identifier")
local motorVoltageRating = ProtoField.float("nmea-2000-127494.motorVoltageRating", "Motor Voltage Rating (V)")
local maximumContinuousMotorPower = ProtoField.float("nmea-2000-127494.maximumContinuousMotorPower", "Maximum Continuous Motor Power (W)")
local maximumBoostMotorPower = ProtoField.float("nmea-2000-127494.maximumBoostMotorPower", "Maximum Boost Motor Power (W)")
local maximumMotorTemperatureRating = ProtoField.float("nmea-2000-127494.maximumMotorTemperatureRating", "Maximum Motor Temperature Rating (K)")
local ratedMotorSpeed = ProtoField.float("nmea-2000-127494.ratedMotorSpeed", "Rated Motor Speed (rpm)")
local maximumControllerTemperatureRating = ProtoField.float("nmea-2000-127494.maximumControllerTemperatureRating", "Maximum Controller Temperature Rating (K)")
local motorShaftTorqueRating = ProtoField.float("nmea-2000-127494.motorShaftTorqueRating", "Motor Shaft Torque Rating")
local motorDcVoltageDeratingThreshold = ProtoField.float("nmea-2000-127494.motorDcVoltageDeratingThreshold", "Motor DC-Voltage Derating Threshold (V)")
local motorDcVoltageCutOffThreshold = ProtoField.float("nmea-2000-127494.motorDcVoltageCutOffThreshold", "Motor DC-Voltage Cut Off Threshold (V)")
local driveMotorHours = ProtoField.float("nmea-2000-127494.driveMotorHours", "Drive/Motor Hours (s)")

NMEA_2000_127494.fields = {inverterMotorIdentifier,motorVoltageRating,maximumContinuousMotorPower,maximumBoostMotorPower,maximumMotorTemperatureRating,ratedMotorSpeed,maximumControllerTemperatureRating,motorShaftTorqueRating,motorDcVoltageDeratingThreshold,motorDcVoltageCutOffThreshold,driveMotorHours}

function NMEA_2000_127494.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127494 (Electric Drive Information)"
    local subtree = tree:add(NMEA_2000_127494, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(inverterMotorIdentifier, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(motorVoltageRating, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 0.1)
    subtree:add(maximumContinuousMotorPower, buffer(str_offset + 4, 4), buffer(str_offset + 4, 4):le_uint() * 1)
    subtree:add(maximumBoostMotorPower, buffer(str_offset + 8, 4), buffer(str_offset + 8, 4):le_uint() * 1)
    subtree:add(maximumMotorTemperatureRating, buffer(str_offset + 12, 2), buffer(str_offset + 12, 2):le_uint() * 0.01)
    subtree:add(ratedMotorSpeed, buffer(str_offset + 14, 2), buffer(str_offset + 14, 2):le_uint() * 0.25)
    subtree:add(maximumControllerTemperatureRating, buffer(str_offset + 16, 2), buffer(str_offset + 16, 2):le_uint() * 0.01)
    subtree:add(motorShaftTorqueRating, buffer(str_offset + 18, 2), buffer(str_offset + 18, 2):le_uint() * 1)
    subtree:add(motorDcVoltageDeratingThreshold, buffer(str_offset + 20, 2), buffer(str_offset + 20, 2):le_uint() * 0.1)
    subtree:add(motorDcVoltageCutOffThreshold, buffer(str_offset + 22, 2), buffer(str_offset + 22, 2):le_uint() * 0.1)
    subtree:add(driveMotorHours, buffer(str_offset + 24, 4), buffer(str_offset + 24, 4):le_uint() * 1)
end

return NMEA_2000_127494
