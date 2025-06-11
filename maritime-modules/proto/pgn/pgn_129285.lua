-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129285 = Proto("nmea-2000-129285", "Navigation - Route/WP Information (129285)")
local startRps = ProtoField.float("nmea-2000-129285.startRps", "Start RPS#")
local nitems = ProtoField.float("nmea-2000-129285.nitems", "nItems")
local databaseId = ProtoField.float("nmea-2000-129285.databaseId", "Database ID")
local routeId = ProtoField.float("nmea-2000-129285.routeId", "Route ID")
local navigationDirectionInRoute = ProtoField.uint8("nmea-2000-129285.navigationDirectionInRoute", "Navigation direction in route", base.DEC, NULL, 0x7)
local supplementaryRouteWpDataAvailable = ProtoField.uint8("nmea-2000-129285.supplementaryRouteWpDataAvailable", "Supplementary Route/WP data available", base.DEC, NULL, 0x18)
local routeName = ProtoField.string("nmea-2000-129285.routeName", "Route Name")
local wpName = ProtoField.string("nmea-2000-129285.wpName", "WP Name")

NMEA_2000_129285.fields = {startRps,nitems,databaseId,routeId,navigationDirectionInRoute,supplementaryRouteWpDataAvailable,routeName,wpName}

function NMEA_2000_129285.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129285 (Navigation - Route/WP Information)"
    local subtree = tree:add(NMEA_2000_129285, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(startRps, buffer(str_offset + 0, 2), buffer(str_offset + 0, 2):le_uint() * 1)
    subtree:add(nitems, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 1)
    subtree:add(databaseId, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 1)
    subtree:add(routeId, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 1)
    subtree:add(navigationDirectionInRoute, buffer(str_offset + 8, 1))
    subtree:add(supplementaryRouteWpDataAvailable, buffer(str_offset + 8, 1))
    length = buffer(str_offset + 9, 1):uint() - 2
    -- type = buffer(str_offset + 9 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(routeName, buffer(str_offset + 9 + 2, length))
    str_offset = str_offset + length + 2
    length = buffer(str_offset + 0, 1):uint() - 2
    -- type = buffer(str_offset + 0 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(wpName, buffer(str_offset + 0 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_129285
