-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127507 = Proto("nmea-2000-127507", "Charger Status (127507)")
local instance = ProtoField.float("nmea-2000-127507.instance", "Instance")
local batteryInstance = ProtoField.float("nmea-2000-127507.batteryInstance", "Battery Instance")
local operatingState = ProtoField.uint8("nmea-2000-127507.operatingState", "Operating State", base.DEC, NULL, 0xf)
local chargeMode = ProtoField.uint8("nmea-2000-127507.chargeMode", "Charge Mode", base.DEC, NULL, 0xf0)
local enabled = ProtoField.uint8("nmea-2000-127507.enabled", "Enabled", base.DEC, NULL, 0x3)
local equalizationPending = ProtoField.uint8("nmea-2000-127507.equalizationPending", "Equalization Pending", base.DEC, NULL, 0xc)
local equalizationTimeRemaining = ProtoField.float("nmea-2000-127507.equalizationTimeRemaining", "Equalization Time Remaining (s)")

NMEA_2000_127507.fields = {instance,batteryInstance,operatingState,chargeMode,enabled,equalizationPending,equalizationTimeRemaining}

function NMEA_2000_127507.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127507 (Charger Status)"
    local subtree = tree:add(NMEA_2000_127507, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(instance, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(batteryInstance, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(operatingState, buffer(str_offset + 2, 1))
    subtree:add(chargeMode, buffer(str_offset + 2, 1))
    subtree:add(enabled, buffer(str_offset + 3, 1))
    subtree:add(equalizationPending, buffer(str_offset + 3, 1))
    subtree:add(equalizationTimeRemaining, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 60)
end

return NMEA_2000_127507
