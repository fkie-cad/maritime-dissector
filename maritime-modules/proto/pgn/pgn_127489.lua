-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127489 = Proto("nmea-2000-127489", "Engine Parameters, Dynamic (127489)")
local instance = ProtoField.uint8("nmea-2000-127489.instance", "Instance", base.DEC, NULL, 0xff)
local oilPressure = ProtoField.float("nmea-2000-127489.oilPressure", "Oil pressure (Pa)")
local oilTemperature = ProtoField.float("nmea-2000-127489.oilTemperature", "Oil temperature (K)")
local temperature = ProtoField.float("nmea-2000-127489.temperature", "Temperature (K)")
local alternatorPotential = ProtoField.float("nmea-2000-127489.alternatorPotential", "Alternator Potential (V)")
local fuelRate = ProtoField.float("nmea-2000-127489.fuelRate", "Fuel Rate (L/h)")
local totalEngineHours = ProtoField.uint32("nmea-2000-127489.totalEngineHours", "Total Engine hours (s)")
local coolantPressure = ProtoField.float("nmea-2000-127489.coolantPressure", "Coolant Pressure (Pa)")
local fuelPressure = ProtoField.float("nmea-2000-127489.fuelPressure", "Fuel Pressure (Pa)")
local discreteStatus1 = ProtoField.uint16("nmea-2000-127489.discreteStatus1", "Discrete Status 1", base.HEX)
local discreteStatus2 = ProtoField.uint16("nmea-2000-127489.discreteStatus2", "Discrete Status 2", base.HEX)
local engineLoad = ProtoField.int8("nmea-2000-127489.engineLoad", "Engine Load (%)")
local engineTorque = ProtoField.int8("nmea-2000-127489.engineTorque", "Engine Torque (%)")

NMEA_2000_127489.fields = {instance,oilPressure,oilTemperature,temperature,alternatorPotential,fuelRate,totalEngineHours,coolantPressure,fuelPressure,discreteStatus1,discreteStatus2,engineLoad,engineTorque}

function NMEA_2000_127489.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127489 (Engine Parameters, Dynamic)"
    local subtree = tree:add(NMEA_2000_127489, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(instance, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 2) then
        subtree:add(oilPressure, buffer(str_offset + 1, 2), buffer(str_offset + 1, 2):le_uint() * 100)
    end
    if buffer:len() >= (str_offset + 3 + 2) then
        subtree:add(oilTemperature, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_uint() * 0.1)
    end
    if buffer:len() >= (str_offset + 5 + 2) then
        subtree:add(temperature, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 7 + 2) then
        subtree:add(alternatorPotential, buffer(str_offset + 7, 2), buffer(str_offset + 7, 2):le_int() * 0.01)
    end
    if buffer:len() >= (str_offset + 9 + 2) then
        subtree:add(fuelRate, buffer(str_offset + 9, 2), buffer(str_offset + 9, 2):le_int() * 0.1)
    end
    if buffer:len() >= (str_offset + 11 + 4) then
        subtree:add_le(totalEngineHours, buffer(str_offset + 11, 4))
    end
    if buffer:len() >= (str_offset + 15 + 2) then
        subtree:add(coolantPressure, buffer(str_offset + 15, 2), buffer(str_offset + 15, 2):le_uint() * 100)
    end
    if buffer:len() >= (str_offset + 17 + 2) then
        subtree:add(fuelPressure, buffer(str_offset + 17, 2), buffer(str_offset + 17, 2):le_uint() * 1000)
    end
    subtree:add(discreteStatus1, buffer(str_offset + 20, 2))
    subtree:add(discreteStatus2, buffer(str_offset + 22, 2))
    if buffer:len() >= (str_offset + 24 + 1) then
        subtree:add(engineLoad, buffer(str_offset + 24, 1))
    end
    if buffer:len() >= (str_offset + 25 + 1) then
        subtree:add(engineTorque, buffer(str_offset + 25, 1))
    end
end

return NMEA_2000_127489
