-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128002 = Proto("nmea-2000-128002", "Electric Drive Status, Rapid Update (128002)")
local inverterMotorController = ProtoField.uint8("nmea-2000-128002.inverterMotorController", "Inverter/Motor Controller")
local activeMotorMode = ProtoField.uint32("nmea-2000-128002.activeMotorMode", "Active Motor Mode")
local brakeMode = ProtoField.uint32("nmea-2000-128002.brakeMode", "Brake Mode")
local rotationalShaftSpeed = ProtoField.float("nmea-2000-128002.rotationalShaftSpeed", "Rotational Shaft Speed (rpm)")
local motorDcVoltage = ProtoField.float("nmea-2000-128002.motorDcVoltage", "Motor DC Voltage (V)")
local motorDcCurrent = ProtoField.float("nmea-2000-128002.motorDcCurrent", "Motor DC Current (A)")

NMEA_2000_128002.fields = {inverterMotorController,activeMotorMode,brakeMode,rotationalShaftSpeed,motorDcVoltage,motorDcCurrent}

function NMEA_2000_128002.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128002 (Electric Drive Status, Rapid Update)"
    local subtree = tree:add(NMEA_2000_128002, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(inverterMotorController, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        local _rng = buffer(str_offset + 1, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 2)
        subtree:add(activeMotorMode, _rng, _val)
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        local _rng = buffer(str_offset + 1, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 2)) % (2 ^ 2)
        subtree:add(brakeMode, _rng, _val)
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add(rotationalShaftSpeed, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 0.25)
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add(motorDcVoltage, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 0.1)
    end
    if buffer:len() >= (str_offset + 6 + 2) then
        subtree:add(motorDcCurrent, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_int() * 0.1)
    end
end

return NMEA_2000_128002
