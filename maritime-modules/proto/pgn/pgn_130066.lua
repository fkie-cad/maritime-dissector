-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130066 = Proto("nmea-2000-130066", "Route and WP Service - Route/WP-List Attributes (130066)")
local databaseId = ProtoField.uint16("nmea-2000-130066.databaseId", "Database ID")
local routeId = ProtoField.uint16("nmea-2000-130066.routeId", "Route ID")
local routeWpListName = ProtoField.string("nmea-2000-130066.routeWpListName", "Route/WP-List Name")
local routeWpListTimestamp = ProtoField.float("nmea-2000-130066.routeWpListTimestamp", "Route/WP-List Timestamp (s)")
local routeWpListDatestamp = ProtoField.uint16("nmea-2000-130066.routeWpListDatestamp", "Route/WP-List Datestamp (d)")
local changeAtLastTimestamp = ProtoField.uint8("nmea-2000-130066.changeAtLastTimestamp", "Change at Last Timestamp", base.HEX)
local numberOfWpsInTheRouteWpList = ProtoField.uint16("nmea-2000-130066.numberOfWpsInTheRouteWpList", "Number of WPs in the Route/WP-List")
local criticalSupplementaryParameters = ProtoField.uint8("nmea-2000-130066.criticalSupplementaryParameters", "Critical supplementary parameters", base.HEX)
local navigationMethod = ProtoField.uint32("nmea-2000-130066.navigationMethod", "Navigation Method", base.DEC)
local wpIdentificationMethod = ProtoField.uint32("nmea-2000-130066.wpIdentificationMethod", "WP Identification Method", base.DEC)
local routeStatus = ProtoField.uint32("nmea-2000-130066.routeStatus", "Route Status", base.DEC)
local xteLimitForTheRoute = ProtoField.int16("nmea-2000-130066.xteLimitForTheRoute", "XTE Limit for the Route (m)")

NMEA_2000_130066.fields = {databaseId,routeId,routeWpListName,routeWpListTimestamp,routeWpListDatestamp,changeAtLastTimestamp,numberOfWpsInTheRouteWpList,criticalSupplementaryParameters,navigationMethod,wpIdentificationMethod,routeStatus,xteLimitForTheRoute}

function NMEA_2000_130066.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130066 (Route and WP Service - Route/WP-List Attributes)"
    local subtree = tree:add(NMEA_2000_130066, buffer(), subtree_title)
    local str_offset = 0
    local bitfield_offset = 0

    if buffer:len() >= (str_offset + 2) then
        subtree:add_le(databaseId, buffer(str_offset, 2))
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add_le(routeId, buffer(str_offset + 2, 2))
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        length = buffer(str_offset + 4, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 4 + 2 + length) then
            -- type = buffer(str_offset + 4 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(routeWpListName, buffer(str_offset + 4 + 2, length))
            str_offset = str_offset + 4 + length + 2
        end
    end
    if buffer:len() >= (str_offset + 4) then
        subtree:add(routeWpListTimestamp, buffer(str_offset, 4), buffer(str_offset, 4):le_uint() * 0.0001)
        str_offset = str_offset + 4
    end
    if buffer:len() >= (str_offset + 2) then
        subtree:add_le(routeWpListDatestamp, buffer(str_offset, 2))
        str_offset = str_offset + 2
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(changeAtLastTimestamp, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 2) then
        subtree:add_le(numberOfWpsInTheRouteWpList, buffer(str_offset, 2))
        str_offset = str_offset + 2
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(criticalSupplementaryParameters, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    do
        local _bit_len = 2
        local _bit_byte = math.floor(bitfield_offset / 8)
        local _bit_start = bitfield_offset % 8
        local _bytes = math.floor((_bit_start + _bit_len + 7) / 8)
        if buffer:len() >= (str_offset + _bit_byte + _bytes) then
            local _rng = buffer(str_offset + _bit_byte, _bytes)
            local _raw
            if _bytes <= 4 then
                _raw = _rng:le_uint()
            else
                _raw = _rng:le_uint64():tonumber()
            end
            local _val = math.floor(_raw / (2 ^ _bit_start)) % (2 ^ _bit_len)
            if false and _bit_len > 0 then
                local _sign_bit = 2 ^ (_bit_len - 1)
                if _val >= _sign_bit then
                    _val = _val - 2 ^ _bit_len
                end
            end
            subtree:add(navigationMethod, _rng, _val)
            bitfield_offset = bitfield_offset + _bit_len
            str_offset = str_offset + math.floor(bitfield_offset / 8)
            bitfield_offset = bitfield_offset % 8
        end
    end
    do
        local _bit_len = 2
        local _bit_byte = math.floor(bitfield_offset / 8)
        local _bit_start = bitfield_offset % 8
        local _bytes = math.floor((_bit_start + _bit_len + 7) / 8)
        if buffer:len() >= (str_offset + _bit_byte + _bytes) then
            local _rng = buffer(str_offset + _bit_byte, _bytes)
            local _raw
            if _bytes <= 4 then
                _raw = _rng:le_uint()
            else
                _raw = _rng:le_uint64():tonumber()
            end
            local _val = math.floor(_raw / (2 ^ _bit_start)) % (2 ^ _bit_len)
            if false and _bit_len > 0 then
                local _sign_bit = 2 ^ (_bit_len - 1)
                if _val >= _sign_bit then
                    _val = _val - 2 ^ _bit_len
                end
            end
            subtree:add(wpIdentificationMethod, _rng, _val)
            bitfield_offset = bitfield_offset + _bit_len
            str_offset = str_offset + math.floor(bitfield_offset / 8)
            bitfield_offset = bitfield_offset % 8
        end
    end
    do
        local _bit_len = 4
        local _bit_byte = math.floor(bitfield_offset / 8)
        local _bit_start = bitfield_offset % 8
        local _bytes = math.floor((_bit_start + _bit_len + 7) / 8)
        if buffer:len() >= (str_offset + _bit_byte + _bytes) then
            local _rng = buffer(str_offset + _bit_byte, _bytes)
            local _raw
            if _bytes <= 4 then
                _raw = _rng:le_uint()
            else
                _raw = _rng:le_uint64():tonumber()
            end
            local _val = math.floor(_raw / (2 ^ _bit_start)) % (2 ^ _bit_len)
            if false and _bit_len > 0 then
                local _sign_bit = 2 ^ (_bit_len - 1)
                if _val >= _sign_bit then
                    _val = _val - 2 ^ _bit_len
                end
            end
            subtree:add(routeStatus, _rng, _val)
            bitfield_offset = bitfield_offset + _bit_len
            str_offset = str_offset + math.floor(bitfield_offset / 8)
            bitfield_offset = bitfield_offset % 8
        end
    end
    if buffer:len() >= (str_offset + 2) then
        subtree:add_le(xteLimitForTheRoute, buffer(str_offset, 2))
        str_offset = str_offset + 2
    end
end

return NMEA_2000_130066
