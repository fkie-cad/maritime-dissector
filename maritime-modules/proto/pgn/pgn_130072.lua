-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130072 = Proto("nmea-2000-130072", "Route and WP Service - Database Comment (130072)")
local startDatabaseId = ProtoField.uint16("nmea-2000-130072.startDatabaseId", "Start Database ID")
local nitems = ProtoField.uint16("nmea-2000-130072.nitems", "nItems")
local numberOfDatabasesWithComments = ProtoField.uint16("nmea-2000-130072.numberOfDatabasesWithComments", "Number of Databases with Comments")
local databaseId = ProtoField.uint16("nmea-2000-130072.databaseId", "Database ID")
local comment = ProtoField.string("nmea-2000-130072.comment", "Comment")

NMEA_2000_130072.fields = {startDatabaseId,nitems,numberOfDatabasesWithComments,databaseId,comment}

function NMEA_2000_130072.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130072 (Route and WP Service - Database Comment)"
    local subtree = tree:add(NMEA_2000_130072, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 2) then
        subtree:add_le(startDatabaseId, buffer(str_offset, 2))
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add_le(nitems, buffer(str_offset + 2, 2))
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add_le(numberOfDatabasesWithComments, buffer(str_offset + 4, 2))
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
            local _comment_len = buffer(cursor_1, 1):uint()
            if _comment_len >= 2 and buffer:len() >= (cursor_1 + _comment_len) then
                subtree:add(comment, buffer(cursor_1 + 2, _comment_len - 2))
                cursor_1 = cursor_1 + _comment_len
            elseif _comment_len == 0 or _comment_len == 1 then
                cursor_1 = cursor_1 + math.max(1, _comment_len)  -- empty string
            else
                cursor_1 = cursor_1 + 1  -- malformed, skip length byte
            end
        end
    end
end

return NMEA_2000_130072
