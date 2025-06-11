-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130881 = Proto("nmea-2000-130881", "Airmar: Heater Control (130881)")
local industryCode = ProtoField.uint8("nmea-2000-130881.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local c = ProtoField.float("nmea-2000-130881.c", "C")
local plateTemperature = ProtoField.float("nmea-2000-130881.plateTemperature", "Plate Temperature (K)")
local airTemperature = ProtoField.float("nmea-2000-130881.airTemperature", "Air Temperature (K)")
local dewpoint = ProtoField.float("nmea-2000-130881.dewpoint", "Dewpoint (K)")

NMEA_2000_130881.fields = {industryCode,c,plateTemperature,airTemperature,dewpoint}

function NMEA_2000_130881.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130881 (Airmar: Heater Control)"
    local subtree = tree:add(NMEA_2000_130881, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
    subtree:add(c, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(plateTemperature, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_uint() * 0.01)
    subtree:add(airTemperature, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_uint() * 0.01)
    subtree:add(dewpoint, buffer(str_offset + 7, 2), buffer(str_offset + 7, 2):le_uint() * 0.01)
end

return NMEA_2000_130881
