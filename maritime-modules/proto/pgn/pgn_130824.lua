-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130824 = Proto("nmea-2000-130824", "Maretron: Annunciator (130824)")
local industryCode = ProtoField.uint8("nmea-2000-130824.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local field4 = ProtoField.float("nmea-2000-130824.field4", "Field 4")
local field5 = ProtoField.float("nmea-2000-130824.field5", "Field 5")
local field6 = ProtoField.float("nmea-2000-130824.field6", "Field 6")
local field7 = ProtoField.float("nmea-2000-130824.field7", "Field 7")
local field8 = ProtoField.float("nmea-2000-130824.field8", "Field 8")

NMEA_2000_130824.fields = {industryCode,field4,field5,field6,field7,field8}

function NMEA_2000_130824.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130824 (Maretron: Annunciator)"
    local subtree = tree:add(NMEA_2000_130824, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
    subtree:add(field4, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(field5, buffer(str_offset + 3, 1), buffer(str_offset + 3, 1):le_uint() * 1)
    subtree:add(field6, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 1)
    subtree:add(field7, buffer(str_offset + 6, 1), buffer(str_offset + 6, 1):le_uint() * 1)
    subtree:add(field8, buffer(str_offset + 7, 2), buffer(str_offset + 7, 2):le_uint() * 1)
end

return NMEA_2000_130824
