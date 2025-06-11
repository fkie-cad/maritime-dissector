-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_65016 = Proto("nmea-2000-65016", "Utility Total AC Power (65016)")
local realPower = ProtoField.float("nmea-2000-65016.realPower", "Real Power (W)")
local apparentPower = ProtoField.float("nmea-2000-65016.apparentPower", "Apparent Power (VA)")

NMEA_2000_65016.fields = {realPower,apparentPower}

function NMEA_2000_65016.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 65016 (Utility Total AC Power)"
    local subtree = tree:add(NMEA_2000_65016, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(realPower, buffer(str_offset + 0, 4), buffer(str_offset + 0, 4):le_int() * 1)
    subtree:add(apparentPower, buffer(str_offset + 4, 4), buffer(str_offset + 4, 4):le_int() * 1)
end

return NMEA_2000_65016
