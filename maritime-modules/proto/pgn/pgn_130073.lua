-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130073 = Proto("nmea-2000-130073", "Route and WP Service - Radius of Turn (130073)")
local startRps = ProtoField.uint16("nmea-2000-130073.startRps", "Start RPS#")
local nitems = ProtoField.uint16("nmea-2000-130073.nitems", "nItems")
local numberOfWpsWithASpecificRadiusOfTurn = ProtoField.uint16("nmea-2000-130073.numberOfWpsWithASpecificRadiusOfTurn", "Number of WPs with a specific Radius of Turn")
local databaseId = ProtoField.uint16("nmea-2000-130073.databaseId", "Database ID")
local routeId = ProtoField.uint16("nmea-2000-130073.routeId", "Route ID")
local rps = ProtoField.uint16("nmea-2000-130073.rps", "RPS#")
local radiusOfTurn = ProtoField.int16("nmea-2000-130073.radiusOfTurn", "Radius of Turn (m)")

NMEA_2000_130073.fields = {startRps,nitems,numberOfWpsWithASpecificRadiusOfTurn,databaseId,routeId,rps,radiusOfTurn}

function NMEA_2000_130073.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130073 (Route and WP Service - Radius of Turn)"
    local subtree = tree:add(NMEA_2000_130073, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 2) then
        subtree:add_le(startRps, buffer(str_offset, 2))
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add_le(nitems, buffer(str_offset + 2, 2))
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add_le(numberOfWpsWithASpecificRadiusOfTurn, buffer(str_offset + 4, 2))
    end
    if buffer:len() >= (str_offset + 6 + 2) then
        subtree:add_le(databaseId, buffer(str_offset + 6, 2))
    end
    if buffer:len() >= (str_offset + 8 + 2) then
        subtree:add_le(routeId, buffer(str_offset + 8, 2))
    end
    local count_1 = buffer(str_offset + 2, 2):le_uint()
    if count_1 > 100 then count_1 = 0 end  -- likely 'not available' sentinel
    local rep_offset_1 = str_offset + 10
    for _i_1 = 1, count_1 do
    if rep_offset_1 + 4 > buffer:len() then break end
    do
        local _start = rep_offset_1 + 0
        if buffer:len() >= (_start + 2) then
            local _rng = buffer(_start, 2)
            local _raw = _rng:le_uint()
            local _val = _raw
            subtree:add(rps, _rng, _val)
        end
    end
    do
        local _start = rep_offset_1 + 2
        if buffer:len() >= (_start + 2) then
            local _rng = buffer(_start, 2)
            local _raw = _rng:le_uint()
            local _val = _raw
            if _val >= 2 ^ (16 - 1) then
                _val = _val - 2 ^ 16
            end
            subtree:add(radiusOfTurn, _rng, _val)
        end
    end
    rep_offset_1 = rep_offset_1 + 4
    end
end

return NMEA_2000_130073
