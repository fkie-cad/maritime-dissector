-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130816 = Proto("nmea-2000-130816", "Simrad: Text Message (130816)")
local industryCode = ProtoField.uint8("nmea-2000-130816.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local proprietaryId = ProtoField.uint8("nmea-2000-130816.proprietaryId", "Proprietary ID", base.DEC, NULL, 0xff)
local a = ProtoField.float("nmea-2000-130816.a", "A")
local b = ProtoField.float("nmea-2000-130816.b", "B")
local c = ProtoField.float("nmea-2000-130816.c", "C")
local sid = ProtoField.float("nmea-2000-130816.sid", "SID")
local prio = ProtoField.float("nmea-2000-130816.prio", "Prio")
local text = ProtoField.string("nmea-2000-130816.text", "Text")

NMEA_2000_130816.fields = {industryCode,proprietaryId,a,b,c,sid,prio,text}

function NMEA_2000_130816.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130816 (Simrad: Text Message)"
    local subtree = tree:add(NMEA_2000_130816, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
    subtree:add(proprietaryId, buffer(str_offset + 3, 1))
    subtree:add(a, buffer(str_offset + 4, 1), buffer(str_offset + 4, 1):le_uint() * 1)
    subtree:add(b, buffer(str_offset + 5, 1), buffer(str_offset + 5, 1):le_uint() * 1)
    subtree:add(c, buffer(str_offset + 6, 1), buffer(str_offset + 6, 1):le_uint() * 1)
    subtree:add(sid, buffer(str_offset + 7, 1), buffer(str_offset + 7, 1):le_uint() * 1)
    subtree:add(prio, buffer(str_offset + 8, 1), buffer(str_offset + 8, 1):le_uint() * 1)
    subtree:add(text, buffer(str_offset + 9, 32))
end

return NMEA_2000_130816
