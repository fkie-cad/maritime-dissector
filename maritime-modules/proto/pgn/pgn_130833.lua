-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130833 = Proto("nmea-2000-130833", "B&G: User and Remote rename (130833)")
local manufacturerCode = ProtoField.uint32("nmea-2000-130833.manufacturerCode", "Manufacturer Code")
local industryCode = ProtoField.uint8("nmea-2000-130833.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local dataType = ProtoField.uint32("nmea-2000-130833.dataType", "Data Type")
local length = ProtoField.uint32("nmea-2000-130833.length", "Length")
local decimals = ProtoField.uint8("nmea-2000-130833.decimals", "Decimals", base.DEC, NULL, 0xff)
local shortName = ProtoField.string("nmea-2000-130833.shortName", "Short name")
local longName = ProtoField.string("nmea-2000-130833.longName", "Long name")

NMEA_2000_130833.fields = {manufacturerCode,industryCode,dataType,length,decimals,shortName,longName}

function NMEA_2000_130833.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130833 (B&G: User and Remote rename)"
    local subtree = tree:add(NMEA_2000_130833, buffer(), subtree_title)
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
    do
        local _rng = buffer(str_offset + 2, 2)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 12)
        subtree:add(dataType, _rng, _val)
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        local _rng = buffer(str_offset + 3, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 4)) % (2 ^ 4)
        subtree:add(length, _rng, _val)
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        subtree:add(decimals, buffer(str_offset + 5, 1))
    end
    if buffer:len() >= (str_offset + 6 + 8) then
        local _shortName_raw = buffer(str_offset + 6, 8):string()
        local _shortName_clean = _shortName_raw:gsub("[%s@%z\xff]+$", "")
        subtree:add(shortName, buffer(str_offset + 6, 8), _shortName_clean)
    end
    if buffer:len() >= (str_offset + 14 + 16) then
        local _longName_raw = buffer(str_offset + 14, 16):string()
        local _longName_clean = _longName_raw:gsub("[%s@%z\xff]+$", "")
        subtree:add(longName, buffer(str_offset + 14, 16), _longName_clean)
    end
end

return NMEA_2000_130833
