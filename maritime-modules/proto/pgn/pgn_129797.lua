-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129797 = Proto("nmea-2000-129797", "AIS Binary Broadcast Message (129797)")
local messageId = ProtoField.uint8("nmea-2000-129797.messageId", "Message ID", base.DEC, NULL, 0x3f)
local repeatIndicator = ProtoField.uint8("nmea-2000-129797.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local sourceId = ProtoField.uint32("nmea-2000-129797.sourceId", "Source ID")
local aisTransceiverInformation = ProtoField.uint8("nmea-2000-129797.aisTransceiverInformation", "AIS Transceiver information", base.DEC, NULL, 0x3e)
local numberOfBitsInBinaryDataField = ProtoField.uint16("nmea-2000-129797.numberOfBitsInBinaryDataField", "Number of Bits in Binary Data Field")
local binaryData = ProtoField.bytes("nmea-2000-129797.binaryData", "Binary Data")

NMEA_2000_129797.fields = {messageId,repeatIndicator,sourceId,aisTransceiverInformation,numberOfBitsInBinaryDataField,binaryData}

function NMEA_2000_129797.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129797 (AIS Binary Broadcast Message)"
    local subtree = tree:add(NMEA_2000_129797, buffer(), subtree_title)
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
    if buffer:len() >= (str_offset + 6 + 2) then
        subtree:add_le(numberOfBitsInBinaryDataField, buffer(str_offset + 6, 2))
    end
    local _rem = buffer:len() - str_offset
    if _rem > 0 then
        subtree:add(binaryData, buffer(str_offset, _rem))
        str_offset = str_offset + _rem
    end
end

return NMEA_2000_129797
