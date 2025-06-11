-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130064 = Proto("nmea-2000-130064", "Route and WP Service - Database List (130064)")
local startDatabaseId = ProtoField.float("nmea-2000-130064.startDatabaseId", "Start Database ID")
local nitems = ProtoField.float("nmea-2000-130064.nitems", "nItems")
local numberOfDatabasesAvailable = ProtoField.float("nmea-2000-130064.numberOfDatabasesAvailable", "Number of Databases Available")
local databaseId = ProtoField.float("nmea-2000-130064.databaseId", "Database ID")
local databaseName = ProtoField.string("nmea-2000-130064.databaseName", "Database Name")

NMEA_2000_130064.fields = {startDatabaseId,nitems,numberOfDatabasesAvailable,databaseId,databaseName}

function NMEA_2000_130064.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130064 (Route and WP Service - Database List)"
    local subtree = tree:add(NMEA_2000_130064, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(startDatabaseId, buffer(str_offset + 0, 2), buffer(str_offset + 0, 2):le_uint() * 1)
    subtree:add(nitems, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 1)
    subtree:add(numberOfDatabasesAvailable, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 1)
    subtree:add(databaseId, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 1)
    length = buffer(str_offset + 8, 1):uint() - 2
    -- type = buffer(str_offset + 8 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(databaseName, buffer(str_offset + 8 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_130064
