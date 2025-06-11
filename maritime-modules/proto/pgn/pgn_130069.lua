-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130069 = Proto("nmea-2000-130069", "Route and WP Service - XTE Limit & Navigation Method (130069)")
local startRps = ProtoField.float("nmea-2000-130069.startRps", "Start RPS#")
local nitems = ProtoField.float("nmea-2000-130069.nitems", "nItems")
local numberOfWpsWithASpecificXteLimitOrNavMethod = ProtoField.float("nmea-2000-130069.numberOfWpsWithASpecificXteLimitOrNavMethod", "Number of WPs with a specific XTE Limit or Nav. Method")
local databaseId = ProtoField.float("nmea-2000-130069.databaseId", "Database ID")
local routeId = ProtoField.float("nmea-2000-130069.routeId", "Route ID")
local rps = ProtoField.float("nmea-2000-130069.rps", "RPS#")
local xteLimitInTheLegAfterWp = ProtoField.float("nmea-2000-130069.xteLimitInTheLegAfterWp", "XTE Limit in the leg after WP (m)")
local navMethodInTheLegAfterWp = ProtoField.uint8("nmea-2000-130069.navMethodInTheLegAfterWp", "Nav. Method in the leg after WP", base.DEC, NULL, 0x3)

NMEA_2000_130069.fields = {startRps,nitems,numberOfWpsWithASpecificXteLimitOrNavMethod,databaseId,routeId,rps,xteLimitInTheLegAfterWp,navMethodInTheLegAfterWp}

function NMEA_2000_130069.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130069 (Route and WP Service - XTE Limit & Navigation Method)"
    local subtree = tree:add(NMEA_2000_130069, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(startRps, buffer(str_offset + 0, 2), buffer(str_offset + 0, 2):le_uint() * 1)
    subtree:add(nitems, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 1)
    subtree:add(numberOfWpsWithASpecificXteLimitOrNavMethod, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 1)
    subtree:add(databaseId, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 1)
    subtree:add(routeId, buffer(str_offset + 8, 2), buffer(str_offset + 8, 2):le_uint() * 1)
    subtree:add(rps, buffer(str_offset + 10, 2), buffer(str_offset + 10, 2):le_uint() * 1)
    subtree:add(xteLimitInTheLegAfterWp, buffer(str_offset + 12, 2), buffer(str_offset + 12, 2):le_int() * 1)
    subtree:add(navMethodInTheLegAfterWp, buffer(str_offset + 14, 1))
end

return NMEA_2000_130069
