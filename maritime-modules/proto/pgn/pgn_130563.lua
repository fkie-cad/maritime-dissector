-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130563 = Proto("nmea-2000-130563", "Lighting Device (130563)")
local deviceId = ProtoField.float("nmea-2000-130563.deviceId", "Device ID")
local deviceCapabilities = ProtoField.float("nmea-2000-130563.deviceCapabilities", "Device Capabilities")
local colorCapabilities = ProtoField.float("nmea-2000-130563.colorCapabilities", "Color Capabilities")
local zoneIndex = ProtoField.float("nmea-2000-130563.zoneIndex", "Zone Index")
local nameOfLightingDevice = ProtoField.string("nmea-2000-130563.nameOfLightingDevice", "Name of Lighting Device")

NMEA_2000_130563.fields = {deviceId,deviceCapabilities,colorCapabilities,zoneIndex,nameOfLightingDevice}

function NMEA_2000_130563.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130563 (Lighting Device)"
    local subtree = tree:add(NMEA_2000_130563, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(deviceId, buffer(str_offset + 0, 4), buffer(str_offset + 0, 4):le_uint() * 1)
    subtree:add(deviceCapabilities, buffer(str_offset + 4, 1), buffer(str_offset + 4, 1):le_uint() * 1)
    subtree:add(colorCapabilities, buffer(str_offset + 5, 1), buffer(str_offset + 5, 1):le_uint() * 1)
    subtree:add(zoneIndex, buffer(str_offset + 6, 1), buffer(str_offset + 6, 1):le_uint() * 1)
    length = buffer(str_offset + 7, 1):uint() - 2
    -- type = buffer(str_offset + 7 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(nameOfLightingDevice, buffer(str_offset + 7 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_130563
