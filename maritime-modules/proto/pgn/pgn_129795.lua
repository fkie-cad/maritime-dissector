-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129795 = Proto("nmea-2000-129795", "AIS Addressed Binary Message (129795)")
local messageId = ProtoField.uint8("nmea-2000-129795.messageId", "Message ID", base.DEC, NULL, 0x3f)
local repeatIndicator = ProtoField.uint8("nmea-2000-129795.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local sourceId = ProtoField.uint32("nmea-2000-129795.sourceId", "Source ID")
local aisTransceiverInformation = ProtoField.uint8("nmea-2000-129795.aisTransceiverInformation", "AIS Transceiver information", base.DEC, NULL, 0x3e)
local sequenceNumber = ProtoField.uint32("nmea-2000-129795.sequenceNumber", "Sequence Number")
local destinationId = ProtoField.uint32("nmea-2000-129795.destinationId", "Destination ID")
local retransmitFlag = ProtoField.uint8("nmea-2000-129795.retransmitFlag", "Retransmit flag", base.DEC, NULL, 0x40)
local numberOfBitsInBinaryDataField = ProtoField.uint16("nmea-2000-129795.numberOfBitsInBinaryDataField", "Number of Bits in Binary Data Field")
local binaryData = ProtoField.bytes("nmea-2000-129795.binaryData", "Binary Data")

NMEA_2000_129795.fields = {messageId,repeatIndicator,sourceId,aisTransceiverInformation,sequenceNumber,destinationId,retransmitFlag,numberOfBitsInBinaryDataField,binaryData}

function NMEA_2000_129795.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129795 (AIS Addressed Binary Message)"
    local subtree = tree:add(NMEA_2000_129795, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(messageId, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(repeatIndicator, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 4) then
        local sourceId_val = buffer(str_offset + 1, 4):le_uint()
        local _ti = subtree:add(sourceId, buffer(str_offset + 1, 4), sourceId_val)
        _ti:append_text(string.format(" (%09d)", sourceId_val))
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        subtree:add(aisTransceiverInformation, buffer(str_offset + 5, 1))
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        local _rng = buffer(str_offset + 5, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 6)) % (2 ^ 2)
        subtree:add(sequenceNumber, _rng, _val)
    end
    if buffer:len() >= (str_offset + 6 + 4) then
        local destinationId_val = buffer(str_offset + 6, 4):le_uint()
        local _ti = subtree:add(destinationId, buffer(str_offset + 6, 4), destinationId_val)
        _ti:append_text(string.format(" (%09d)", destinationId_val))
    end
    if buffer:len() >= (str_offset + 10 + 1) then
        subtree:add(retransmitFlag, buffer(str_offset + 10, 1))
    end
    if buffer:len() >= (str_offset + 11 + 2) then
        subtree:add_le(numberOfBitsInBinaryDataField, buffer(str_offset + 11, 2))
    end
    local _rem = buffer:len() - str_offset
    if _rem > 0 then
        subtree:add(binaryData, buffer(str_offset, _rem))
        str_offset = str_offset + _rem
    end
end

return NMEA_2000_129795
