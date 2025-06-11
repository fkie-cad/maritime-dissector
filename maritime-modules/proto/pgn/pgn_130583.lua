-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130583 = Proto("nmea-2000-130583", "Available Audio EQ presets (130583)")
local firstPreset = ProtoField.float("nmea-2000-130583.firstPreset", "First preset")
local presetCount = ProtoField.float("nmea-2000-130583.presetCount", "Preset count")
local totalPresetCount = ProtoField.float("nmea-2000-130583.totalPresetCount", "Total preset count")
local presetType = ProtoField.uint8("nmea-2000-130583.presetType", "Preset type", base.DEC, NULL, 0xff)
local presetName = ProtoField.string("nmea-2000-130583.presetName", "Preset name")

NMEA_2000_130583.fields = {firstPreset,presetCount,totalPresetCount,presetType,presetName}

function NMEA_2000_130583.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130583 (Available Audio EQ presets)"
    local subtree = tree:add(NMEA_2000_130583, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(firstPreset, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(presetCount, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(totalPresetCount, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(presetType, buffer(str_offset + 3, 1))
    length = buffer(str_offset + 4, 1):uint() - 2
    -- type = buffer(str_offset + 4 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(presetName, buffer(str_offset + 4 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_130583
