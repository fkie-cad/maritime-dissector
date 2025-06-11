-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130071 = Proto("nmea-2000-130071", "Route and WP Service - Route Comment (130071)")
local startRouteId = ProtoField.float("nmea-2000-130071.startRouteId", "Start Route ID")
local nitems = ProtoField.float("nmea-2000-130071.nitems", "nItems")
local numberOfRoutesWithComments = ProtoField.float("nmea-2000-130071.numberOfRoutesWithComments", "Number of Routes with Comments")
local databaseId = ProtoField.float("nmea-2000-130071.databaseId", "Database ID")
local routeId = ProtoField.float("nmea-2000-130071.routeId", "Route ID")
local comment = ProtoField.string("nmea-2000-130071.comment", "Comment")

NMEA_2000_130071.fields = {startRouteId,nitems,numberOfRoutesWithComments,databaseId,routeId,comment}

function NMEA_2000_130071.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130071 (Route and WP Service - Route Comment)"
    local subtree = tree:add(NMEA_2000_130071, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(startRouteId, buffer(str_offset + 0, 2), buffer(str_offset + 0, 2):le_uint() * 1)
    subtree:add(nitems, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 1)
    subtree:add(numberOfRoutesWithComments, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 1)
    subtree:add(databaseId, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 1)
    subtree:add(routeId, buffer(str_offset + 8, 2), buffer(str_offset + 8, 2):le_uint() * 1)
    length = buffer(str_offset + 10, 1):uint() - 2
    -- type = buffer(str_offset + 10 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(comment, buffer(str_offset + 10 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_130071
