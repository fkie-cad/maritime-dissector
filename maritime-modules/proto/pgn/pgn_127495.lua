-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127495 = Proto("nmea-2000-127495", "Electric Energy Storage Information (127495)")
local energyStorageIdentifier = ProtoField.float("nmea-2000-127495.energyStorageIdentifier", "Energy Storage Identifier")
local storageChemistryConversion = ProtoField.float("nmea-2000-127495.storageChemistryConversion", "Storage Chemistry/Conversion")
local maximumTemperatureDerating = ProtoField.float("nmea-2000-127495.maximumTemperatureDerating", "Maximum Temperature Derating (K)")
local maximumTemperatureShutOff = ProtoField.float("nmea-2000-127495.maximumTemperatureShutOff", "Maximum Temperature Shut Off (K)")
local minimumTemperatureDerating = ProtoField.float("nmea-2000-127495.minimumTemperatureDerating", "Minimum Temperature Derating (K)")
local minimumTemperatureShutOff = ProtoField.float("nmea-2000-127495.minimumTemperatureShutOff", "Minimum Temperature Shut Off (K)")
local usableBatteryEnergy = ProtoField.float("nmea-2000-127495.usableBatteryEnergy", "Usable Battery Energy (J)")
local stateOfHealth = ProtoField.float("nmea-2000-127495.stateOfHealth", "State of Health")
local batteryCycleCounter = ProtoField.float("nmea-2000-127495.batteryCycleCounter", "Battery Cycle Counter")
local maximumChargeSoc = ProtoField.float("nmea-2000-127495.maximumChargeSoc", "Maximum Charge (SOC)")
local minimumChargeSoc = ProtoField.float("nmea-2000-127495.minimumChargeSoc", "Minimum Charge (SOC)")

NMEA_2000_127495.fields = {energyStorageIdentifier,storageChemistryConversion,maximumTemperatureDerating,maximumTemperatureShutOff,minimumTemperatureDerating,minimumTemperatureShutOff,usableBatteryEnergy,stateOfHealth,batteryCycleCounter,maximumChargeSoc,minimumChargeSoc}

function NMEA_2000_127495.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127495 (Electric Energy Storage Information)"
    local subtree = tree:add(NMEA_2000_127495, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(energyStorageIdentifier, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(storageChemistryConversion, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(maximumTemperatureDerating, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_uint() * 0.01)
    subtree:add(maximumTemperatureShutOff, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_uint() * 0.01)
    subtree:add(minimumTemperatureDerating, buffer(str_offset + 7, 2), buffer(str_offset + 7, 2):le_uint() * 0.01)
    subtree:add(minimumTemperatureShutOff, buffer(str_offset + 9, 2), buffer(str_offset + 9, 2):le_uint() * 0.01)
    subtree:add(usableBatteryEnergy, buffer(str_offset + 11, 4), buffer(str_offset + 11, 4):le_uint() * 3600000.0)
    subtree:add(stateOfHealth, buffer(str_offset + 15, 1), buffer(str_offset + 15, 1):le_uint() * 1)
    subtree:add(batteryCycleCounter, buffer(str_offset + 16, 2), buffer(str_offset + 16, 2):le_uint() * 1)
    subtree:add(maximumChargeSoc, buffer(str_offset + 19, 1), buffer(str_offset + 19, 1):le_uint() * 1)
    subtree:add(minimumChargeSoc, buffer(str_offset + 20, 1), buffer(str_offset + 20, 1):le_uint() * 1)
end

return NMEA_2000_127495
