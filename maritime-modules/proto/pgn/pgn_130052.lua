-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130052 = Proto("nmea-2000-130052", "Loran-C TD Data (130052)")
local groupRepetitionIntervalGri = ProtoField.float("nmea-2000-130052.groupRepetitionIntervalGri", "Group Repetition Interval (GRI) (s)")
local masterRange = ProtoField.float("nmea-2000-130052.masterRange", "Master Range (s)")
local vSecondaryTd = ProtoField.float("nmea-2000-130052.vSecondaryTd", "V Secondary TD (s)")
local wSecondaryTd = ProtoField.float("nmea-2000-130052.wSecondaryTd", "W Secondary TD (s)")
local xSecondaryTd = ProtoField.float("nmea-2000-130052.xSecondaryTd", "X Secondary TD (s)")
local ySecondaryTd = ProtoField.float("nmea-2000-130052.ySecondaryTd", "Y Secondary TD (s)")
local zSecondaryTd = ProtoField.float("nmea-2000-130052.zSecondaryTd", "Z Secondary TD (s)")
local mode = ProtoField.uint8("nmea-2000-130052.mode", "Mode", base.DEC, NULL, 0xf)

NMEA_2000_130052.fields = {groupRepetitionIntervalGri,masterRange,vSecondaryTd,wSecondaryTd,xSecondaryTd,ySecondaryTd,zSecondaryTd,mode}

function NMEA_2000_130052.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130052 (Loran-C TD Data)"
    local subtree = tree:add(NMEA_2000_130052, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(groupRepetitionIntervalGri, buffer(str_offset + 0, 4), buffer(str_offset + 0, 4):le_int() * 1e-09)
    subtree:add(masterRange, buffer(str_offset + 4, 4), buffer(str_offset + 4, 4):le_int() * 1e-09)
    subtree:add(vSecondaryTd, buffer(str_offset + 8, 4), buffer(str_offset + 8, 4):le_int() * 1e-09)
    subtree:add(wSecondaryTd, buffer(str_offset + 12, 4), buffer(str_offset + 12, 4):le_int() * 1e-09)
    subtree:add(xSecondaryTd, buffer(str_offset + 16, 4), buffer(str_offset + 16, 4):le_int() * 1e-09)
    subtree:add(ySecondaryTd, buffer(str_offset + 20, 4), buffer(str_offset + 20, 4):le_int() * 1e-09)
    subtree:add(zSecondaryTd, buffer(str_offset + 24, 4), buffer(str_offset + 24, 4):le_int() * 1e-09)
    subtree:add(mode, buffer(str_offset + 31, 1))
end

return NMEA_2000_130052
