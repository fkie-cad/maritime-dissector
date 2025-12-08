-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127497 = Proto("nmea-2000-127497", "Trip Parameters, Engine (127497)")
local instance = ProtoField.uint8("nmea-2000-127497.instance", "Instance", base.DEC, NULL, 0xff)
local tripFuelUsed = ProtoField.uint16("nmea-2000-127497.tripFuelUsed", "Trip Fuel Used (L)")
local fuelRateAverage = ProtoField.float("nmea-2000-127497.fuelRateAverage", "Fuel Rate, Average (L/h)")
local fuelRateEconomy = ProtoField.float("nmea-2000-127497.fuelRateEconomy", "Fuel Rate, Economy (L/h)")
local instantaneousFuelEconomy = ProtoField.float("nmea-2000-127497.instantaneousFuelEconomy", "Instantaneous Fuel Economy (L/h)")

NMEA_2000_127497.fields = {instance,tripFuelUsed,fuelRateAverage,fuelRateEconomy,instantaneousFuelEconomy}

function NMEA_2000_127497.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127497 (Trip Parameters, Engine)"
    local subtree = tree:add(NMEA_2000_127497, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(instance, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 2) then
        subtree:add_le(tripFuelUsed, buffer(str_offset + 1, 2))
    end
    if buffer:len() >= (str_offset + 3 + 2) then
        subtree:add(fuelRateAverage, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_int() * 0.1)
    end
    if buffer:len() >= (str_offset + 5 + 2) then
        subtree:add(fuelRateEconomy, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_int() * 0.1)
    end
    if buffer:len() >= (str_offset + 7 + 2) then
        subtree:add(instantaneousFuelEconomy, buffer(str_offset + 7, 2), buffer(str_offset + 7, 2):le_int() * 0.1)
    end
end

return NMEA_2000_127497
