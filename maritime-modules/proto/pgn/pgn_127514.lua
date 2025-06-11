-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127514 = Proto("nmea-2000-127514", "AGS Status (127514)")
local instance = ProtoField.float("nmea-2000-127514.instance", "Instance")
local generatorInstance = ProtoField.float("nmea-2000-127514.generatorInstance", "Generator Instance")
local agsOperatingState = ProtoField.uint8("nmea-2000-127514.agsOperatingState", "AGS Operating State", base.DEC, NULL, 0xf)
local generatorState = ProtoField.uint8("nmea-2000-127514.generatorState", "Generator State", base.DEC, NULL, 0xf0)
local generatorOnReason = ProtoField.uint8("nmea-2000-127514.generatorOnReason", "Generator On Reason", base.DEC, NULL, 0xff)
local generatorOffReason = ProtoField.uint8("nmea-2000-127514.generatorOffReason", "Generator Off Reason", base.DEC, NULL, 0xff)

NMEA_2000_127514.fields = {instance,generatorInstance,agsOperatingState,generatorState,generatorOnReason,generatorOffReason}

function NMEA_2000_127514.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127514 (AGS Status)"
    local subtree = tree:add(NMEA_2000_127514, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(instance, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(generatorInstance, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(agsOperatingState, buffer(str_offset + 2, 1))
    subtree:add(generatorState, buffer(str_offset + 2, 1))
    subtree:add(generatorOnReason, buffer(str_offset + 3, 1))
    subtree:add(generatorOffReason, buffer(str_offset + 4, 1))
end

return NMEA_2000_127514
