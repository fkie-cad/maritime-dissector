-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130074 = Proto("nmea-2000-130074", "Route and WP Service - WP List - WP Name & Position (130074)")
local startWpId = ProtoField.float("nmea-2000-130074.startWpId", "Start WP ID")
local nitems = ProtoField.float("nmea-2000-130074.nitems", "nItems")
local numberOfValidWpsInTheWpList = ProtoField.float("nmea-2000-130074.numberOfValidWpsInTheWpList", "Number of valid WPs in the WP-List")
local databaseId = ProtoField.float("nmea-2000-130074.databaseId", "Database ID")
local wpId = ProtoField.float("nmea-2000-130074.wpId", "WP ID")
local wpName = ProtoField.string("nmea-2000-130074.wpName", "WP Name")

NMEA_2000_130074.fields = {startWpId,nitems,numberOfValidWpsInTheWpList,databaseId,wpId,wpName}

function NMEA_2000_130074.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130074 (Route and WP Service - WP List - WP Name & Position)"
    local subtree = tree:add(NMEA_2000_130074, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(startWpId, buffer(str_offset + 0, 2), buffer(str_offset + 0, 2):le_uint() * 1)
    subtree:add(nitems, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 1)
    subtree:add(numberOfValidWpsInTheWpList, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 1)
    subtree:add(databaseId, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 1)
    subtree:add(wpId, buffer(str_offset + 10, 2), buffer(str_offset + 10, 2):le_uint() * 1)
    length = buffer(str_offset + 12, 1):uint() - 2
    -- type = buffer(str_offset + 12 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(wpName, buffer(str_offset + 12 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_130074
