-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128780 = Proto("nmea-2000-128780", "Linear Actuator Control/Status (128780)")
local actuatorIdentifier = ProtoField.float("nmea-2000-128780.actuatorIdentifier", "Actuator Identifier")
local commandedDevicePosition = ProtoField.float("nmea-2000-128780.commandedDevicePosition", "Commanded Device Position")
local devicePosition = ProtoField.float("nmea-2000-128780.devicePosition", "Device Position")
local maximumDeviceTravel = ProtoField.float("nmea-2000-128780.maximumDeviceTravel", "Maximum Device Travel")
local directionOfTravel = ProtoField.float("nmea-2000-128780.directionOfTravel", "Direction of Travel")

NMEA_2000_128780.fields = {actuatorIdentifier,commandedDevicePosition,devicePosition,maximumDeviceTravel,directionOfTravel}

function NMEA_2000_128780.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128780 (Linear Actuator Control/Status)"
    local subtree = tree:add(NMEA_2000_128780, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(actuatorIdentifier, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(commandedDevicePosition, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(devicePosition, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(maximumDeviceTravel, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_uint() * 1)
    subtree:add(directionOfTravel, buffer(str_offset + 5, 1), buffer(str_offset + 5, 1):le_uint() * 1)
end

return NMEA_2000_128780
