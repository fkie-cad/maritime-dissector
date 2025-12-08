-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130069 = Proto("nmea-2000-130069", "Route and WP Service - XTE Limit & Navigation Method (130069)")
local startRps = ProtoField.uint16("nmea-2000-130069.startRps", "Start RPS#")
local nitems = ProtoField.uint16("nmea-2000-130069.nitems", "nItems")
local numberOfWpsWithASpecificXteLimitOrNavMethod = ProtoField.uint16("nmea-2000-130069.numberOfWpsWithASpecificXteLimitOrNavMethod", "Number of WPs with a specific XTE Limit or Nav. Method")
local databaseId = ProtoField.uint16("nmea-2000-130069.databaseId", "Database ID")
local routeId = ProtoField.uint16("nmea-2000-130069.routeId", "Route ID")
local rps = ProtoField.uint16("nmea-2000-130069.rps", "RPS#")
local xteLimitInTheLegAfterWp = ProtoField.int16("nmea-2000-130069.xteLimitInTheLegAfterWp", "XTE Limit in the leg after WP (m)")
local navMethodInTheLegAfterWp = ProtoField.uint8("nmea-2000-130069.navMethodInTheLegAfterWp", "Nav. Method in the leg after WP", base.DEC, NULL, 0x3)

NMEA_2000_130069.fields = {startRps,nitems,numberOfWpsWithASpecificXteLimitOrNavMethod,databaseId,routeId,rps,xteLimitInTheLegAfterWp,navMethodInTheLegAfterWp}

function NMEA_2000_130069.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130069 (Route and WP Service - XTE Limit & Navigation Method)"
    local subtree = tree:add(NMEA_2000_130069, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 2) then
        subtree:add_le(startRps, buffer(str_offset, 2))
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add_le(nitems, buffer(str_offset + 2, 2))
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add_le(numberOfWpsWithASpecificXteLimitOrNavMethod, buffer(str_offset + 4, 2))
    end
    local count_1 = buffer(str_offset + 2, 2):le_uint()
    if count_1 > 100 then count_1 = 0 end  -- likely 'not available' sentinel
    local rep_offset_1 = str_offset + 6
    for _i_1 = 1, count_1 do
    if rep_offset_1 + 9 > buffer:len() then break end
    do
        local _start = rep_offset_1 + 0
        if buffer:len() >= (_start + 2) then
            local _rng = buffer(_start, 2)
            local _raw = _rng:le_uint()
            local _val = _raw
            subtree:add(databaseId, _rng, _val)
        end
    end
    do
        local _start = rep_offset_1 + 2
        if buffer:len() >= (_start + 2) then
            local _rng = buffer(_start, 2)
            local _raw = _rng:le_uint()
            local _val = _raw
            subtree:add(routeId, _rng, _val)
        end
    end
    do
        local _start = rep_offset_1 + 4
        if buffer:len() >= (_start + 2) then
            local _rng = buffer(_start, 2)
            local _raw = _rng:le_uint()
            local _val = _raw
            subtree:add(rps, _rng, _val)
        end
    end
    do
        local _start = rep_offset_1 + 6
        if buffer:len() >= (_start + 2) then
            local _rng = buffer(_start, 2)
            local _raw = _rng:le_uint()
            local _val = _raw
            if _val >= 2 ^ (16 - 1) then
                _val = _val - 2 ^ 16
            end
            subtree:add(xteLimitInTheLegAfterWp, _rng, _val)
        end
    end
    do
        local _start = rep_offset_1 + 8
        if buffer:len() >= (_start + 1) then
            local _rng = buffer(_start, 1)
            local _raw = _rng:le_uint()
            local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 2)
            subtree:add(navMethodInTheLegAfterWp, _rng, _val)
        end
    end
    rep_offset_1 = rep_offset_1 + 9
    end
end

return NMEA_2000_130069
