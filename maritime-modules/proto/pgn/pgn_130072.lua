-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130072 = Proto("nmea-2000-130072", "Route and WP Service - Database Comment (130072)")
local startDatabaseId = ProtoField.float("nmea-2000-130072.startDatabaseId", "Start Database ID")
local nitems = ProtoField.float("nmea-2000-130072.nitems", "nItems")
local numberOfDatabasesWithComments = ProtoField.float("nmea-2000-130072.numberOfDatabasesWithComments", "Number of Databases with Comments")
local databaseId = ProtoField.float("nmea-2000-130072.databaseId", "Database ID")
local comment = ProtoField.string("nmea-2000-130072.comment", "Comment")

NMEA_2000_130072.fields = {startDatabaseId,nitems,numberOfDatabasesWithComments,databaseId,comment}

function NMEA_2000_130072.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130072 (Route and WP Service - Database Comment)"
    local subtree = tree:add(NMEA_2000_130072, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(startDatabaseId, buffer(str_offset + 0, 2), buffer(str_offset + 0, 2):le_uint() * 1)
    subtree:add(nitems, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 1)
    subtree:add(numberOfDatabasesWithComments, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 1)
    subtree:add(databaseId, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 1)
    length = buffer(str_offset + 8, 1):uint() - 2
    -- type = buffer(str_offset + 8 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(comment, buffer(str_offset + 8 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_130072
