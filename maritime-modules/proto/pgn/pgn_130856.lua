-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130856 = Proto("nmea-2000-130856", "Simnet: Alarm Message (130856)")
local industryCode = ProtoField.uint8("nmea-2000-130856.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local messageId = ProtoField.float("nmea-2000-130856.messageId", "Message ID")
local b = ProtoField.float("nmea-2000-130856.b", "B")
local c = ProtoField.float("nmea-2000-130856.c", "C")
local text = ProtoField.string("nmea-2000-130856.text", "Text")

NMEA_2000_130856.fields = {industryCode,messageId,b,c,text}

function NMEA_2000_130856.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130856 (Simnet: Alarm Message)"
    local subtree = tree:add(NMEA_2000_130856, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
    subtree:add(messageId, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 1)
    subtree:add(b, buffer(str_offset + 4, 1), buffer(str_offset + 4, 1):le_uint() * 1)
    subtree:add(c, buffer(str_offset + 5, 1), buffer(str_offset + 5, 1):le_uint() * 1)
    subtree:add(text, buffer(str_offset + 6, 223))
end

return NMEA_2000_130856
