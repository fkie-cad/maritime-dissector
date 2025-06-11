-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129797 = Proto("nmea-2000-129797", "AIS Binary Broadcast Message (129797)")
local messageId = ProtoField.uint8("nmea-2000-129797.messageId", "Message ID", base.DEC, NULL, 0x3f)
local repeatIndicator = ProtoField.uint8("nmea-2000-129797.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local sourceId = ProtoField.float("nmea-2000-129797.sourceId", "Source ID")
local aisTransceiverInformation = ProtoField.uint8("nmea-2000-129797.aisTransceiverInformation", "AIS Transceiver information", base.DEC, NULL, 0x3e)
local numberOfBitsInBinaryDataField = ProtoField.float("nmea-2000-129797.numberOfBitsInBinaryDataField", "Number of Bits in Binary Data Field")

NMEA_2000_129797.fields = {messageId,repeatIndicator,sourceId,aisTransceiverInformation,numberOfBitsInBinaryDataField}

function NMEA_2000_129797.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129797 (AIS Binary Broadcast Message)"
    local subtree = tree:add(NMEA_2000_129797, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(messageId, buffer(str_offset + 0, 1))
    subtree:add(repeatIndicator, buffer(str_offset + 0, 1))
    subtree:add(sourceId, buffer(str_offset + 1, 4), buffer(str_offset + 1, 4):le_uint() * 1)
    subtree:add(aisTransceiverInformation, buffer(str_offset + 5, 1))
    subtree:add(numberOfBitsInBinaryDataField, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 1)
end

return NMEA_2000_129797
