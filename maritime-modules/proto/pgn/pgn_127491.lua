-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127491 = Proto("nmea-2000-127491", "Electric Energy Storage Status, Dynamic (127491)")
local energyStorageIdentifier = ProtoField.uint8("nmea-2000-127491.energyStorageIdentifier", "Energy Storage Identifier")
local stateOfCharge = ProtoField.uint8("nmea-2000-127491.stateOfCharge", "State of Charge (%)")
local timeRemaining = ProtoField.float("nmea-2000-127491.timeRemaining", "Time Remaining (s)")
local highestCellTemperature = ProtoField.float("nmea-2000-127491.highestCellTemperature", "Highest Cell Temperature (K)")
local lowestCellTemperature = ProtoField.float("nmea-2000-127491.lowestCellTemperature", "Lowest Cell Temperature (K)")
local averageCellTemperature = ProtoField.float("nmea-2000-127491.averageCellTemperature", "Average Cell Temperature (K)")
local maxDischargeCurrent = ProtoField.float("nmea-2000-127491.maxDischargeCurrent", "Max Discharge Current (A)")
local maxChargeCurrent = ProtoField.float("nmea-2000-127491.maxChargeCurrent", "Max Charge Current (A)")
local coolingSystemStatus = ProtoField.uint32("nmea-2000-127491.coolingSystemStatus", "Cooling System Status")
local heatingSystemStatus = ProtoField.uint32("nmea-2000-127491.heatingSystemStatus", "Heating System Status")

NMEA_2000_127491.fields = {energyStorageIdentifier,stateOfCharge,timeRemaining,highestCellTemperature,lowestCellTemperature,averageCellTemperature,maxDischargeCurrent,maxChargeCurrent,coolingSystemStatus,heatingSystemStatus}

function NMEA_2000_127491.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127491 (Electric Energy Storage Status, Dynamic)"
    local subtree = tree:add(NMEA_2000_127491, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(energyStorageIdentifier, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(stateOfCharge, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add(timeRemaining, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 60)
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add(highestCellTemperature, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 6 + 2) then
        subtree:add(lowestCellTemperature, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 8 + 2) then
        subtree:add(averageCellTemperature, buffer(str_offset + 8, 2), buffer(str_offset + 8, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 10 + 2) then
        subtree:add(maxDischargeCurrent, buffer(str_offset + 10, 2), buffer(str_offset + 10, 2):le_int() * 0.1)
    end
    if buffer:len() >= (str_offset + 12 + 2) then
        subtree:add(maxChargeCurrent, buffer(str_offset + 12, 2), buffer(str_offset + 12, 2):le_int() * 0.1)
    end
    if buffer:len() >= (str_offset + 14 + 1) then
        local _rng = buffer(str_offset + 14, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 4)
        subtree:add(coolingSystemStatus, _rng, _val)
    end
    if buffer:len() >= (str_offset + 14 + 1) then
        local _rng = buffer(str_offset + 14, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 4)) % (2 ^ 4)
        subtree:add(heatingSystemStatus, _rng, _val)
    end
end

return NMEA_2000_127491
