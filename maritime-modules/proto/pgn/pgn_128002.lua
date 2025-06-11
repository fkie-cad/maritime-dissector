-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128002 = Proto("nmea-2000-128002", "Electric Drive Status, Rapid Update (128002)")
local inverterMotorController = ProtoField.float("nmea-2000-128002.inverterMotorController", "Inverter/Motor Controller")
local rotationalShaftSpeed = ProtoField.float("nmea-2000-128002.rotationalShaftSpeed", "Rotational Shaft Speed (rpm)")
local motorDcVoltage = ProtoField.float("nmea-2000-128002.motorDcVoltage", "Motor DC Voltage (V)")
local motorDcCurrent = ProtoField.float("nmea-2000-128002.motorDcCurrent", "Motor DC Current (A)")

NMEA_2000_128002.fields = {inverterMotorController,rotationalShaftSpeed,motorDcVoltage,motorDcCurrent}

function NMEA_2000_128002.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128002 (Electric Drive Status, Rapid Update)"
    local subtree = tree:add(NMEA_2000_128002, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(inverterMotorController, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(rotationalShaftSpeed, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 0.25)
    subtree:add(motorDcVoltage, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 0.1)
    subtree:add(motorDcCurrent, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_int() * 0.1)
end

return NMEA_2000_128002
