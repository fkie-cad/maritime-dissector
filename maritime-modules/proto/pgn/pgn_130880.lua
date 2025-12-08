-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130880 = Proto("nmea-2000-130880", "Airmar: Additional Weather Data (130880)")
local manufacturerCode = ProtoField.uint32("nmea-2000-130880.manufacturerCode", "Manufacturer Code")
local industryCode = ProtoField.uint8("nmea-2000-130880.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local c = ProtoField.uint8("nmea-2000-130880.c", "C")
local apparentWindchillTemperature = ProtoField.float("nmea-2000-130880.apparentWindchillTemperature", "Apparent Windchill Temperature (K)")
local trueWindchillTemperature = ProtoField.float("nmea-2000-130880.trueWindchillTemperature", "True Windchill Temperature (K)")
local dewpoint = ProtoField.float("nmea-2000-130880.dewpoint", "Dewpoint (K)")

NMEA_2000_130880.fields = {manufacturerCode,industryCode,c,apparentWindchillTemperature,trueWindchillTemperature,dewpoint}

function NMEA_2000_130880.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130880 (Airmar: Additional Weather Data)"
    local subtree = tree:add(NMEA_2000_130880, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 2) then
        local _rng = buffer(str_offset, 2)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 11)
        subtree:add(manufacturerCode, _rng, _val)
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(industryCode, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(c, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 3 + 2) then
        subtree:add(apparentWindchillTemperature, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 5 + 2) then
        subtree:add(trueWindchillTemperature, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 7 + 2) then
        subtree:add(dewpoint, buffer(str_offset + 7, 2), buffer(str_offset + 7, 2):le_uint() * 0.01)
    end
end

return NMEA_2000_130880
