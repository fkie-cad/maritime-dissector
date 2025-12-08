-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130067 = Proto("nmea-2000-130067", "Route and WP Service - Route - WP Name & Position (130067)")
local startRps = ProtoField.uint16("nmea-2000-130067.startRps", "Start RPS#")
local nitems = ProtoField.uint16("nmea-2000-130067.nitems", "nItems")
local numberOfWpsInTheRouteWpList = ProtoField.uint16("nmea-2000-130067.numberOfWpsInTheRouteWpList", "Number of WPs in the Route/WP-List")
local databaseId = ProtoField.uint16("nmea-2000-130067.databaseId", "Database ID")
local routeId = ProtoField.uint16("nmea-2000-130067.routeId", "Route ID")
local wpId = ProtoField.uint16("nmea-2000-130067.wpId", "WP ID")
local wpName = ProtoField.string("nmea-2000-130067.wpName", "WP Name")
local wpLatitude = ProtoField.float("nmea-2000-130067.wpLatitude", "WP Latitude (deg)")
local wpLongitude = ProtoField.float("nmea-2000-130067.wpLongitude", "WP Longitude (deg)")

NMEA_2000_130067.fields = {startRps,nitems,numberOfWpsInTheRouteWpList,databaseId,routeId,wpId,wpName,wpLatitude,wpLongitude}

function NMEA_2000_130067.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130067 (Route and WP Service - Route - WP Name & Position)"
    local subtree = tree:add(NMEA_2000_130067, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 2) then
        subtree:add_le(startRps, buffer(str_offset, 2))
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add_le(nitems, buffer(str_offset + 2, 2))
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add_le(numberOfWpsInTheRouteWpList, buffer(str_offset + 4, 2))
    end
    if buffer:len() >= (str_offset + 6 + 2) then
        subtree:add_le(databaseId, buffer(str_offset + 6, 2))
    end
    if buffer:len() >= (str_offset + 8 + 2) then
        subtree:add_le(routeId, buffer(str_offset + 8, 2))
    end
    local count_1 = buffer(2, 2):le_uint()
    if count_1 > 100 then count_1 = 0 end  -- sentinel check
    local cursor_1 = str_offset
    for _i_1 = 1, count_1 do
        if cursor_1 >= buffer:len() then break end
        if buffer:len() >= (cursor_1 + 2) then
            subtree:add_le(wpId, buffer(cursor_1, 2))
            cursor_1 = cursor_1 + 2
        end
        if buffer:len() > cursor_1 then
            local _wpName_len = buffer(cursor_1, 1):uint()
            if _wpName_len >= 2 and buffer:len() >= (cursor_1 + _wpName_len) then
                subtree:add(wpName, buffer(cursor_1 + 2, _wpName_len - 2))
                cursor_1 = cursor_1 + _wpName_len
            elseif _wpName_len == 0 or _wpName_len == 1 then
                cursor_1 = cursor_1 + math.max(1, _wpName_len)  -- empty string
            else
                cursor_1 = cursor_1 + 1  -- malformed, skip length byte
            end
        end
        if buffer:len() >= (cursor_1 + 4) then
            local _val = buffer(cursor_1, 4):le_int()
            subtree:add(wpLatitude, buffer(cursor_1, 4), _val * 1e-07)
            cursor_1 = cursor_1 + 4
        end
        if buffer:len() >= (cursor_1 + 4) then
            local _val = buffer(cursor_1, 4):le_int()
            subtree:add(wpLongitude, buffer(cursor_1, 4), _val * 1e-07)
            cursor_1 = cursor_1 + 4
        end
    end
end

return NMEA_2000_130067
