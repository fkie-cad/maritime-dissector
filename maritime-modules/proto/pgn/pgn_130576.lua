-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130576 = Proto("nmea-2000-130576", "Small Craft Status (130576)")
local portTrimTab = ProtoField.float("nmea-2000-130576.portTrimTab", "Port trim tab (%)")
local starboardTrimTab = ProtoField.float("nmea-2000-130576.starboardTrimTab", "Starboard trim tab (%)")

NMEA_2000_130576.fields = {portTrimTab,starboardTrimTab}

function NMEA_2000_130576.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130576 (Small Craft Status)"
    local subtree = tree:add(NMEA_2000_130576, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(portTrimTab, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_int() * 1)
    subtree:add(starboardTrimTab, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_int() * 1)
end

return NMEA_2000_130576
