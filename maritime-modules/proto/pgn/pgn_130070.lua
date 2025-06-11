-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130070 = Proto("nmea-2000-130070", "Route and WP Service - WP Comment (130070)")
local startId = ProtoField.float("nmea-2000-130070.startId", "Start ID")
local nitems = ProtoField.float("nmea-2000-130070.nitems", "nItems")
local numberOfWpsWithComments = ProtoField.float("nmea-2000-130070.numberOfWpsWithComments", "Number of WPs with Comments")
local databaseId = ProtoField.float("nmea-2000-130070.databaseId", "Database ID")
local routeId = ProtoField.float("nmea-2000-130070.routeId", "Route ID")
local wpIdRps = ProtoField.float("nmea-2000-130070.wpIdRps", "WP ID / RPS#")
local comment = ProtoField.string("nmea-2000-130070.comment", "Comment")

NMEA_2000_130070.fields = {startId,nitems,numberOfWpsWithComments,databaseId,routeId,wpIdRps,comment}

function NMEA_2000_130070.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130070 (Route and WP Service - WP Comment)"
    local subtree = tree:add(NMEA_2000_130070, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(startId, buffer(str_offset + 0, 2), buffer(str_offset + 0, 2):le_uint() * 1)
    subtree:add(nitems, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 1)
    subtree:add(numberOfWpsWithComments, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 1)
    subtree:add(databaseId, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 1)
    subtree:add(routeId, buffer(str_offset + 8, 2), buffer(str_offset + 8, 2):le_uint() * 1)
    subtree:add(wpIdRps, buffer(str_offset + 10, 2), buffer(str_offset + 10, 2):le_uint() * 1)
    length = buffer(str_offset + 12, 1):uint() - 2
    -- type = buffer(str_offset + 12 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(comment, buffer(str_offset + 12 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_130070
