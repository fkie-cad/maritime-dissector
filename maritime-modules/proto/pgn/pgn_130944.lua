-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130944 = Proto("nmea-2000-130944", "Airmar: POST (130944)")
local industryCode = ProtoField.uint8("nmea-2000-130944.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local control = ProtoField.uint8("nmea-2000-130944.control", "Control", base.DEC, NULL, 0x1)
local numberOfIdTestResultPairsToFollow = ProtoField.float("nmea-2000-130944.numberOfIdTestResultPairsToFollow", "Number of ID/test result pairs to follow")
local testId = ProtoField.uint8("nmea-2000-130944.testId", "Test ID", base.DEC, NULL, 0xff)
local testResult = ProtoField.float("nmea-2000-130944.testResult", "Test result")

NMEA_2000_130944.fields = {industryCode,control,numberOfIdTestResultPairsToFollow,testId,testResult}

function NMEA_2000_130944.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130944 (Airmar: POST)"
    local subtree = tree:add(NMEA_2000_130944, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
    subtree:add(control, buffer(str_offset + 2, 1))
    subtree:add(numberOfIdTestResultPairsToFollow, buffer(str_offset + 3, 1), buffer(str_offset + 3, 1):le_uint() * 1)
    subtree:add(testId, buffer(str_offset + 4, 1))
    subtree:add(testResult, buffer(str_offset + 5, 1), buffer(str_offset + 5, 1):le_uint() * 1)
end

return NMEA_2000_130944
