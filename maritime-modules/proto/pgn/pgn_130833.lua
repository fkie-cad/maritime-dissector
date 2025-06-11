-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130833 = Proto("nmea-2000-130833", "B&G: User and Remote rename (130833)")
local industryCode = ProtoField.uint8("nmea-2000-130833.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local decimals = ProtoField.uint8("nmea-2000-130833.decimals", "Decimals", base.DEC, NULL, 0xff)
local shortName = ProtoField.string("nmea-2000-130833.shortName", "Short name")
local longName = ProtoField.string("nmea-2000-130833.longName", "Long name")

NMEA_2000_130833.fields = {industryCode,decimals,shortName,longName}

function NMEA_2000_130833.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130833 (B&G: User and Remote rename)"
    local subtree = tree:add(NMEA_2000_130833, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
    subtree:add(decimals, buffer(str_offset + 5, 1))
    subtree:add(shortName, buffer(str_offset + 6, 8))
    subtree:add(longName, buffer(str_offset + 14, 16))
end

return NMEA_2000_130833
