-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130818 = Proto("nmea-2000-130818", "Simnet: Reprogram Data (130818)")
local industryCode = ProtoField.uint8("nmea-2000-130818.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local version = ProtoField.float("nmea-2000-130818.version", "Version")
local sequence = ProtoField.float("nmea-2000-130818.sequence", "Sequence")

NMEA_2000_130818.fields = {industryCode,version,sequence}

function NMEA_2000_130818.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130818 (Simnet: Reprogram Data)"
    local subtree = tree:add(NMEA_2000_130818, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
    subtree:add(version, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 1)
    subtree:add(sequence, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 1)
end

return NMEA_2000_130818
