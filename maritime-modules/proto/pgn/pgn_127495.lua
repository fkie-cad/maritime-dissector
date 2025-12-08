-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127495 = Proto("nmea-2000-127495", "Electric Energy Storage Information (127495)")
local energyStorageIdentifier = ProtoField.uint8("nmea-2000-127495.energyStorageIdentifier", "Energy Storage Identifier")
local motorType = ProtoField.uint32("nmea-2000-127495.motorType", "Motor Type")
local storageChemistryConversion = ProtoField.uint8("nmea-2000-127495.storageChemistryConversion", "Storage Chemistry/Conversion")
local maximumTemperatureDerating = ProtoField.float("nmea-2000-127495.maximumTemperatureDerating", "Maximum Temperature Derating (K)")
local maximumTemperatureShutOff = ProtoField.float("nmea-2000-127495.maximumTemperatureShutOff", "Maximum Temperature Shut Off (K)")
local minimumTemperatureDerating = ProtoField.float("nmea-2000-127495.minimumTemperatureDerating", "Minimum Temperature Derating (K)")
local minimumTemperatureShutOff = ProtoField.float("nmea-2000-127495.minimumTemperatureShutOff", "Minimum Temperature Shut Off (K)")
local usableBatteryEnergy = ProtoField.uint32("nmea-2000-127495.usableBatteryEnergy", "Usable Battery Energy (kWh)")
local stateOfHealth = ProtoField.uint8("nmea-2000-127495.stateOfHealth", "State of Health")
local batteryCycleCounter = ProtoField.uint16("nmea-2000-127495.batteryCycleCounter", "Battery Cycle Counter")
local batteryFullStatus = ProtoField.uint32("nmea-2000-127495.batteryFullStatus", "Battery Full Status")
local batteryEmptyStatus = ProtoField.uint32("nmea-2000-127495.batteryEmptyStatus", "Battery Empty Status")
local maximumChargeSoc = ProtoField.uint8("nmea-2000-127495.maximumChargeSoc", "Maximum Charge (SOC)")
local minimumChargeSoc = ProtoField.uint8("nmea-2000-127495.minimumChargeSoc", "Minimum Charge (SOC)")

NMEA_2000_127495.fields = {energyStorageIdentifier,motorType,storageChemistryConversion,maximumTemperatureDerating,maximumTemperatureShutOff,minimumTemperatureDerating,minimumTemperatureShutOff,usableBatteryEnergy,stateOfHealth,batteryCycleCounter,batteryFullStatus,batteryEmptyStatus,maximumChargeSoc,minimumChargeSoc}

function NMEA_2000_127495.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127495 (Electric Energy Storage Information)"
    local subtree = tree:add(NMEA_2000_127495, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(energyStorageIdentifier, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        local _rng = buffer(str_offset + 1, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 4)
        subtree:add(motorType, _rng, _val)
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(storageChemistryConversion, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 3 + 2) then
        subtree:add(maximumTemperatureDerating, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 5 + 2) then
        subtree:add(maximumTemperatureShutOff, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 7 + 2) then
        subtree:add(minimumTemperatureDerating, buffer(str_offset + 7, 2), buffer(str_offset + 7, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 9 + 2) then
        subtree:add(minimumTemperatureShutOff, buffer(str_offset + 9, 2), buffer(str_offset + 9, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 11 + 4) then
        subtree:add_le(usableBatteryEnergy, buffer(str_offset + 11, 4))
    end
    if buffer:len() >= (str_offset + 15 + 1) then
        subtree:add(stateOfHealth, buffer(str_offset + 15, 1))
    end
    if buffer:len() >= (str_offset + 16 + 2) then
        subtree:add_le(batteryCycleCounter, buffer(str_offset + 16, 2))
    end
    if buffer:len() >= (str_offset + 18 + 1) then
        local _rng = buffer(str_offset + 18, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 2)
        subtree:add(batteryFullStatus, _rng, _val)
    end
    if buffer:len() >= (str_offset + 18 + 1) then
        local _rng = buffer(str_offset + 18, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 2)) % (2 ^ 2)
        subtree:add(batteryEmptyStatus, _rng, _val)
    end
    if buffer:len() >= (str_offset + 19 + 1) then
        subtree:add(maximumChargeSoc, buffer(str_offset + 19, 1))
    end
    if buffer:len() >= (str_offset + 20 + 1) then
        subtree:add(minimumChargeSoc, buffer(str_offset + 20, 1))
    end
end

return NMEA_2000_127495
