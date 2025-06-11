-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_126720 = Proto("nmea-2000-126720", "Garmin: Color mode (126720)")
local industryCode = ProtoField.uint8("nmea-2000-126720.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local unknownId1 = ProtoField.float("nmea-2000-126720.unknownId1", "Unknown ID 1")
local unknownId2 = ProtoField.float("nmea-2000-126720.unknownId2", "Unknown ID 2")
local unknownId3 = ProtoField.float("nmea-2000-126720.unknownId3", "Unknown ID 3")
local unknownId4 = ProtoField.float("nmea-2000-126720.unknownId4", "Unknown ID 4")
local mode = ProtoField.uint8("nmea-2000-126720.mode", "Mode", base.DEC, NULL, 0xff)
local color = ProtoField.uint8("nmea-2000-126720.color", "Color", base.DEC, NULL, 0xff)

NMEA_2000_126720.fields = {industryCode,unknownId1,unknownId2,unknownId3,unknownId4,mode,color}

function NMEA_2000_126720.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 126720 (Garmin: Color mode)"
    local subtree = tree:add(NMEA_2000_126720, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
    subtree:add(unknownId1, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(unknownId2, buffer(str_offset + 3, 1), buffer(str_offset + 3, 1):le_uint() * 1)
    subtree:add(unknownId3, buffer(str_offset + 4, 1), buffer(str_offset + 4, 1):le_uint() * 1)
    subtree:add(unknownId4, buffer(str_offset + 5, 1), buffer(str_offset + 5, 1):le_uint() * 1)
    subtree:add(mode, buffer(str_offset + 8, 1))
    subtree:add(color, buffer(str_offset + 10, 1))
end

return NMEA_2000_126720
