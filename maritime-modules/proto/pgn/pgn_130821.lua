-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130821 = Proto("nmea-2000-130821", "Furuno: Unknown 130821 (130821)")
local industryCode = ProtoField.uint8("nmea-2000-130821.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local sid = ProtoField.float("nmea-2000-130821.sid", "SID")
local a = ProtoField.float("nmea-2000-130821.a", "A")
local b = ProtoField.float("nmea-2000-130821.b", "B")
local c = ProtoField.float("nmea-2000-130821.c", "C")
local d = ProtoField.float("nmea-2000-130821.d", "D")
local e = ProtoField.float("nmea-2000-130821.e", "E")
local f = ProtoField.float("nmea-2000-130821.f", "F")
local g = ProtoField.float("nmea-2000-130821.g", "G")
local h = ProtoField.float("nmea-2000-130821.h", "H")
local i = ProtoField.float("nmea-2000-130821.i", "I")

NMEA_2000_130821.fields = {industryCode,sid,a,b,c,d,e,f,g,h,i}

function NMEA_2000_130821.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130821 (Furuno: Unknown 130821)"
    local subtree = tree:add(NMEA_2000_130821, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
    subtree:add(sid, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(a, buffer(str_offset + 3, 1), buffer(str_offset + 3, 1):le_uint() * 1)
    subtree:add(b, buffer(str_offset + 4, 1), buffer(str_offset + 4, 1):le_uint() * 1)
    subtree:add(c, buffer(str_offset + 5, 1), buffer(str_offset + 5, 1):le_uint() * 1)
    subtree:add(d, buffer(str_offset + 6, 1), buffer(str_offset + 6, 1):le_uint() * 1)
    subtree:add(e, buffer(str_offset + 7, 1), buffer(str_offset + 7, 1):le_uint() * 1)
    subtree:add(f, buffer(str_offset + 8, 1), buffer(str_offset + 8, 1):le_uint() * 1)
    subtree:add(g, buffer(str_offset + 9, 1), buffer(str_offset + 9, 1):le_uint() * 1)
    subtree:add(h, buffer(str_offset + 10, 1), buffer(str_offset + 10, 1):le_uint() * 1)
    subtree:add(i, buffer(str_offset + 11, 1), buffer(str_offset + 11, 1):le_uint() * 1)
end

return NMEA_2000_130821
