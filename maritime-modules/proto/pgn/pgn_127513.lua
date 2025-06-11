-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127513 = Proto("nmea-2000-127513", "Battery Configuration Status (127513)")
local instance = ProtoField.float("nmea-2000-127513.instance", "Instance")
local batteryType = ProtoField.uint8("nmea-2000-127513.batteryType", "Battery Type", base.DEC, NULL, 0xf)
local supportsEqualization = ProtoField.uint8("nmea-2000-127513.supportsEqualization", "Supports Equalization", base.DEC, NULL, 0x30)
local nominalVoltage = ProtoField.uint8("nmea-2000-127513.nominalVoltage", "Nominal Voltage", base.DEC, NULL, 0xf)
local chemistry = ProtoField.uint8("nmea-2000-127513.chemistry", "Chemistry", base.DEC, NULL, 0xf0)
local capacity = ProtoField.float("nmea-2000-127513.capacity", "Capacity (C)")
local temperatureCoefficient = ProtoField.float("nmea-2000-127513.temperatureCoefficient", "Temperature Coefficient (%)")
local peukertExponent = ProtoField.float("nmea-2000-127513.peukertExponent", "Peukert Exponent")
local chargeEfficiencyFactor = ProtoField.float("nmea-2000-127513.chargeEfficiencyFactor", "Charge Efficiency Factor (%)")

NMEA_2000_127513.fields = {instance,batteryType,supportsEqualization,nominalVoltage,chemistry,capacity,temperatureCoefficient,peukertExponent,chargeEfficiencyFactor}

function NMEA_2000_127513.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127513 (Battery Configuration Status)"
    local subtree = tree:add(NMEA_2000_127513, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(instance, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(batteryType, buffer(str_offset + 1, 1))
    subtree:add(supportsEqualization, buffer(str_offset + 1, 1))
    subtree:add(nominalVoltage, buffer(str_offset + 2, 1))
    subtree:add(chemistry, buffer(str_offset + 2, 1))
    subtree:add(capacity, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_uint() * 3600)
    subtree:add(temperatureCoefficient, buffer(str_offset + 5, 1), buffer(str_offset + 5, 1):le_int() * 1)
    subtree:add(peukertExponent, buffer(str_offset + 6, 1), buffer(str_offset + 6, 1):le_uint() * 0.002)
    subtree:add(chargeEfficiencyFactor, buffer(str_offset + 7, 1), buffer(str_offset + 7, 1):le_int() * 1)
end

return NMEA_2000_127513
