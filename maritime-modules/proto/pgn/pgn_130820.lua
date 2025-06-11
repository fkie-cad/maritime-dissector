-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130820 = Proto("nmea-2000-130820", "Fusion: SiriusXM Presets (130820)")
local industryCode = ProtoField.uint8("nmea-2000-130820.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local sourceId = ProtoField.float("nmea-2000-130820.sourceId", "Source ID")
local count = ProtoField.float("nmea-2000-130820.count", "Count")

NMEA_2000_130820.fields = {industryCode,sourceId,count}

function NMEA_2000_130820.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130820 (Fusion: SiriusXM Presets)"
    local subtree = tree:add(NMEA_2000_130820, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
    subtree:add(sourceId, buffer(str_offset + 4, 1), buffer(str_offset + 4, 1):le_uint() * 1)
    subtree:add(count, buffer(str_offset + 5, 1), buffer(str_offset + 5, 1):le_uint() * 1)
end

return NMEA_2000_130820
