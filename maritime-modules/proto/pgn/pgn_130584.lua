-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130584 = Proto("nmea-2000-130584", "Available Bluetooth addresses (130584)")
local firstAddress = ProtoField.float("nmea-2000-130584.firstAddress", "First address")
local addressCount = ProtoField.float("nmea-2000-130584.addressCount", "Address count")
local totalAddressCount = ProtoField.float("nmea-2000-130584.totalAddressCount", "Total address count")
local status = ProtoField.uint8("nmea-2000-130584.status", "Status", base.DEC, NULL, 0xff)
local deviceName = ProtoField.string("nmea-2000-130584.deviceName", "Device name")

NMEA_2000_130584.fields = {firstAddress,addressCount,totalAddressCount,status,deviceName}

function NMEA_2000_130584.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130584 (Available Bluetooth addresses)"
    local subtree = tree:add(NMEA_2000_130584, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(firstAddress, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(addressCount, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(totalAddressCount, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(status, buffer(str_offset + 9, 1))
    length = buffer(str_offset + 10, 1):uint() - 2
    -- type = buffer(str_offset + 10 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(deviceName, buffer(str_offset + 10 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_130584
