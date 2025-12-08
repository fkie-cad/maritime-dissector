-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_65013 = Proto("nmea-2000-65013", "Utility Phase A AC Power (65013)")
local realPower = ProtoField.int32("nmea-2000-65013.realPower", "Real Power (W)")
local apparentPower = ProtoField.int32("nmea-2000-65013.apparentPower", "Apparent Power (VA)")

NMEA_2000_65013.fields = {realPower,apparentPower}

function NMEA_2000_65013.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 65013 (Utility Phase A AC Power)"
    local subtree = tree:add(NMEA_2000_65013, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 4) then
        subtree:add_le(realPower, buffer(str_offset, 4))
    end
    if buffer:len() >= (str_offset + 4 + 4) then
        subtree:add_le(apparentPower, buffer(str_offset + 4, 4))
    end
end

return NMEA_2000_65013
