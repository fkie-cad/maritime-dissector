-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128003 = Proto("nmea-2000-128003", "Electric Energy Storage Status, Rapid Update (128003)")
local energyStorageIdentifier = ProtoField.float("nmea-2000-128003.energyStorageIdentifier", "Energy Storage Identifier")
local batteryVoltage = ProtoField.float("nmea-2000-128003.batteryVoltage", "Battery Voltage (V)")
local batteryCurrent = ProtoField.float("nmea-2000-128003.batteryCurrent", "Battery Current (A)")

NMEA_2000_128003.fields = {energyStorageIdentifier,batteryVoltage,batteryCurrent}

function NMEA_2000_128003.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128003 (Electric Energy Storage Status, Rapid Update)"
    local subtree = tree:add(NMEA_2000_128003, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(energyStorageIdentifier, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(batteryVoltage, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 0.1)
    subtree:add(batteryCurrent, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_int() * 0.1)
end

return NMEA_2000_128003
