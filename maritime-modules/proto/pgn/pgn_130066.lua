-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130066 = Proto("nmea-2000-130066", "Route and WP Service - Route/WP-List Attributes (130066)")
local databaseId = ProtoField.float("nmea-2000-130066.databaseId", "Database ID")
local routeId = ProtoField.float("nmea-2000-130066.routeId", "Route ID")
local routeWpListName = ProtoField.string("nmea-2000-130066.routeWpListName", "Route/WP-List Name")

NMEA_2000_130066.fields = {databaseId,routeId,routeWpListName}

function NMEA_2000_130066.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130066 (Route and WP Service - Route/WP-List Attributes)"
    local subtree = tree:add(NMEA_2000_130066, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(databaseId, buffer(str_offset + 0, 2), buffer(str_offset + 0, 2):le_uint() * 1)
    subtree:add(routeId, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 1)
    length = buffer(str_offset + 4, 1):uint() - 2
    -- type = buffer(str_offset + 4 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(routeWpListName, buffer(str_offset + 4 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_130066
