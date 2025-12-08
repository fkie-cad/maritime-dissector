-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_126464 = Proto("nmea-2000-126464", "PGN List (Transmit and Receive) (126464)")
local functionCode = ProtoField.uint8("nmea-2000-126464.functionCode", "Function Code", base.DEC, NULL, 0xff)
local pgn = ProtoField.uint24("nmea-2000-126464.pgn", "PGN")

NMEA_2000_126464.fields = {functionCode,pgn}

function NMEA_2000_126464.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 126464 (PGN List (Transmit and Receive))"
    local subtree = tree:add(NMEA_2000_126464, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(functionCode, buffer(str_offset, 1))
    end
    local rem_1 = buffer:len() - (str_offset + 1)
    local count_1 = math.floor(rem_1 / 3)
    local rep_offset_1 = str_offset + 1
    for _i_1 = 1, count_1 do
    if rep_offset_1 + 3 > buffer:len() then break end
    do
        local _start = rep_offset_1 + 0
        if buffer:len() >= (_start + 3) then
            local _rng = buffer(_start, 3)
            local _raw = _rng:le_uint()
            local _val = _raw
            subtree:add(pgn, _rng, _val)
        end
    end
    rep_offset_1 = rep_offset_1 + 3
    end
end

return NMEA_2000_126464
