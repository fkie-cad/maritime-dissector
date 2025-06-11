-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129801 = Proto("nmea-2000-129801", "AIS Addressed Safety Related Message (129801)")
local messageId = ProtoField.uint8("nmea-2000-129801.messageId", "Message ID", base.DEC, NULL, 0x3f)
local repeatIndicator = ProtoField.uint8("nmea-2000-129801.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local sourceId = ProtoField.float("nmea-2000-129801.sourceId", "Source ID")
local aisTransceiverInformation = ProtoField.uint8("nmea-2000-129801.aisTransceiverInformation", "AIS Transceiver information", base.DEC, NULL, 0x3e)
local destinationId = ProtoField.float("nmea-2000-129801.destinationId", "Destination ID")
local retransmitFlag = ProtoField.uint8("nmea-2000-129801.retransmitFlag", "Retransmit flag", base.DEC, NULL, 0x40)
local safetyRelatedText = ProtoField.string("nmea-2000-129801.safetyRelatedText", "Safety Related Text")

NMEA_2000_129801.fields = {messageId,repeatIndicator,sourceId,aisTransceiverInformation,destinationId,retransmitFlag,safetyRelatedText}

function NMEA_2000_129801.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129801 (AIS Addressed Safety Related Message)"
    local subtree = tree:add(NMEA_2000_129801, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(messageId, buffer(str_offset + 0, 1))
    subtree:add(repeatIndicator, buffer(str_offset + 0, 1))
    subtree:add(sourceId, buffer(str_offset + 1, 4), buffer(str_offset + 1, 4):le_uint() * 1)
    subtree:add(aisTransceiverInformation, buffer(str_offset + 5, 1))
    subtree:add(destinationId, buffer(str_offset + 6, 4), buffer(str_offset + 6, 4):le_uint() * 1)
    subtree:add(retransmitFlag, buffer(str_offset + 10, 1))
    length = buffer(str_offset + 11, 1):uint() - 2
    -- type = buffer(str_offset + 11 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(safetyRelatedText, buffer(str_offset + 11 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_129801
