-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130827 = Proto("nmea-2000-130827", "Lowrance: unknown (130827)")
local manufacturerCode = ProtoField.uint32("nmea-2000-130827.manufacturerCode", "Manufacturer Code")
local industryCode = ProtoField.uint8("nmea-2000-130827.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local a = ProtoField.uint8("nmea-2000-130827.a", "A")
local b = ProtoField.uint8("nmea-2000-130827.b", "B")
local c = ProtoField.uint8("nmea-2000-130827.c", "C")
local d = ProtoField.uint8("nmea-2000-130827.d", "D")
local e = ProtoField.uint16("nmea-2000-130827.e", "E")
local f = ProtoField.uint16("nmea-2000-130827.f", "F")

NMEA_2000_130827.fields = {manufacturerCode,industryCode,a,b,c,d,e,f}

function NMEA_2000_130827.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130827 (Lowrance: unknown)"
    local subtree = tree:add(NMEA_2000_130827, buffer(), subtree_title)
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
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(b, buffer(str_offset + 3, 1))
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        subtree:add(c, buffer(str_offset + 4, 1))
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        subtree:add(d, buffer(str_offset + 5, 1))
    end
    if buffer:len() >= (str_offset + 6 + 2) then
        subtree:add_le(e, buffer(str_offset + 6, 2))
    end
    if buffer:len() >= (str_offset + 8 + 2) then
        subtree:add_le(f, buffer(str_offset + 8, 2))
    end
end

return NMEA_2000_130827
