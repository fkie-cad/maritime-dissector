-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130330 = Proto("nmea-2000-130330", "Lighting System Settings (130330)")
local globalEnable = ProtoField.uint32("nmea-2000-130330.globalEnable", "Global Enable")
local defaultSettingsCommand = ProtoField.uint8("nmea-2000-130330.defaultSettingsCommand", "Default Settings/Command", base.DEC, NULL, 0x1c)
local nameOfTheLightingController = ProtoField.string("nmea-2000-130330.nameOfTheLightingController", "Name of the lighting controller")
local maxScenes = ProtoField.uint8("nmea-2000-130330.maxScenes", "Max Scenes")
local maxSceneConfigurationCount = ProtoField.uint8("nmea-2000-130330.maxSceneConfigurationCount", "Max Scene Configuration Count")
local maxZones = ProtoField.uint8("nmea-2000-130330.maxZones", "Max Zones")
local maxColorSequences = ProtoField.uint8("nmea-2000-130330.maxColorSequences", "Max Color Sequences")
local maxColorSequenceColorCount = ProtoField.uint8("nmea-2000-130330.maxColorSequenceColorCount", "Max Color Sequence Color Count")
local numberOfPrograms = ProtoField.uint8("nmea-2000-130330.numberOfPrograms", "Number of Programs")
local controllerCapabilities = ProtoField.uint8("nmea-2000-130330.controllerCapabilities", "Controller Capabilities")
local identifyDevice = ProtoField.uint32("nmea-2000-130330.identifyDevice", "Identify Device")

NMEA_2000_130330.fields = {globalEnable,defaultSettingsCommand,nameOfTheLightingController,maxScenes,maxSceneConfigurationCount,maxZones,maxColorSequences,maxColorSequenceColorCount,numberOfPrograms,controllerCapabilities,identifyDevice}

function NMEA_2000_130330.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130330 (Lighting System Settings)"
    local subtree = tree:add(NMEA_2000_130330, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        local _rng = buffer(str_offset, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 2)
        subtree:add(globalEnable, _rng, _val)
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(defaultSettingsCommand, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        length = buffer(str_offset + 1, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 1 + 2 + length) then
            -- type = buffer(str_offset + 1 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(nameOfTheLightingController, buffer(str_offset + 1 + 2, length))
            str_offset = str_offset + 1 + length + 2
        end
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(maxScenes, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(maxSceneConfigurationCount, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(maxZones, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(maxColorSequences, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(maxColorSequenceColorCount, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(numberOfPrograms, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(controllerCapabilities, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 4) then
        subtree:add_le(identifyDevice, buffer(str_offset, 4))
        str_offset = str_offset + 4
    end
end

return NMEA_2000_130330
