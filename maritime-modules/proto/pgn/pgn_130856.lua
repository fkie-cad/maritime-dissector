-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130856 = Proto("nmea-2000-130856", "Simnet: Alarm Message (130856)")
local manufacturerCode = ProtoField.uint32("nmea-2000-130856.manufacturerCode", "Manufacturer Code")
local industryCode = ProtoField.uint8("nmea-2000-130856.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local messageId = ProtoField.uint16("nmea-2000-130856.messageId", "Message ID")
local b = ProtoField.uint8("nmea-2000-130856.b", "B")
local c = ProtoField.uint8("nmea-2000-130856.c", "C")
local text = ProtoField.string("nmea-2000-130856.text", "Text")

NMEA_2000_130856.fields = {manufacturerCode,industryCode,messageId,b,c,text}

function NMEA_2000_130856.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130856 (Simnet: Alarm Message)"
    local subtree = tree:add(NMEA_2000_130856, buffer(), subtree_title)
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
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add_le(messageId, buffer(str_offset + 2, 2))
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        subtree:add(b, buffer(str_offset + 4, 1))
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        subtree:add(c, buffer(str_offset + 5, 1))
    end
    if buffer:len() >= (str_offset + 6 + 223) then
        local _text_raw = buffer(str_offset + 6, 223):string()
        local _text_clean = _text_raw:gsub("[%s@%z\xff]+$", "")
        subtree:add(text, buffer(str_offset + 6, 223), _text_clean)
    end
end

return NMEA_2000_130856
