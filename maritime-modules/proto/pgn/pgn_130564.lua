-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130564 = Proto("nmea-2000-130564", "Lighting Device Enumeration (130564)")
local indexOfFirstDevice = ProtoField.uint16("nmea-2000-130564.indexOfFirstDevice", "Index of First Device")
local totalNumberOfDevices = ProtoField.uint16("nmea-2000-130564.totalNumberOfDevices", "Total Number of Devices")
local numberOfDevices = ProtoField.uint16("nmea-2000-130564.numberOfDevices", "Number of Devices")
local deviceId = ProtoField.uint32("nmea-2000-130564.deviceId", "Device ID")
local status = ProtoField.uint8("nmea-2000-130564.status", "Status")

NMEA_2000_130564.fields = {indexOfFirstDevice,totalNumberOfDevices,numberOfDevices,deviceId,status}

function NMEA_2000_130564.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130564 (Lighting Device Enumeration)"
    local subtree = tree:add(NMEA_2000_130564, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 2) then
        subtree:add_le(indexOfFirstDevice, buffer(str_offset, 2))
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add_le(totalNumberOfDevices, buffer(str_offset + 2, 2))
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add_le(numberOfDevices, buffer(str_offset + 4, 2))
    end
    local count_1 = buffer(str_offset + 4, 2):le_uint()
    if count_1 > 100 then count_1 = 0 end  -- likely 'not available' sentinel
    local rep_offset_1 = str_offset + 6
    for _i_1 = 1, count_1 do
    if rep_offset_1 + 5 > buffer:len() then break end
    do
        local _start = rep_offset_1 + 0
        if buffer:len() >= (_start + 4) then
            local _rng = buffer(_start, 4)
            local _raw = _rng:le_uint()
            local _val = _raw
            subtree:add(deviceId, _rng, _val)
        end
    end
    do
        local _start = rep_offset_1 + 4
        if buffer:len() >= (_start + 1) then
            local _rng = buffer(_start, 1)
            local _raw = _rng:uint()
            local _val = _raw
            subtree:add(status, _rng, _val)
        end
    end
    rep_offset_1 = rep_offset_1 + 5
    end
end

return NMEA_2000_130564
