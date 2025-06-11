-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127511 = Proto("nmea-2000-127511", "Inverter Configuration Status (127511)")
local instance = ProtoField.float("nmea-2000-127511.instance", "Instance")
local acInstance = ProtoField.float("nmea-2000-127511.acInstance", "AC Instance")
local dcInstance = ProtoField.float("nmea-2000-127511.dcInstance", "DC Instance")
local inverterEnableDisable = ProtoField.uint8("nmea-2000-127511.inverterEnableDisable", "Inverter Enable/Disable", base.DEC, NULL, 0x3)
local inverterMode = ProtoField.uint8("nmea-2000-127511.inverterMode", "Inverter Mode", base.DEC, NULL, 0x3c)
local loadSenseEnableDisable = ProtoField.uint8("nmea-2000-127511.loadSenseEnableDisable", "Load Sense Enable/Disable", base.DEC, NULL, 0xc0)
local loadSensePowerThreshold = ProtoField.float("nmea-2000-127511.loadSensePowerThreshold", "Load Sense Power Threshold (W)")
local loadSenseInterval = ProtoField.float("nmea-2000-127511.loadSenseInterval", "Load Sense Interval (s)")

NMEA_2000_127511.fields = {instance,acInstance,dcInstance,inverterEnableDisable,inverterMode,loadSenseEnableDisable,loadSensePowerThreshold,loadSenseInterval}

function NMEA_2000_127511.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127511 (Inverter Configuration Status)"
    local subtree = tree:add(NMEA_2000_127511, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(instance, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(acInstance, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(dcInstance, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(inverterEnableDisable, buffer(str_offset + 3, 1))
    subtree:add(inverterMode, buffer(str_offset + 3, 1))
    subtree:add(loadSenseEnableDisable, buffer(str_offset + 3, 1))
    subtree:add(loadSensePowerThreshold, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 1)
    subtree:add(loadSenseInterval, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 0.01)
end

return NMEA_2000_127511
