-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130860 = Proto("nmea-2000-130860", "Simnet: AP Unknown 4 (130860)")
local industryCode = ProtoField.uint8("nmea-2000-130860.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local a = ProtoField.float("nmea-2000-130860.a", "A")
local b = ProtoField.float("nmea-2000-130860.b", "B")
local c = ProtoField.float("nmea-2000-130860.c", "C")
local d = ProtoField.float("nmea-2000-130860.d", "D")
local e = ProtoField.float("nmea-2000-130860.e", "E")
local f = ProtoField.float("nmea-2000-130860.f", "F")

NMEA_2000_130860.fields = {industryCode,a,b,c,d,e,f}

function NMEA_2000_130860.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130860 (Simnet: AP Unknown 4)"
    local subtree = tree:add(NMEA_2000_130860, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
    subtree:add(a, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(b, buffer(str_offset + 3, 4), buffer(str_offset + 3, 4):le_int() * 1)
    subtree:add(c, buffer(str_offset + 7, 4), buffer(str_offset + 7, 4):le_int() * 1)
    subtree:add(d, buffer(str_offset + 11, 4), buffer(str_offset + 11, 4):le_uint() * 1)
    subtree:add(e, buffer(str_offset + 15, 4), buffer(str_offset + 15, 4):le_int() * 1)
    subtree:add(f, buffer(str_offset + 19, 4), buffer(str_offset + 19, 4):le_uint() * 1)
end

return NMEA_2000_130860
