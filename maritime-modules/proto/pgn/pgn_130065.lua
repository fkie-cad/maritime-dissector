-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130065 = Proto("nmea-2000-130065", "Route and WP Service - Route List (130065)")
local startRouteId = ProtoField.uint16("nmea-2000-130065.startRouteId", "Start Route ID")
local nitems = ProtoField.uint16("nmea-2000-130065.nitems", "nItems")
local numberOfRoutesInDatabase = ProtoField.uint16("nmea-2000-130065.numberOfRoutesInDatabase", "Number of Routes in Database")
local databaseId = ProtoField.uint16("nmea-2000-130065.databaseId", "Database ID")
local routeId = ProtoField.uint16("nmea-2000-130065.routeId", "Route ID")
local routeName = ProtoField.string("nmea-2000-130065.routeName", "Route Name")
local wpIdentificationMethod = ProtoField.uint32("nmea-2000-130065.wpIdentificationMethod", "WP Identification Method", base.DEC)
local routeStatus = ProtoField.uint32("nmea-2000-130065.routeStatus", "Route Status", base.DEC)

NMEA_2000_130065.fields = {startRouteId,nitems,numberOfRoutesInDatabase,databaseId,routeId,routeName,wpIdentificationMethod,routeStatus}

function NMEA_2000_130065.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130065 (Route and WP Service - Route List)"
    local subtree = tree:add(NMEA_2000_130065, buffer(), subtree_title)
    local str_offset = 0
    local bitfield_offset = 0

    if buffer:len() >= (str_offset + 2) then
        subtree:add_le(startRouteId, buffer(str_offset, 2))
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add_le(nitems, buffer(str_offset + 2, 2))
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add_le(numberOfRoutesInDatabase, buffer(str_offset + 4, 2))
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
            local _routeName_len = buffer(cursor_1, 1):uint()
            if _routeName_len >= 2 and buffer:len() >= (cursor_1 + _routeName_len) then
                subtree:add(routeName, buffer(cursor_1 + 2, _routeName_len - 2))
                cursor_1 = cursor_1 + _routeName_len
            elseif _routeName_len == 0 or _routeName_len == 1 then
                cursor_1 = cursor_1 + math.max(1, _routeName_len)  -- empty string
            else
                cursor_1 = cursor_1 + 1  -- malformed, skip length byte
            end
        end
        cursor_1 = cursor_1 + 1  -- skip RESERVED
        if buffer:len() >= (cursor_1 + 1) then
            subtree:add(wpIdentificationMethod, buffer(cursor_1, 1))
            cursor_1 = cursor_1 + 1
        end
        if buffer:len() >= (cursor_1 + 1) then
            subtree:add(routeStatus, buffer(cursor_1, 1))
            cursor_1 = cursor_1 + 1
        end
    end
end

return NMEA_2000_130065
