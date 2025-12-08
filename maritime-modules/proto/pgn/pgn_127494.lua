-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127494 = Proto("nmea-2000-127494", "Electric Drive Information (127494)")
local inverterMotorIdentifier = ProtoField.uint8("nmea-2000-127494.inverterMotorIdentifier", "Inverter/Motor Identifier")
local motorType = ProtoField.uint32("nmea-2000-127494.motorType", "Motor Type")
local motorVoltageRating = ProtoField.float("nmea-2000-127494.motorVoltageRating", "Motor Voltage Rating (V)")
local maximumContinuousMotorPower = ProtoField.uint32("nmea-2000-127494.maximumContinuousMotorPower", "Maximum Continuous Motor Power (W)")
local maximumBoostMotorPower = ProtoField.uint32("nmea-2000-127494.maximumBoostMotorPower", "Maximum Boost Motor Power (W)")
local maximumMotorTemperatureRating = ProtoField.float("nmea-2000-127494.maximumMotorTemperatureRating", "Maximum Motor Temperature Rating (K)")
local ratedMotorSpeed = ProtoField.float("nmea-2000-127494.ratedMotorSpeed", "Rated Motor Speed (rpm)")
local maximumControllerTemperatureRating = ProtoField.float("nmea-2000-127494.maximumControllerTemperatureRating", "Maximum Controller Temperature Rating (K)")
local motorShaftTorqueRating = ProtoField.uint16("nmea-2000-127494.motorShaftTorqueRating", "Motor Shaft Torque Rating")
local motorDcVoltageDeratingThreshold = ProtoField.float("nmea-2000-127494.motorDcVoltageDeratingThreshold", "Motor DC-Voltage Derating Threshold (V)")
local motorDcVoltageCutOffThreshold = ProtoField.float("nmea-2000-127494.motorDcVoltageCutOffThreshold", "Motor DC-Voltage Cut Off Threshold (V)")
local driveMotorHours = ProtoField.uint32("nmea-2000-127494.driveMotorHours", "Drive/Motor Hours (s)")

NMEA_2000_127494.fields = {inverterMotorIdentifier,motorType,motorVoltageRating,maximumContinuousMotorPower,maximumBoostMotorPower,maximumMotorTemperatureRating,ratedMotorSpeed,maximumControllerTemperatureRating,motorShaftTorqueRating,motorDcVoltageDeratingThreshold,motorDcVoltageCutOffThreshold,driveMotorHours}

function NMEA_2000_127494.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127494 (Electric Drive Information)"
    local subtree = tree:add(NMEA_2000_127494, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(inverterMotorIdentifier, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        local _rng = buffer(str_offset + 1, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 4)
        subtree:add(motorType, _rng, _val)
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add(motorVoltageRating, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 0.1)
    end
    if buffer:len() >= (str_offset + 4 + 4) then
        subtree:add_le(maximumContinuousMotorPower, buffer(str_offset + 4, 4))
    end
    if buffer:len() >= (str_offset + 8 + 4) then
        subtree:add_le(maximumBoostMotorPower, buffer(str_offset + 8, 4))
    end
    if buffer:len() >= (str_offset + 12 + 2) then
        subtree:add(maximumMotorTemperatureRating, buffer(str_offset + 12, 2), buffer(str_offset + 12, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 14 + 2) then
        subtree:add(ratedMotorSpeed, buffer(str_offset + 14, 2), buffer(str_offset + 14, 2):le_uint() * 0.25)
    end
    if buffer:len() >= (str_offset + 16 + 2) then
        subtree:add(maximumControllerTemperatureRating, buffer(str_offset + 16, 2), buffer(str_offset + 16, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 18 + 2) then
        subtree:add_le(motorShaftTorqueRating, buffer(str_offset + 18, 2))
    end
    if buffer:len() >= (str_offset + 20 + 2) then
        subtree:add(motorDcVoltageDeratingThreshold, buffer(str_offset + 20, 2), buffer(str_offset + 20, 2):le_uint() * 0.1)
    end
    if buffer:len() >= (str_offset + 22 + 2) then
        subtree:add(motorDcVoltageCutOffThreshold, buffer(str_offset + 22, 2), buffer(str_offset + 22, 2):le_uint() * 0.1)
    end
    if buffer:len() >= (str_offset + 24 + 4) then
        subtree:add_le(driveMotorHours, buffer(str_offset + 24, 4))
    end
end

return NMEA_2000_127494
