-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129285 = Proto("nmea-2000-129285", "Navigation - Route/WP Information (129285)")
local startRps = ProtoField.uint16("nmea-2000-129285.startRps", "Start RPS#")
local nitems = ProtoField.uint16("nmea-2000-129285.nitems", "nItems")
local databaseId = ProtoField.uint16("nmea-2000-129285.databaseId", "Database ID")
local routeId = ProtoField.uint16("nmea-2000-129285.routeId", "Route ID")
local navigationDirectionInRoute = ProtoField.uint8("nmea-2000-129285.navigationDirectionInRoute", "Navigation direction in route", base.DEC, NULL, 0x7)
local supplementaryRouteWpDataAvailable = ProtoField.uint8("nmea-2000-129285.supplementaryRouteWpDataAvailable", "Supplementary Route/WP data available", base.DEC, NULL, 0x18)
local routeName = ProtoField.string("nmea-2000-129285.routeName", "Route Name")
local wpId = ProtoField.uint16("nmea-2000-129285.wpId", "WP ID")
local wpName = ProtoField.string("nmea-2000-129285.wpName", "WP Name")
local wpLatitude = ProtoField.float("nmea-2000-129285.wpLatitude", "WP Latitude (deg)")
local wpLongitude = ProtoField.float("nmea-2000-129285.wpLongitude", "WP Longitude (deg)")

NMEA_2000_129285.fields = {startRps,nitems,databaseId,routeId,navigationDirectionInRoute,supplementaryRouteWpDataAvailable,routeName,wpId,wpName,wpLatitude,wpLongitude}

function NMEA_2000_129285.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129285 (Navigation - Route/WP Information)"
    local subtree = tree:add(NMEA_2000_129285, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 2) then
        subtree:add_le(startRps, buffer(str_offset, 2))
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add_le(nitems, buffer(str_offset + 2, 2))
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add_le(databaseId, buffer(str_offset + 4, 2))
    end
    if buffer:len() >= (str_offset + 6 + 2) then
        subtree:add_le(routeId, buffer(str_offset + 6, 2))
    end
    if buffer:len() >= (str_offset + 8 + 1) then
        subtree:add(navigationDirectionInRoute, buffer(str_offset + 8, 1))
    end
    if buffer:len() >= (str_offset + 8 + 1) then
        subtree:add(supplementaryRouteWpDataAvailable, buffer(str_offset + 8, 1))
    end
    if buffer:len() >= (str_offset + 9 + 1) then
        length = buffer(str_offset + 9, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 9 + 2 + length) then
            -- type = buffer(str_offset + 9 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(routeName, buffer(str_offset + 9 + 2, length))
            str_offset = str_offset + 9 + length + 2
        end
    end
    str_offset = str_offset + 1  -- skip RESERVED
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

return NMEA_2000_129285
