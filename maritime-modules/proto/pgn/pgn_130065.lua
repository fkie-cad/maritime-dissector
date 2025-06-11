-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130065 = Proto("nmea-2000-130065", "Route and WP Service - Route List (130065)")
local startRouteId = ProtoField.float("nmea-2000-130065.startRouteId", "Start Route ID")
local nitems = ProtoField.float("nmea-2000-130065.nitems", "nItems")
local numberOfRoutesInDatabase = ProtoField.float("nmea-2000-130065.numberOfRoutesInDatabase", "Number of Routes in Database")
local databaseId = ProtoField.float("nmea-2000-130065.databaseId", "Database ID")
local routeId = ProtoField.float("nmea-2000-130065.routeId", "Route ID")
local routeName = ProtoField.string("nmea-2000-130065.routeName", "Route Name")

NMEA_2000_130065.fields = {startRouteId,nitems,numberOfRoutesInDatabase,databaseId,routeId,routeName}

function NMEA_2000_130065.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130065 (Route and WP Service - Route List)"
    local subtree = tree:add(NMEA_2000_130065, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(startRouteId, buffer(str_offset + 0, 2), buffer(str_offset + 0, 2):le_uint() * 1)
    subtree:add(nitems, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 1)
    subtree:add(numberOfRoutesInDatabase, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 1)
    subtree:add(databaseId, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 1)
    subtree:add(routeId, buffer(str_offset + 8, 2), buffer(str_offset + 8, 2):le_uint() * 1)
    length = buffer(str_offset + 10, 1):uint() - 2
    -- type = buffer(str_offset + 10 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(routeName, buffer(str_offset + 10 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_130065
