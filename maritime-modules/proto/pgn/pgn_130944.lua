-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130944 = Proto("nmea-2000-130944", "Airmar: POST (130944)")
local manufacturerCode = ProtoField.uint32("nmea-2000-130944.manufacturerCode", "Manufacturer Code")
local industryCode = ProtoField.uint8("nmea-2000-130944.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local control = ProtoField.uint8("nmea-2000-130944.control", "Control", base.DEC, NULL, 0x1)
local numberOfIdTestResultPairsToFollow = ProtoField.uint8("nmea-2000-130944.numberOfIdTestResultPairsToFollow", "Number of ID/test result pairs to follow")
local testId = ProtoField.uint8("nmea-2000-130944.testId", "Test ID", base.DEC, NULL, 0xff)
local testResult = ProtoField.uint8("nmea-2000-130944.testResult", "Test result")

NMEA_2000_130944.fields = {manufacturerCode,industryCode,control,numberOfIdTestResultPairsToFollow,testId,testResult}

function NMEA_2000_130944.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130944 (Airmar: POST)"
    local subtree = tree:add(NMEA_2000_130944, buffer(), subtree_title)
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
        subtree:add(control, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(numberOfIdTestResultPairsToFollow, buffer(str_offset + 3, 1))
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        subtree:add(testId, buffer(str_offset + 4, 1))
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        subtree:add(testResult, buffer(str_offset + 5, 1))
    end
end

return NMEA_2000_130944
