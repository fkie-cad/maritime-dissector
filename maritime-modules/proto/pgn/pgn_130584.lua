-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130584 = Proto("nmea-2000-130584", "Available Bluetooth addresses (130584)")
local firstAddress = ProtoField.uint8("nmea-2000-130584.firstAddress", "First address")
local addressCount = ProtoField.uint8("nmea-2000-130584.addressCount", "Address count")
local totalAddressCount = ProtoField.uint8("nmea-2000-130584.totalAddressCount", "Total address count")
local bluetoothAddress = ProtoField.bytes("nmea-2000-130584.bluetoothAddress", "Bluetooth address")
local status = ProtoField.uint8("nmea-2000-130584.status", "Status", base.DEC, NULL, 0xff)
local deviceName = ProtoField.string("nmea-2000-130584.deviceName", "Device name")
local signalStrength = ProtoField.uint8("nmea-2000-130584.signalStrength", "Signal strength (%)")

NMEA_2000_130584.fields = {firstAddress,addressCount,totalAddressCount,bluetoothAddress,status,deviceName,signalStrength}

function NMEA_2000_130584.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130584 (Available Bluetooth addresses)"
    local subtree = tree:add(NMEA_2000_130584, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(firstAddress, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(addressCount, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(totalAddressCount, buffer(str_offset + 2, 1))
    end
    local count_1 = buffer(1, 1):uint()
    if count_1 > 100 then count_1 = 0 end  -- sentinel check
    local cursor_1 = str_offset
    for _i_1 = 1, count_1 do
        if cursor_1 >= buffer:len() then break end
        if buffer:len() >= (cursor_1 + 6) then
            subtree:add(bluetoothAddress, buffer(cursor_1, 6))
            cursor_1 = cursor_1 + 6
        end
        if buffer:len() >= (cursor_1 + 1) then
            subtree:add(status, buffer(cursor_1, 1))
            cursor_1 = cursor_1 + 1
        end
        if buffer:len() > cursor_1 then
            local _deviceName_len = buffer(cursor_1, 1):uint()
            if _deviceName_len >= 2 and buffer:len() >= (cursor_1 + _deviceName_len) then
                subtree:add(deviceName, buffer(cursor_1 + 2, _deviceName_len - 2))
                cursor_1 = cursor_1 + _deviceName_len
            elseif _deviceName_len == 0 or _deviceName_len == 1 then
                cursor_1 = cursor_1 + math.max(1, _deviceName_len)  -- empty string
            else
                cursor_1 = cursor_1 + 1  -- malformed, skip length byte
            end
        end
        if buffer:len() >= (cursor_1 + 1) then
            subtree:add(signalStrength, buffer(cursor_1, 1))
            cursor_1 = cursor_1 + 1
        end
    end
end

return NMEA_2000_130584
