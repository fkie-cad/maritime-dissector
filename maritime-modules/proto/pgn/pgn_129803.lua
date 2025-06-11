-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129803 = Proto("nmea-2000-129803", "AIS Interrogation (129803)")
local messageId = ProtoField.uint8("nmea-2000-129803.messageId", "Message ID", base.DEC, NULL, 0x3f)
local repeatIndicator = ProtoField.uint8("nmea-2000-129803.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local sourceId = ProtoField.float("nmea-2000-129803.sourceId", "Source ID")
local aisTransceiverInformation = ProtoField.uint8("nmea-2000-129803.aisTransceiverInformation", "AIS Transceiver information", base.DEC, NULL, 0x3e)
local destinationId1 = ProtoField.float("nmea-2000-129803.destinationId1", "Destination ID 1")
local messageId11 = ProtoField.uint8("nmea-2000-129803.messageId11", "Message ID 1.1", base.DEC, NULL, 0xfc)
local slotOffset11 = ProtoField.float("nmea-2000-129803.slotOffset11", "Slot Offset 1.1")
local messageId12 = ProtoField.uint8("nmea-2000-129803.messageId12", "Message ID 1.2", base.DEC, NULL, 0xfc)
local slotOffset12 = ProtoField.float("nmea-2000-129803.slotOffset12", "Slot Offset 1.2")
local destinationId2 = ProtoField.float("nmea-2000-129803.destinationId2", "Destination ID 2")
local messageId21 = ProtoField.uint8("nmea-2000-129803.messageId21", "Message ID 2.1", base.DEC, NULL, 0xfc)
local slotOffset21 = ProtoField.float("nmea-2000-129803.slotOffset21", "Slot Offset 2.1")
local sid = ProtoField.float("nmea-2000-129803.sid", "SID")

NMEA_2000_129803.fields = {messageId,repeatIndicator,sourceId,aisTransceiverInformation,destinationId1,messageId11,slotOffset11,messageId12,slotOffset12,destinationId2,messageId21,slotOffset21,sid}

function NMEA_2000_129803.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129803 (AIS Interrogation)"
    local subtree = tree:add(NMEA_2000_129803, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(messageId, buffer(str_offset + 0, 1))
    subtree:add(repeatIndicator, buffer(str_offset + 0, 1))
    subtree:add(sourceId, buffer(str_offset + 1, 4), buffer(str_offset + 1, 4):le_uint() * 1)
    subtree:add(aisTransceiverInformation, buffer(str_offset + 5, 1))
    subtree:add(destinationId1, buffer(str_offset + 6, 4), buffer(str_offset + 6, 4):le_uint() * 1)
    subtree:add(messageId11, buffer(str_offset + 10, 1))
    subtree:add(slotOffset11, buffer(str_offset + 11, 2), buffer(str_offset + 11, 2):le_uint() * 1)
    subtree:add(messageId12, buffer(str_offset + 13, 1))
    subtree:add(slotOffset12, buffer(str_offset + 14, 2), buffer(str_offset + 14, 2):le_uint() * 1)
    subtree:add(destinationId2, buffer(str_offset + 17, 4), buffer(str_offset + 17, 4):le_uint() * 1)
    subtree:add(messageId21, buffer(str_offset + 21, 1))
    subtree:add(slotOffset21, buffer(str_offset + 22, 2), buffer(str_offset + 22, 2):le_uint() * 1)
    subtree:add(sid, buffer(str_offset + 25, 1), buffer(str_offset + 25, 1):le_uint() * 1)
end

return NMEA_2000_129803
