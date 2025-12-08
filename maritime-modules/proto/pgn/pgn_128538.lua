-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128538 = Proto("nmea-2000-128538", "Elevator Car Status (128538)")
local sid = ProtoField.uint8("nmea-2000-128538.sid", "SID")
local elevatorCarId = ProtoField.uint8("nmea-2000-128538.elevatorCarId", "Elevator Car ID")
local elevatorCarUsage = ProtoField.uint8("nmea-2000-128538.elevatorCarUsage", "Elevator Car Usage")
local smokeSensorStatus = ProtoField.uint32("nmea-2000-128538.smokeSensorStatus", "Smoke Sensor Status")
local limitSwitchSensorStatus = ProtoField.uint32("nmea-2000-128538.limitSwitchSensorStatus", "Limit Switch Sensor Status")
local proximitySwitchSensorStatus = ProtoField.uint32("nmea-2000-128538.proximitySwitchSensorStatus", "Proximity Switch Sensor Status")
local inertialMeasurementUnitImuSensorStatus = ProtoField.uint32("nmea-2000-128538.inertialMeasurementUnitImuSensorStatus", "Inertial Measurement Unit (IMU) Sensor Status")
local elevatorLoadLimitStatus = ProtoField.uint32("nmea-2000-128538.elevatorLoadLimitStatus", "Elevator Load Limit Status")
local elevatorLoadBalanceStatus = ProtoField.uint32("nmea-2000-128538.elevatorLoadBalanceStatus", "Elevator Load Balance Status")
local elevatorLoadSensor1Status = ProtoField.uint32("nmea-2000-128538.elevatorLoadSensor1Status", "Elevator Load Sensor 1 Status")
local elevatorLoadSensor2Status = ProtoField.uint32("nmea-2000-128538.elevatorLoadSensor2Status", "Elevator Load Sensor 2 Status")
local elevatorLoadSensor3Status = ProtoField.uint32("nmea-2000-128538.elevatorLoadSensor3Status", "Elevator Load Sensor 3 Status")
local elevatorLoadSensor4Status = ProtoField.uint32("nmea-2000-128538.elevatorLoadSensor4Status", "Elevator Load Sensor 4 Status")
local elevatorCarMotionStatus = ProtoField.uint32("nmea-2000-128538.elevatorCarMotionStatus", "Elevator Car Motion Status")
local elevatorCarDoorStatus = ProtoField.uint32("nmea-2000-128538.elevatorCarDoorStatus", "Elevator Car Door Status")
local elevatorCarEmergencyButtonStatus = ProtoField.uint32("nmea-2000-128538.elevatorCarEmergencyButtonStatus", "Elevator Car Emergency Button Status")
local elevatorCarBuzzerStatus = ProtoField.uint32("nmea-2000-128538.elevatorCarBuzzerStatus", "Elevator Car Buzzer Status")
local openDoorButtonStatus = ProtoField.uint32("nmea-2000-128538.openDoorButtonStatus", "Open Door Button Status")
local closeDoorButtonStatus = ProtoField.uint32("nmea-2000-128538.closeDoorButtonStatus", "Close Door Button Status")
local currentDeck = ProtoField.uint8("nmea-2000-128538.currentDeck", "Current Deck")
local destinationDeck = ProtoField.uint8("nmea-2000-128538.destinationDeck", "Destination Deck")
local totalNumberOfDecks = ProtoField.uint8("nmea-2000-128538.totalNumberOfDecks", "Total Number of Decks")
local weightOfLoadCell1 = ProtoField.uint16("nmea-2000-128538.weightOfLoadCell1", "Weight of Load Cell 1")
local weightOfLoadCell2 = ProtoField.uint16("nmea-2000-128538.weightOfLoadCell2", "Weight of Load Cell 2")
local weightOfLoadCell3 = ProtoField.uint16("nmea-2000-128538.weightOfLoadCell3", "Weight of Load Cell 3")
local weightOfLoadCell4 = ProtoField.uint16("nmea-2000-128538.weightOfLoadCell4", "Weight of Load Cell 4")
local speedOfElevatorCar = ProtoField.float("nmea-2000-128538.speedOfElevatorCar", "Speed of Elevator Car (m/s)")
local elevatorBrakeStatus = ProtoField.uint32("nmea-2000-128538.elevatorBrakeStatus", "Elevator Brake Status")
local elevatorMotorRotationControlStatus = ProtoField.uint32("nmea-2000-128538.elevatorMotorRotationControlStatus", "Elevator Motor rotation control Status")

NMEA_2000_128538.fields = {sid,elevatorCarId,elevatorCarUsage,smokeSensorStatus,limitSwitchSensorStatus,proximitySwitchSensorStatus,inertialMeasurementUnitImuSensorStatus,elevatorLoadLimitStatus,elevatorLoadBalanceStatus,elevatorLoadSensor1Status,elevatorLoadSensor2Status,elevatorLoadSensor3Status,elevatorLoadSensor4Status,elevatorCarMotionStatus,elevatorCarDoorStatus,elevatorCarEmergencyButtonStatus,elevatorCarBuzzerStatus,openDoorButtonStatus,closeDoorButtonStatus,currentDeck,destinationDeck,totalNumberOfDecks,weightOfLoadCell1,weightOfLoadCell2,weightOfLoadCell3,weightOfLoadCell4,speedOfElevatorCar,elevatorBrakeStatus,elevatorMotorRotationControlStatus}

function NMEA_2000_128538.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128538 (Elevator Car Status)"
    local subtree = tree:add(NMEA_2000_128538, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sid, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(elevatorCarId, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(elevatorCarUsage, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        local _rng = buffer(str_offset + 3, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 2)
        subtree:add(smokeSensorStatus, _rng, _val)
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        local _rng = buffer(str_offset + 3, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 2)) % (2 ^ 2)
        subtree:add(limitSwitchSensorStatus, _rng, _val)
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        local _rng = buffer(str_offset + 3, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 4)) % (2 ^ 2)
        subtree:add(proximitySwitchSensorStatus, _rng, _val)
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        local _rng = buffer(str_offset + 3, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 6)) % (2 ^ 2)
        subtree:add(inertialMeasurementUnitImuSensorStatus, _rng, _val)
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        local _rng = buffer(str_offset + 4, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 2)
        subtree:add(elevatorLoadLimitStatus, _rng, _val)
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        local _rng = buffer(str_offset + 4, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 2)) % (2 ^ 2)
        subtree:add(elevatorLoadBalanceStatus, _rng, _val)
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        local _rng = buffer(str_offset + 4, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 4)) % (2 ^ 2)
        subtree:add(elevatorLoadSensor1Status, _rng, _val)
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        local _rng = buffer(str_offset + 4, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 6)) % (2 ^ 2)
        subtree:add(elevatorLoadSensor2Status, _rng, _val)
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        local _rng = buffer(str_offset + 5, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 2)
        subtree:add(elevatorLoadSensor3Status, _rng, _val)
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        local _rng = buffer(str_offset + 5, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 2)) % (2 ^ 2)
        subtree:add(elevatorLoadSensor4Status, _rng, _val)
    end
    if buffer:len() >= (str_offset + 6 + 1) then
        local _rng = buffer(str_offset + 6, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 2)
        subtree:add(elevatorCarMotionStatus, _rng, _val)
    end
    if buffer:len() >= (str_offset + 6 + 1) then
        local _rng = buffer(str_offset + 6, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 2)) % (2 ^ 2)
        subtree:add(elevatorCarDoorStatus, _rng, _val)
    end
    if buffer:len() >= (str_offset + 6 + 1) then
        local _rng = buffer(str_offset + 6, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 4)) % (2 ^ 2)
        subtree:add(elevatorCarEmergencyButtonStatus, _rng, _val)
    end
    if buffer:len() >= (str_offset + 6 + 1) then
        local _rng = buffer(str_offset + 6, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 6)) % (2 ^ 2)
        subtree:add(elevatorCarBuzzerStatus, _rng, _val)
    end
    if buffer:len() >= (str_offset + 7 + 1) then
        local _rng = buffer(str_offset + 7, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 2)
        subtree:add(openDoorButtonStatus, _rng, _val)
    end
    if buffer:len() >= (str_offset + 7 + 1) then
        local _rng = buffer(str_offset + 7, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 2)) % (2 ^ 2)
        subtree:add(closeDoorButtonStatus, _rng, _val)
    end
    if buffer:len() >= (str_offset + 8 + 1) then
        subtree:add(currentDeck, buffer(str_offset + 8, 1))
    end
    if buffer:len() >= (str_offset + 9 + 1) then
        subtree:add(destinationDeck, buffer(str_offset + 9, 1))
    end
    if buffer:len() >= (str_offset + 10 + 1) then
        subtree:add(totalNumberOfDecks, buffer(str_offset + 10, 1))
    end
    if buffer:len() >= (str_offset + 11 + 2) then
        subtree:add_le(weightOfLoadCell1, buffer(str_offset + 11, 2))
    end
    if buffer:len() >= (str_offset + 13 + 2) then
        subtree:add_le(weightOfLoadCell2, buffer(str_offset + 13, 2))
    end
    if buffer:len() >= (str_offset + 15 + 2) then
        subtree:add_le(weightOfLoadCell3, buffer(str_offset + 15, 2))
    end
    if buffer:len() >= (str_offset + 17 + 2) then
        subtree:add_le(weightOfLoadCell4, buffer(str_offset + 17, 2))
    end
    if buffer:len() >= (str_offset + 19 + 2) then
        subtree:add(speedOfElevatorCar, buffer(str_offset + 19, 2), buffer(str_offset + 19, 2):le_int() * 0.01)
    end
    if buffer:len() >= (str_offset + 21 + 1) then
        local _rng = buffer(str_offset + 21, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 2)
        subtree:add(elevatorBrakeStatus, _rng, _val)
    end
    if buffer:len() >= (str_offset + 21 + 1) then
        local _rng = buffer(str_offset + 21, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 2)) % (2 ^ 2)
        subtree:add(elevatorMotorRotationControlStatus, _rng, _val)
    end
end

return NMEA_2000_128538
