-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127512 = Proto("nmea-2000-127512", "AGS Configuration Status (127512)")
local instance = ProtoField.float("nmea-2000-127512.instance", "Instance")
local generatorInstance = ProtoField.float("nmea-2000-127512.generatorInstance", "Generator Instance")
local agsMode = ProtoField.uint8("nmea-2000-127512.agsMode", "AGS Mode", base.DEC, NULL, 0xf)

NMEA_2000_127512.fields = {instance,generatorInstance,agsMode}

function NMEA_2000_127512.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127512 (AGS Configuration Status)"
    local subtree = tree:add(NMEA_2000_127512, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(instance, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(generatorInstance, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(agsMode, buffer(str_offset + 2, 1))
end

return NMEA_2000_127512
