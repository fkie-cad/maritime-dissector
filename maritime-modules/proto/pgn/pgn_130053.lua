-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130053 = Proto("nmea-2000-130053", "Loran-C Range Data (130053)")
local groupRepetitionIntervalGri = ProtoField.float("nmea-2000-130053.groupRepetitionIntervalGri", "Group Repetition Interval (GRI) (s)")
local masterRange = ProtoField.float("nmea-2000-130053.masterRange", "Master Range (s)")
local vSecondaryRange = ProtoField.float("nmea-2000-130053.vSecondaryRange", "V Secondary Range (s)")
local wSecondaryRange = ProtoField.float("nmea-2000-130053.wSecondaryRange", "W Secondary Range (s)")
local xSecondaryRange = ProtoField.float("nmea-2000-130053.xSecondaryRange", "X Secondary Range (s)")
local ySecondaryRange = ProtoField.float("nmea-2000-130053.ySecondaryRange", "Y Secondary Range (s)")
local zSecondaryRange = ProtoField.float("nmea-2000-130053.zSecondaryRange", "Z Secondary Range (s)")
local mode = ProtoField.uint8("nmea-2000-130053.mode", "Mode", base.DEC, NULL, 0xf)

NMEA_2000_130053.fields = {groupRepetitionIntervalGri,masterRange,vSecondaryRange,wSecondaryRange,xSecondaryRange,ySecondaryRange,zSecondaryRange,mode}

function NMEA_2000_130053.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130053 (Loran-C Range Data)"
    local subtree = tree:add(NMEA_2000_130053, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(groupRepetitionIntervalGri, buffer(str_offset + 0, 4), buffer(str_offset + 0, 4):le_int() * 1e-09)
    subtree:add(masterRange, buffer(str_offset + 4, 4), buffer(str_offset + 4, 4):le_int() * 1e-09)
    subtree:add(vSecondaryRange, buffer(str_offset + 8, 4), buffer(str_offset + 8, 4):le_int() * 1e-09)
    subtree:add(wSecondaryRange, buffer(str_offset + 12, 4), buffer(str_offset + 12, 4):le_int() * 1e-09)
    subtree:add(xSecondaryRange, buffer(str_offset + 16, 4), buffer(str_offset + 16, 4):le_int() * 1e-09)
    subtree:add(ySecondaryRange, buffer(str_offset + 20, 4), buffer(str_offset + 20, 4):le_int() * 1e-09)
    subtree:add(zSecondaryRange, buffer(str_offset + 24, 4), buffer(str_offset + 24, 4):le_int() * 1e-09)
    subtree:add(mode, buffer(str_offset + 31, 1))
end

return NMEA_2000_130053
