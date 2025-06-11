-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130827 = Proto("nmea-2000-130827", "Lowrance: unknown (130827)")
local industryCode = ProtoField.uint8("nmea-2000-130827.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local a = ProtoField.float("nmea-2000-130827.a", "A")
local b = ProtoField.float("nmea-2000-130827.b", "B")
local c = ProtoField.float("nmea-2000-130827.c", "C")
local d = ProtoField.float("nmea-2000-130827.d", "D")
local e = ProtoField.float("nmea-2000-130827.e", "E")
local f = ProtoField.float("nmea-2000-130827.f", "F")

NMEA_2000_130827.fields = {industryCode,a,b,c,d,e,f}

function NMEA_2000_130827.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130827 (Lowrance: unknown)"
    local subtree = tree:add(NMEA_2000_130827, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
    subtree:add(a, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(b, buffer(str_offset + 3, 1), buffer(str_offset + 3, 1):le_uint() * 1)
    subtree:add(c, buffer(str_offset + 4, 1), buffer(str_offset + 4, 1):le_uint() * 1)
    subtree:add(d, buffer(str_offset + 5, 1), buffer(str_offset + 5, 1):le_uint() * 1)
    subtree:add(e, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 1)
    subtree:add(f, buffer(str_offset + 8, 2), buffer(str_offset + 8, 2):le_uint() * 1)
end

return NMEA_2000_130827
