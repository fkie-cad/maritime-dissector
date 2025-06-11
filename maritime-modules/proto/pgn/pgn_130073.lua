-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130073 = Proto("nmea-2000-130073", "Route and WP Service - Radius of Turn (130073)")
local startRps = ProtoField.float("nmea-2000-130073.startRps", "Start RPS#")
local nitems = ProtoField.float("nmea-2000-130073.nitems", "nItems")
local numberOfWpsWithASpecificRadiusOfTurn = ProtoField.float("nmea-2000-130073.numberOfWpsWithASpecificRadiusOfTurn", "Number of WPs with a specific Radius of Turn")
local databaseId = ProtoField.float("nmea-2000-130073.databaseId", "Database ID")
local routeId = ProtoField.float("nmea-2000-130073.routeId", "Route ID")
local rps = ProtoField.float("nmea-2000-130073.rps", "RPS#")
local radiusOfTurn = ProtoField.float("nmea-2000-130073.radiusOfTurn", "Radius of Turn (m)")

NMEA_2000_130073.fields = {startRps,nitems,numberOfWpsWithASpecificRadiusOfTurn,databaseId,routeId,rps,radiusOfTurn}

function NMEA_2000_130073.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130073 (Route and WP Service - Radius of Turn)"
    local subtree = tree:add(NMEA_2000_130073, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(startRps, buffer(str_offset + 0, 2), buffer(str_offset + 0, 2):le_uint() * 1)
    subtree:add(nitems, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 1)
    subtree:add(numberOfWpsWithASpecificRadiusOfTurn, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 1)
    subtree:add(databaseId, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 1)
    subtree:add(routeId, buffer(str_offset + 8, 2), buffer(str_offset + 8, 2):le_uint() * 1)
    subtree:add(rps, buffer(str_offset + 10, 2), buffer(str_offset + 10, 2):le_uint() * 1)
    subtree:add(radiusOfTurn, buffer(str_offset + 12, 2), buffer(str_offset + 12, 2):le_int() * 1)
end

return NMEA_2000_130073
