-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127490 = Proto("nmea-2000-127490", "Electric Drive Status, Dynamic (127490)")
local inverterMotorIdentifier = ProtoField.float("nmea-2000-127490.inverterMotorIdentifier", "Inverter/Motor Identifier")
local motorTemperature = ProtoField.float("nmea-2000-127490.motorTemperature", "Motor Temperature (K)")
local inverterTemperature = ProtoField.float("nmea-2000-127490.inverterTemperature", "Inverter Temperature (K)")
local coolantTemperature = ProtoField.float("nmea-2000-127490.coolantTemperature", "Coolant Temperature (K)")
local gearTemperature = ProtoField.float("nmea-2000-127490.gearTemperature", "Gear Temperature (K)")
local shaftTorque = ProtoField.float("nmea-2000-127490.shaftTorque", "Shaft Torque")

NMEA_2000_127490.fields = {inverterMotorIdentifier,motorTemperature,inverterTemperature,coolantTemperature,gearTemperature,shaftTorque}

function NMEA_2000_127490.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127490 (Electric Drive Status, Dynamic)"
    local subtree = tree:add(NMEA_2000_127490, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(inverterMotorIdentifier, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(motorTemperature, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 0.01)
    subtree:add(inverterTemperature, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 0.01)
    subtree:add(coolantTemperature, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 0.01)
    subtree:add(gearTemperature, buffer(str_offset + 8, 2), buffer(str_offset + 8, 2):le_uint() * 0.01)
    subtree:add(shaftTorque, buffer(str_offset + 10, 2), buffer(str_offset + 10, 2):le_uint() * 1)
end

return NMEA_2000_127490
