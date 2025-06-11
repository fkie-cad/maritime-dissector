-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130564 = Proto("nmea-2000-130564", "Lighting Device Enumeration (130564)")
local indexOfFirstDevice = ProtoField.float("nmea-2000-130564.indexOfFirstDevice", "Index of First Device")
local totalNumberOfDevices = ProtoField.float("nmea-2000-130564.totalNumberOfDevices", "Total Number of Devices")
local numberOfDevices = ProtoField.float("nmea-2000-130564.numberOfDevices", "Number of Devices")
local deviceId = ProtoField.float("nmea-2000-130564.deviceId", "Device ID")
local status = ProtoField.float("nmea-2000-130564.status", "Status")

NMEA_2000_130564.fields = {indexOfFirstDevice,totalNumberOfDevices,numberOfDevices,deviceId,status}

function NMEA_2000_130564.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130564 (Lighting Device Enumeration)"
    local subtree = tree:add(NMEA_2000_130564, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(indexOfFirstDevice, buffer(str_offset + 0, 2), buffer(str_offset + 0, 2):le_uint() * 1)
    subtree:add(totalNumberOfDevices, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 1)
    subtree:add(numberOfDevices, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 1)
    subtree:add(deviceId, buffer(str_offset + 6, 4), buffer(str_offset + 6, 4):le_uint() * 1)
    subtree:add(status, buffer(str_offset + 10, 1), buffer(str_offset + 10, 1):le_uint() * 1)
end

return NMEA_2000_130564
