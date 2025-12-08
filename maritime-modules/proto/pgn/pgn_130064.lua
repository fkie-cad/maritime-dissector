-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130064 = Proto("nmea-2000-130064", "Route and WP Service - Database List (130064)")
local startDatabaseId = ProtoField.uint16("nmea-2000-130064.startDatabaseId", "Start Database ID")
local nitems = ProtoField.uint16("nmea-2000-130064.nitems", "nItems")
local numberOfDatabasesAvailable = ProtoField.uint16("nmea-2000-130064.numberOfDatabasesAvailable", "Number of Databases Available")
local databaseId = ProtoField.uint16("nmea-2000-130064.databaseId", "Database ID")
local databaseName = ProtoField.string("nmea-2000-130064.databaseName", "Database Name")
local databaseTimestamp = ProtoField.float("nmea-2000-130064.databaseTimestamp", "Database Timestamp (s)")
local databaseDatestamp = ProtoField.uint16("nmea-2000-130064.databaseDatestamp", "Database Datestamp (d)")
local wpPositionResolution = ProtoField.uint32("nmea-2000-130064.wpPositionResolution", "WP Position Resolution", base.DEC)
local numberOfRoutesInDatabase = ProtoField.uint16("nmea-2000-130064.numberOfRoutesInDatabase", "Number of Routes in Database")
local numberOfWpsInDatabase = ProtoField.uint32("nmea-2000-130064.numberOfWpsInDatabase", "Number of WPs in Database")
local numberOfBytesInDatabase = ProtoField.uint32("nmea-2000-130064.numberOfBytesInDatabase", "Number of Bytes in Database")

NMEA_2000_130064.fields = {startDatabaseId,nitems,numberOfDatabasesAvailable,databaseId,databaseName,databaseTimestamp,databaseDatestamp,wpPositionResolution,numberOfRoutesInDatabase,numberOfWpsInDatabase,numberOfBytesInDatabase}

function NMEA_2000_130064.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130064 (Route and WP Service - Database List)"
    local subtree = tree:add(NMEA_2000_130064, buffer(), subtree_title)
    local str_offset = 0
    local bitfield_offset = 0

    if buffer:len() >= (str_offset + 2) then
        subtree:add_le(startDatabaseId, buffer(str_offset, 2))
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add_le(nitems, buffer(str_offset + 2, 2))
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add_le(numberOfDatabasesAvailable, buffer(str_offset + 4, 2))
    end
    local count_1 = buffer(2, 2):le_uint()
    if count_1 > 100 then count_1 = 0 end  -- sentinel check
    local cursor_1 = str_offset
    for _i_1 = 1, count_1 do
        if cursor_1 >= buffer:len() then break end
        if buffer:len() >= (cursor_1 + 2) then
            subtree:add_le(databaseId, buffer(cursor_1, 2))
            cursor_1 = cursor_1 + 2
        end
        if buffer:len() > cursor_1 then
            local _databaseName_len = buffer(cursor_1, 1):uint()
            if _databaseName_len >= 2 and buffer:len() >= (cursor_1 + _databaseName_len) then
                subtree:add(databaseName, buffer(cursor_1 + 2, _databaseName_len - 2))
                cursor_1 = cursor_1 + _databaseName_len
            elseif _databaseName_len == 0 or _databaseName_len == 1 then
                cursor_1 = cursor_1 + math.max(1, _databaseName_len)  -- empty string
            else
                cursor_1 = cursor_1 + 1  -- malformed, skip length byte
            end
        end
        if buffer:len() >= (cursor_1 + 4) then
            local _val = buffer(cursor_1, 4):le_uint()
            subtree:add(databaseTimestamp, buffer(cursor_1, 4), _val * 0.0001)
            cursor_1 = cursor_1 + 4
        end
        if buffer:len() >= (cursor_1 + 2) then
            subtree:add_le(databaseDatestamp, buffer(cursor_1, 2))
            cursor_1 = cursor_1 + 2
        end
        if buffer:len() >= (cursor_1 + 1) then
            subtree:add(wpPositionResolution, buffer(cursor_1, 1))
            cursor_1 = cursor_1 + 1
        end
        cursor_1 = cursor_1 + 1  -- skip RESERVED
        if buffer:len() >= (cursor_1 + 2) then
            subtree:add_le(numberOfRoutesInDatabase, buffer(cursor_1, 2))
            cursor_1 = cursor_1 + 2
        end
        if buffer:len() >= (cursor_1 + 4) then
            subtree:add_le(numberOfWpsInDatabase, buffer(cursor_1, 4))
            cursor_1 = cursor_1 + 4
        end
        if buffer:len() >= (cursor_1 + 4) then
            subtree:add_le(numberOfBytesInDatabase, buffer(cursor_1, 4))
            cursor_1 = cursor_1 + 4
        end
    end
end

return NMEA_2000_130064
