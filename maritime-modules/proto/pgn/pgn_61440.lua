-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_61440 = Proto("nmea-2000-61440", "0xF000-0xFEFF: Standardized single-frame non-addressed (61440)")
local industryCode = ProtoField.uint8("nmea-2000-61440.industryCode", "Industry Code", base.DEC, NULL, 0xe0)

NMEA_2000_61440.fields = {industryCode}

function NMEA_2000_61440.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 61440 (0xF000-0xFEFF: Standardized single-frame non-addressed)"
    local subtree = tree:add(NMEA_2000_61440, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
end

return NMEA_2000_61440
