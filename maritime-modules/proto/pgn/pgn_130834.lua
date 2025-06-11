-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130834 = Proto("nmea-2000-130834", "Simnet: Engine and Tank Configuration (130834)")
local industryCode = ProtoField.uint8("nmea-2000-130834.industryCode", "Industry Code", base.DEC, NULL, 0xe0)

NMEA_2000_130834.fields = {industryCode}

function NMEA_2000_130834.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130834 (Simnet: Engine and Tank Configuration)"
    local subtree = tree:add(NMEA_2000_130834, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
end

return NMEA_2000_130834
