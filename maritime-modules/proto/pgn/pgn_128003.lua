-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128003 = Proto("nmea-2000-128003", "Electric Energy Storage Status, Rapid Update (128003)")
local energyStorageIdentifier = ProtoField.uint8("nmea-2000-128003.energyStorageIdentifier", "Energy Storage Identifier")
local batteryStatus = ProtoField.uint32("nmea-2000-128003.batteryStatus", "Battery Status")
local isolationStatus = ProtoField.uint32("nmea-2000-128003.isolationStatus", "Isolation Status")
local batteryError = ProtoField.uint32("nmea-2000-128003.batteryError", "Battery Error")
local batteryVoltage = ProtoField.float("nmea-2000-128003.batteryVoltage", "Battery Voltage (V)")
local batteryCurrent = ProtoField.float("nmea-2000-128003.batteryCurrent", "Battery Current (A)")

NMEA_2000_128003.fields = {energyStorageIdentifier,batteryStatus,isolationStatus,batteryError,batteryVoltage,batteryCurrent}

function NMEA_2000_128003.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128003 (Electric Energy Storage Status, Rapid Update)"
    local subtree = tree:add(NMEA_2000_128003, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(energyStorageIdentifier, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        local _rng = buffer(str_offset + 1, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 2)
        subtree:add(batteryStatus, _rng, _val)
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        local _rng = buffer(str_offset + 1, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 2)) % (2 ^ 2)
        subtree:add(isolationStatus, _rng, _val)
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        local _rng = buffer(str_offset + 1, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 4)) % (2 ^ 4)
        subtree:add(batteryError, _rng, _val)
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add(batteryVoltage, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 0.1)
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add(batteryCurrent, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_int() * 0.1)
    end
end

return NMEA_2000_128003
