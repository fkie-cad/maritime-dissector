-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127496 = Proto("nmea-2000-127496", "Trip Parameters, Vessel (127496)")
local timeToEmpty = ProtoField.float("nmea-2000-127496.timeToEmpty", "Time to Empty (s)")
local distanceToEmpty = ProtoField.float("nmea-2000-127496.distanceToEmpty", "Distance to Empty (m)")
local estimatedFuelRemaining = ProtoField.uint16("nmea-2000-127496.estimatedFuelRemaining", "Estimated Fuel Remaining (L)")
local tripRunTime = ProtoField.float("nmea-2000-127496.tripRunTime", "Trip Run Time (s)")

NMEA_2000_127496.fields = {timeToEmpty,distanceToEmpty,estimatedFuelRemaining,tripRunTime}

function NMEA_2000_127496.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127496 (Trip Parameters, Vessel)"
    local subtree = tree:add(NMEA_2000_127496, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 4) then
        subtree:add(timeToEmpty, buffer(str_offset, 4), buffer(str_offset, 4):le_uint() * 0.001)
    end
    if buffer:len() >= (str_offset + 4 + 4) then
        subtree:add(distanceToEmpty, buffer(str_offset + 4, 4), buffer(str_offset + 4, 4):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 8 + 2) then
        subtree:add_le(estimatedFuelRemaining, buffer(str_offset + 8, 2))
    end
    if buffer:len() >= (str_offset + 10 + 4) then
        subtree:add(tripRunTime, buffer(str_offset + 10, 4), buffer(str_offset + 10, 4):le_uint() * 0.001)
    end
end

return NMEA_2000_127496
