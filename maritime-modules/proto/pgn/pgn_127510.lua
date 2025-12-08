-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127510 = Proto("nmea-2000-127510", "Charger Configuration Status (127510)")
local instance = ProtoField.uint8("nmea-2000-127510.instance", "Instance")
local batteryInstance = ProtoField.uint8("nmea-2000-127510.batteryInstance", "Battery Instance")
local chargerEnableDisable = ProtoField.uint8("nmea-2000-127510.chargerEnableDisable", "Charger Enable/Disable", base.DEC, NULL, 0x3)
local chargeCurrentLimit = ProtoField.uint8("nmea-2000-127510.chargeCurrentLimit", "Charge Current Limit (%)")
local chargingAlgorithm = ProtoField.uint8("nmea-2000-127510.chargingAlgorithm", "Charging Algorithm", base.DEC, NULL, 0xf)
local chargerMode = ProtoField.uint8("nmea-2000-127510.chargerMode", "Charger Mode", base.DEC, NULL, 0xf0)
local estimatedTemperature = ProtoField.uint8("nmea-2000-127510.estimatedTemperature", "Estimated Temperature", base.DEC, NULL, 0xf)
local equalizeOneTimeEnableDisable = ProtoField.uint8("nmea-2000-127510.equalizeOneTimeEnableDisable", "Equalize One Time Enable/Disable", base.DEC, NULL, 0x30)
local overChargeEnableDisable = ProtoField.uint8("nmea-2000-127510.overChargeEnableDisable", "Over Charge Enable/Disable", base.DEC, NULL, 0xc0)
local equalizeTime = ProtoField.float("nmea-2000-127510.equalizeTime", "Equalize Time (s)")

NMEA_2000_127510.fields = {instance,batteryInstance,chargerEnableDisable,chargeCurrentLimit,chargingAlgorithm,chargerMode,estimatedTemperature,equalizeOneTimeEnableDisable,overChargeEnableDisable,equalizeTime}

function NMEA_2000_127510.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127510 (Charger Configuration Status)"
    local subtree = tree:add(NMEA_2000_127510, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(instance, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(batteryInstance, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(chargerEnableDisable, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(chargeCurrentLimit, buffer(str_offset + 3, 1))
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        subtree:add(chargingAlgorithm, buffer(str_offset + 4, 1))
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        subtree:add(chargerMode, buffer(str_offset + 4, 1))
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        subtree:add(estimatedTemperature, buffer(str_offset + 5, 1))
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        subtree:add(equalizeOneTimeEnableDisable, buffer(str_offset + 5, 1))
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        subtree:add(overChargeEnableDisable, buffer(str_offset + 5, 1))
    end
    if buffer:len() >= (str_offset + 6 + 2) then
        subtree:add(equalizeTime, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 60)
    end
end

return NMEA_2000_127510
