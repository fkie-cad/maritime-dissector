-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130880 = Proto("nmea-2000-130880", "Airmar: Additional Weather Data (130880)")
local industryCode = ProtoField.uint8("nmea-2000-130880.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local c = ProtoField.float("nmea-2000-130880.c", "C")
local apparentWindchillTemperature = ProtoField.float("nmea-2000-130880.apparentWindchillTemperature", "Apparent Windchill Temperature (K)")
local trueWindchillTemperature = ProtoField.float("nmea-2000-130880.trueWindchillTemperature", "True Windchill Temperature (K)")
local dewpoint = ProtoField.float("nmea-2000-130880.dewpoint", "Dewpoint (K)")

NMEA_2000_130880.fields = {industryCode,c,apparentWindchillTemperature,trueWindchillTemperature,dewpoint}

function NMEA_2000_130880.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130880 (Airmar: Additional Weather Data)"
    local subtree = tree:add(NMEA_2000_130880, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
    subtree:add(c, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(apparentWindchillTemperature, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_uint() * 0.01)
    subtree:add(trueWindchillTemperature, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_uint() * 0.01)
    subtree:add(dewpoint, buffer(str_offset + 7, 2), buffer(str_offset + 7, 2):le_uint() * 0.01)
end

return NMEA_2000_130880
