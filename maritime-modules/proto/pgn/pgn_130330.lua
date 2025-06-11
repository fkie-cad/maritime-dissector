-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130330 = Proto("nmea-2000-130330", "Lighting System Settings (130330)")
local defaultSettingsCommand = ProtoField.uint8("nmea-2000-130330.defaultSettingsCommand", "Default Settings/Command", base.DEC, NULL, 0x1c)
local nameOfTheLightingController = ProtoField.string("nmea-2000-130330.nameOfTheLightingController", "Name of the lighting controller")

NMEA_2000_130330.fields = {defaultSettingsCommand,nameOfTheLightingController}

function NMEA_2000_130330.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130330 (Lighting System Settings)"
    local subtree = tree:add(NMEA_2000_130330, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(defaultSettingsCommand, buffer(str_offset + 0, 1))
    length = buffer(str_offset + 1, 1):uint() - 2
    -- type = buffer(str_offset + 1 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(nameOfTheLightingController, buffer(str_offset + 1 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_130330
