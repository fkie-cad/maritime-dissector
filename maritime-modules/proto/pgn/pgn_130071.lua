-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130071 = Proto("nmea-2000-130071", "Route and WP Service - Route Comment (130071)")
local startRouteId = ProtoField.uint16("nmea-2000-130071.startRouteId", "Start Route ID")
local nitems = ProtoField.uint16("nmea-2000-130071.nitems", "nItems")
local numberOfRoutesWithComments = ProtoField.uint16("nmea-2000-130071.numberOfRoutesWithComments", "Number of Routes with Comments")
local databaseId = ProtoField.uint16("nmea-2000-130071.databaseId", "Database ID")
local routeId = ProtoField.uint16("nmea-2000-130071.routeId", "Route ID")
local comment = ProtoField.string("nmea-2000-130071.comment", "Comment")

NMEA_2000_130071.fields = {startRouteId,nitems,numberOfRoutesWithComments,databaseId,routeId,comment}

function NMEA_2000_130071.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130071 (Route and WP Service - Route Comment)"
    local subtree = tree:add(NMEA_2000_130071, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 2) then
        subtree:add_le(startRouteId, buffer(str_offset, 2))
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add_le(nitems, buffer(str_offset + 2, 2))
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add_le(numberOfRoutesWithComments, buffer(str_offset + 4, 2))
    end
    if buffer:len() >= (str_offset + 6 + 2) then
        subtree:add_le(databaseId, buffer(str_offset + 6, 2))
    end
    local count_1 = buffer(2, 2):le_uint()
    if count_1 > 100 then count_1 = 0 end  -- sentinel check
    local cursor_1 = str_offset
    for _i_1 = 1, count_1 do
        if cursor_1 >= buffer:len() then break end
        if buffer:len() >= (cursor_1 + 2) then
            subtree:add_le(routeId, buffer(cursor_1, 2))
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

return NMEA_2000_130071
