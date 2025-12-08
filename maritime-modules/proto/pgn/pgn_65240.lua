-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_65240 = Proto("nmea-2000-65240", "ISO Commanded Address (65240)")
local uniqueNumber = ProtoField.uint32("nmea-2000-65240.uniqueNumber", "Unique Number", base.HEX)
local manufacturerCode = ProtoField.uint32("nmea-2000-65240.manufacturerCode", "Manufacturer Code")
local deviceInstanceLower = ProtoField.uint32("nmea-2000-65240.deviceInstanceLower", "Device Instance Lower")
local deviceInstanceUpper = ProtoField.uint32("nmea-2000-65240.deviceInstanceUpper", "Device Instance Upper")
local deviceFunction = ProtoField.uint8("nmea-2000-65240.deviceFunction", "Device Function", base.DEC)
local deviceClass = ProtoField.uint8("nmea-2000-65240.deviceClass", "Device Class", base.DEC, NULL, 0xfe)
local systemInstance = ProtoField.uint32("nmea-2000-65240.systemInstance", "System Instance")
local industryCode = ProtoField.uint8("nmea-2000-65240.industryCode", "Industry Code", base.DEC, NULL, 0x70)
local newSourceAddress = ProtoField.uint8("nmea-2000-65240.newSourceAddress", "New Source Address")

NMEA_2000_65240.fields = {uniqueNumber,manufacturerCode,deviceInstanceLower,deviceInstanceUpper,deviceFunction,deviceClass,systemInstance,industryCode,newSourceAddress}

function NMEA_2000_65240.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 65240 (ISO Commanded Address)"
    local subtree = tree:add(NMEA_2000_65240, buffer(), subtree_title)
    local str_offset = 0

    do
        local _rng = buffer(str_offset, 3)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 21)
        subtree:add(uniqueNumber, _rng, _val)
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        local _rng = buffer(str_offset + 2, 2)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 5)) % (2 ^ 11)
        subtree:add(manufacturerCode, _rng, _val)
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        local _rng = buffer(str_offset + 4, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 3)
        subtree:add(deviceInstanceLower, _rng, _val)
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        local _rng = buffer(str_offset + 4, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 3)) % (2 ^ 5)
        subtree:add(deviceInstanceUpper, _rng, _val)
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        subtree:add(deviceFunction, buffer(str_offset + 5, 1))
    end
    if buffer:len() >= (str_offset + 6 + 1) then
        subtree:add(deviceClass, buffer(str_offset + 6, 1))
    end
    if buffer:len() >= (str_offset + 7 + 1) then
        local _rng = buffer(str_offset + 7, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 4)
        subtree:add(systemInstance, _rng, _val)
    end
    if buffer:len() >= (str_offset + 7 + 1) then
        subtree:add(industryCode, buffer(str_offset + 7, 1))
    end
    if buffer:len() >= (str_offset + 8 + 1) then
        subtree:add(newSourceAddress, buffer(str_offset + 8, 1))
    end
end

return NMEA_2000_65240
