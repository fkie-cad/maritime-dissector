-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130067 = Proto("nmea-2000-130067", "Route and WP Service - Route - WP Name & Position (130067)")
local startRps = ProtoField.float("nmea-2000-130067.startRps", "Start RPS#")
local nitems = ProtoField.float("nmea-2000-130067.nitems", "nItems")
local numberOfWpsInTheRouteWpList = ProtoField.float("nmea-2000-130067.numberOfWpsInTheRouteWpList", "Number of WPs in the Route/WP-List")
local databaseId = ProtoField.float("nmea-2000-130067.databaseId", "Database ID")
local routeId = ProtoField.float("nmea-2000-130067.routeId", "Route ID")
local wpId = ProtoField.float("nmea-2000-130067.wpId", "WP ID")
local wpName = ProtoField.string("nmea-2000-130067.wpName", "WP Name")

NMEA_2000_130067.fields = {startRps,nitems,numberOfWpsInTheRouteWpList,databaseId,routeId,wpId,wpName}

function NMEA_2000_130067.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130067 (Route and WP Service - Route - WP Name & Position)"
    local subtree = tree:add(NMEA_2000_130067, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(startRps, buffer(str_offset + 0, 2), buffer(str_offset + 0, 2):le_uint() * 1)
    subtree:add(nitems, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 1)
    subtree:add(numberOfWpsInTheRouteWpList, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 1)
    subtree:add(databaseId, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 1)
    subtree:add(routeId, buffer(str_offset + 8, 2), buffer(str_offset + 8, 2):le_uint() * 1)
    subtree:add(wpId, buffer(str_offset + 10, 2), buffer(str_offset + 10, 2):le_uint() * 1)
    length = buffer(str_offset + 12, 1):uint() - 2
    -- type = buffer(str_offset + 12 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(wpName, buffer(str_offset + 12 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_130067
