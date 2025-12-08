-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129025 = Proto("nmea-2000-129025", "Position, Rapid Update (129025)")
local latitude = ProtoField.float("nmea-2000-129025.latitude", "Latitude (deg)")
local longitude = ProtoField.float("nmea-2000-129025.longitude", "Longitude (deg)")

NMEA_2000_129025.fields = {latitude,longitude}

function NMEA_2000_129025.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129025 (Position, Rapid Update)"
    local subtree = tree:add(NMEA_2000_129025, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 4) then
        subtree:add(latitude, buffer(str_offset, 4), buffer(str_offset, 4):le_int() * 1e-07)
    end
    if buffer:len() >= (str_offset + 4 + 4) then
        subtree:add(longitude, buffer(str_offset + 4, 4), buffer(str_offset + 4, 4):le_int() * 1e-07)
    end
end

return NMEA_2000_129025
