-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130821 = Proto("nmea-2000-130821", "Furuno: Unknown 130821 (130821)")
local manufacturerCode = ProtoField.uint32("nmea-2000-130821.manufacturerCode", "Manufacturer Code")
local industryCode = ProtoField.uint8("nmea-2000-130821.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local sid = ProtoField.uint8("nmea-2000-130821.sid", "SID")
local a = ProtoField.uint8("nmea-2000-130821.a", "A")
local b = ProtoField.uint8("nmea-2000-130821.b", "B")
local c = ProtoField.uint8("nmea-2000-130821.c", "C")
local d = ProtoField.uint8("nmea-2000-130821.d", "D")
local e = ProtoField.uint8("nmea-2000-130821.e", "E")
local f = ProtoField.uint8("nmea-2000-130821.f", "F")
local g = ProtoField.uint8("nmea-2000-130821.g", "G")
local h = ProtoField.uint8("nmea-2000-130821.h", "H")
local i = ProtoField.uint8("nmea-2000-130821.i", "I")

NMEA_2000_130821.fields = {manufacturerCode,industryCode,sid,a,b,c,d,e,f,g,h,i}

function NMEA_2000_130821.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130821 (Furuno: Unknown 130821)"
    local subtree = tree:add(NMEA_2000_130821, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 2) then
        local _rng = buffer(str_offset, 2)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 11)
        subtree:add(manufacturerCode, _rng, _val)
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(industryCode, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(sid, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(a, buffer(str_offset + 3, 1))
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        subtree:add(b, buffer(str_offset + 4, 1))
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        subtree:add(c, buffer(str_offset + 5, 1))
    end
    if buffer:len() >= (str_offset + 6 + 1) then
        subtree:add(d, buffer(str_offset + 6, 1))
    end
    if buffer:len() >= (str_offset + 7 + 1) then
        subtree:add(e, buffer(str_offset + 7, 1))
    end
    if buffer:len() >= (str_offset + 8 + 1) then
        subtree:add(f, buffer(str_offset + 8, 1))
    end
    if buffer:len() >= (str_offset + 9 + 1) then
        subtree:add(g, buffer(str_offset + 9, 1))
    end
    if buffer:len() >= (str_offset + 10 + 1) then
        subtree:add(h, buffer(str_offset + 10, 1))
    end
    if buffer:len() >= (str_offset + 11 + 1) then
        subtree:add(i, buffer(str_offset + 11, 1))
    end
end

return NMEA_2000_130821
