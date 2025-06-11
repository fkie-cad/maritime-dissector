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
local totalEngineHours = ProtoField.float("nmea-2000-127489.totalEngineHours", "Total Engine hours (s)")
local coolantPressure = ProtoField.float("nmea-2000-127489.coolantPressure", "Coolant Pressure (Pa)")
local fuelPressure = ProtoField.float("nmea-2000-127489.fuelPressure", "Fuel Pressure (Pa)")
local engineLoad = ProtoField.float("nmea-2000-127489.engineLoad", "Engine Load (%)")
local engineTorque = ProtoField.float("nmea-2000-127489.engineTorque", "Engine Torque (%)")

NMEA_2000_127489.fields = {instance,oilPressure,oilTemperature,temperature,alternatorPotential,fuelRate,totalEngineHours,coolantPressure,fuelPressure,engineLoad,engineTorque}

function NMEA_2000_127489.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127489 (Engine Parameters, Dynamic)"
    local subtree = tree:add(NMEA_2000_127489, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(instance, buffer(str_offset + 0, 1))
    subtree:add(oilPressure, buffer(str_offset + 1, 2), buffer(str_offset + 1, 2):le_uint() * 100)
    subtree:add(oilTemperature, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_uint() * 0.1)
    subtree:add(temperature, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_uint() * 0.01)
    subtree:add(alternatorPotential, buffer(str_offset + 7, 2), buffer(str_offset + 7, 2):le_int() * 0.01)
    subtree:add(fuelRate, buffer(str_offset + 9, 2), buffer(str_offset + 9, 2):le_int() * 0.1)
    subtree:add(totalEngineHours, buffer(str_offset + 11, 4), buffer(str_offset + 11, 4):le_uint() * 1)
    subtree:add(coolantPressure, buffer(str_offset + 15, 2), buffer(str_offset + 15, 2):le_uint() * 100)
    subtree:add(fuelPressure, buffer(str_offset + 17, 2), buffer(str_offset + 17, 2):le_uint() * 1000)
    subtree:add(engineLoad, buffer(str_offset + 24, 1), buffer(str_offset + 24, 1):le_int() * 1)
    subtree:add(engineTorque, buffer(str_offset + 25, 1), buffer(str_offset + 25, 1):le_int() * 1)
end

return NMEA_2000_127489
