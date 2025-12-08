-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_126720 = Proto("nmea-2000-126720", "Garmin: Color mode (126720)")
local manufacturerCode = ProtoField.uint32("nmea-2000-126720.manufacturerCode", "Manufacturer Code")
local industryCode = ProtoField.uint8("nmea-2000-126720.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local unknownId1 = ProtoField.uint8("nmea-2000-126720.unknownId1", "Unknown ID 1")
local unknownId2 = ProtoField.uint8("nmea-2000-126720.unknownId2", "Unknown ID 2")
local unknownId3 = ProtoField.uint8("nmea-2000-126720.unknownId3", "Unknown ID 3")
local unknownId4 = ProtoField.uint8("nmea-2000-126720.unknownId4", "Unknown ID 4")
local mode = ProtoField.uint8("nmea-2000-126720.mode", "Mode", base.DEC, NULL, 0xff)
local color = ProtoField.uint8("nmea-2000-126720.color", "Color", base.DEC, NULL, 0xff)

NMEA_2000_126720.fields = {manufacturerCode,industryCode,unknownId1,unknownId2,unknownId3,unknownId4,mode,color}

function NMEA_2000_126720.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 126720 (Garmin: Color mode)"
    local subtree = tree:add(NMEA_2000_126720, buffer(), subtree_title)
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
        subtree:add(unknownId1, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(unknownId2, buffer(str_offset + 3, 1))
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        subtree:add(unknownId3, buffer(str_offset + 4, 1))
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        subtree:add(unknownId4, buffer(str_offset + 5, 1))
    end
    if buffer:len() >= (str_offset + 8 + 1) then
        subtree:add(mode, buffer(str_offset + 8, 1))
    end
    if buffer:len() >= (str_offset + 10 + 1) then
        subtree:add(color, buffer(str_offset + 10, 1))
    end
end

return NMEA_2000_126720
