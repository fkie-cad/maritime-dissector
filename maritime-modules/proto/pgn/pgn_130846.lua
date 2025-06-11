-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130846 = Proto("nmea-2000-130846", "Furuno: Motion Sensor Status Extended (130846)")
local industryCode = ProtoField.uint8("nmea-2000-130846.industryCode", "Industry Code", base.DEC, NULL, 0xe0)

NMEA_2000_130846.fields = {industryCode}

function NMEA_2000_130846.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130846 (Furuno: Motion Sensor Status Extended)"
    local subtree = tree:add(NMEA_2000_130846, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
end

return NMEA_2000_130846
