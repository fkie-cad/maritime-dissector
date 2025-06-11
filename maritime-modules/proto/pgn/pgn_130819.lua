-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130819 = Proto("nmea-2000-130819", "Simnet: Request Reprogram (130819)")
local industryCode = ProtoField.uint8("nmea-2000-130819.industryCode", "Industry Code", base.DEC, NULL, 0xe0)

NMEA_2000_130819.fields = {industryCode}

function NMEA_2000_130819.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130819 (Simnet: Request Reprogram)"
    local subtree = tree:add(NMEA_2000_130819, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
end

return NMEA_2000_130819
