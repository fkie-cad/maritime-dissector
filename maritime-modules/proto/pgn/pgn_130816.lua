-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130816 = Proto("nmea-2000-130816", "Simrad: Text Message (130816)")
local manufacturerCode = ProtoField.uint32("nmea-2000-130816.manufacturerCode", "Manufacturer Code")
local industryCode = ProtoField.uint8("nmea-2000-130816.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local proprietaryId = ProtoField.uint8("nmea-2000-130816.proprietaryId", "Proprietary ID", base.DEC, NULL, 0xff)
local a = ProtoField.uint8("nmea-2000-130816.a", "A")
local b = ProtoField.uint8("nmea-2000-130816.b", "B")
local c = ProtoField.uint8("nmea-2000-130816.c", "C")
local sid = ProtoField.uint8("nmea-2000-130816.sid", "SID")
local prio = ProtoField.uint8("nmea-2000-130816.prio", "Prio")
local text = ProtoField.string("nmea-2000-130816.text", "Text")

NMEA_2000_130816.fields = {manufacturerCode,industryCode,proprietaryId,a,b,c,sid,prio,text}

function NMEA_2000_130816.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130816 (Simrad: Text Message)"
    local subtree = tree:add(NMEA_2000_130816, buffer(), subtree_title)
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
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(proprietaryId, buffer(str_offset + 3, 1))
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        subtree:add(a, buffer(str_offset + 4, 1))
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        subtree:add(b, buffer(str_offset + 5, 1))
    end
    if buffer:len() >= (str_offset + 6 + 1) then
        subtree:add(c, buffer(str_offset + 6, 1))
    end
    if buffer:len() >= (str_offset + 7 + 1) then
        subtree:add(sid, buffer(str_offset + 7, 1))
    end
    if buffer:len() >= (str_offset + 8 + 1) then
        subtree:add(prio, buffer(str_offset + 8, 1))
    end
    if buffer:len() >= (str_offset + 9 + 32) then
        local _text_raw = buffer(str_offset + 9, 32):string()
        local _text_clean = _text_raw:gsub("[%s@%z\xff]+$", "")
        subtree:add(text, buffer(str_offset + 9, 32), _text_clean)
    end
end

return NMEA_2000_130816
