-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130562 = Proto("nmea-2000-130562", "Lighting Scene (130562)")
local sceneIndex = ProtoField.uint8("nmea-2000-130562.sceneIndex", "Scene Index")
local zoneName = ProtoField.string("nmea-2000-130562.zoneName", "Zone Name")
local control = ProtoField.uint8("nmea-2000-130562.control", "Control")
local configurationCount = ProtoField.uint8("nmea-2000-130562.configurationCount", "Configuration Count")
local configurationIndex = ProtoField.uint8("nmea-2000-130562.configurationIndex", "Configuration Index")
local zoneIndex = ProtoField.uint8("nmea-2000-130562.zoneIndex", "Zone Index")
local devicesId = ProtoField.uint32("nmea-2000-130562.devicesId", "Devices ID")
local programIndex = ProtoField.uint8("nmea-2000-130562.programIndex", "Program Index")
local programColorSequenceIndex = ProtoField.uint8("nmea-2000-130562.programColorSequenceIndex", "Program Color Sequence Index")
local programIntensity = ProtoField.uint8("nmea-2000-130562.programIntensity", "Program Intensity")
local programRate = ProtoField.uint8("nmea-2000-130562.programRate", "Program Rate")
local programColorSequenceRate = ProtoField.uint8("nmea-2000-130562.programColorSequenceRate", "Program Color Sequence Rate")

NMEA_2000_130562.fields = {sceneIndex,zoneName,control,configurationCount,configurationIndex,zoneIndex,devicesId,programIndex,programColorSequenceIndex,programIntensity,programRate,programColorSequenceRate}

function NMEA_2000_130562.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130562 (Lighting Scene)"
    local subtree = tree:add(NMEA_2000_130562, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sceneIndex, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        length = buffer(str_offset + 1, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 1 + 2 + length) then
            -- type = buffer(str_offset + 1 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(zoneName, buffer(str_offset + 1 + 2, length))
            str_offset = str_offset + 1 + length + 2
        end
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(control, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(configurationCount, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(configurationIndex, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(zoneIndex, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 4) then
        subtree:add_le(devicesId, buffer(str_offset, 4))
        str_offset = str_offset + 4
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(programIndex, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(programColorSequenceIndex, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(programIntensity, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(programRate, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(programColorSequenceRate, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
end

return NMEA_2000_130562
