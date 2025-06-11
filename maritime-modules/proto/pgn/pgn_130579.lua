-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130579 = Proto("nmea-2000-130579", "System Configuration (130579)")
local power = ProtoField.uint8("nmea-2000-130579.power", "Power", base.DEC, NULL, 0x3)
local defaultSettings = ProtoField.uint8("nmea-2000-130579.defaultSettings", "Default Settings", base.DEC, NULL, 0xc)
local tunerRegions = ProtoField.uint8("nmea-2000-130579.tunerRegions", "Tuner regions", base.DEC, NULL, 0xf0)
local maxFavorites = ProtoField.float("nmea-2000-130579.maxFavorites", "Max favorites")
local videoProtocols = ProtoField.uint8("nmea-2000-130579.videoProtocols", "Video protocols", base.DEC, NULL, 0xf)

NMEA_2000_130579.fields = {power,defaultSettings,tunerRegions,maxFavorites,videoProtocols}

function NMEA_2000_130579.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130579 (System Configuration)"
    local subtree = tree:add(NMEA_2000_130579, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(power, buffer(str_offset + 0, 1))
    subtree:add(defaultSettings, buffer(str_offset + 0, 1))
    subtree:add(tunerRegions, buffer(str_offset + 0, 1))
    subtree:add(maxFavorites, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(videoProtocols, buffer(str_offset + 2, 1))
end

return NMEA_2000_130579
