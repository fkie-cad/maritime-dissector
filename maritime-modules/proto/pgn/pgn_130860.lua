-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130860 = Proto("nmea-2000-130860", "Simnet: AP Unknown 4 (130860)")
local manufacturerCode = ProtoField.uint32("nmea-2000-130860.manufacturerCode", "Manufacturer Code")
local industryCode = ProtoField.uint8("nmea-2000-130860.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local a = ProtoField.uint8("nmea-2000-130860.a", "A")
local b = ProtoField.int32("nmea-2000-130860.b", "B")
local c = ProtoField.int32("nmea-2000-130860.c", "C")
local d = ProtoField.uint32("nmea-2000-130860.d", "D")
local e = ProtoField.int32("nmea-2000-130860.e", "E")
local f = ProtoField.uint32("nmea-2000-130860.f", "F")

NMEA_2000_130860.fields = {manufacturerCode,industryCode,a,b,c,d,e,f}

function NMEA_2000_130860.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130860 (Simnet: AP Unknown 4)"
    local subtree = tree:add(NMEA_2000_130860, buffer(), subtree_title)
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
        subtree:add(a, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 3 + 4) then
        subtree:add_le(b, buffer(str_offset + 3, 4))
    end
    if buffer:len() >= (str_offset + 7 + 4) then
        subtree:add_le(c, buffer(str_offset + 7, 4))
    end
    if buffer:len() >= (str_offset + 11 + 4) then
        subtree:add_le(d, buffer(str_offset + 11, 4))
    end
    if buffer:len() >= (str_offset + 15 + 4) then
        subtree:add_le(e, buffer(str_offset + 15, 4))
    end
    if buffer:len() >= (str_offset + 19 + 4) then
        subtree:add_le(f, buffer(str_offset + 19, 4))
    end
end

return NMEA_2000_130860
