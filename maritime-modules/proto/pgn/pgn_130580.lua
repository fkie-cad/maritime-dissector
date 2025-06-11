-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130580 = Proto("nmea-2000-130580", "System Configuration (deprecated) (130580)")
local power = ProtoField.uint8("nmea-2000-130580.power", "Power", base.DEC, NULL, 0x3)
local defaultSettings = ProtoField.uint8("nmea-2000-130580.defaultSettings", "Default Settings", base.DEC, NULL, 0xc)
local tunerRegions = ProtoField.uint8("nmea-2000-130580.tunerRegions", "Tuner regions", base.DEC, NULL, 0xf0)
local maxFavorites = ProtoField.float("nmea-2000-130580.maxFavorites", "Max favorites")

NMEA_2000_130580.fields = {power,defaultSettings,tunerRegions,maxFavorites}

function NMEA_2000_130580.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130580 (System Configuration (deprecated))"
    local subtree = tree:add(NMEA_2000_130580, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(power, buffer(str_offset + 0, 1))
    subtree:add(defaultSettings, buffer(str_offset + 0, 1))
    subtree:add(tunerRegions, buffer(str_offset + 0, 1))
    subtree:add(maxFavorites, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
end

return NMEA_2000_130580
