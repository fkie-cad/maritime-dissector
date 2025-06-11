-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129800 = Proto("nmea-2000-129800", "AIS UTC/Date Inquiry (129800)")
local messageId = ProtoField.uint8("nmea-2000-129800.messageId", "Message ID", base.DEC, NULL, 0x3f)
local repeatIndicator = ProtoField.uint8("nmea-2000-129800.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local sourceId = ProtoField.float("nmea-2000-129800.sourceId", "Source ID")
local aisTransceiverInformation = ProtoField.uint8("nmea-2000-129800.aisTransceiverInformation", "AIS Transceiver information", base.DEC, NULL, 0x3e)
local destinationId = ProtoField.float("nmea-2000-129800.destinationId", "Destination ID")

NMEA_2000_129800.fields = {messageId,repeatIndicator,sourceId,aisTransceiverInformation,destinationId}

function NMEA_2000_129800.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129800 (AIS UTC/Date Inquiry)"
    local subtree = tree:add(NMEA_2000_129800, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(messageId, buffer(str_offset + 0, 1))
    subtree:add(repeatIndicator, buffer(str_offset + 0, 1))
    subtree:add(sourceId, buffer(str_offset + 1, 4), buffer(str_offset + 1, 4):le_uint() * 1)
    subtree:add(aisTransceiverInformation, buffer(str_offset + 5, 1))
    subtree:add(destinationId, buffer(str_offset + 6, 4), buffer(str_offset + 6, 4):le_uint() * 1)
end

return NMEA_2000_129800
