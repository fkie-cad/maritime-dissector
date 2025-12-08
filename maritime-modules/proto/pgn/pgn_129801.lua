-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129801 = Proto("nmea-2000-129801", "AIS Addressed Safety Related Message (129801)")
local messageId = ProtoField.uint8("nmea-2000-129801.messageId", "Message ID", base.DEC, NULL, 0x3f)
local repeatIndicator = ProtoField.uint8("nmea-2000-129801.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local sourceId = ProtoField.uint32("nmea-2000-129801.sourceId", "Source ID")
local aisTransceiverInformation = ProtoField.uint8("nmea-2000-129801.aisTransceiverInformation", "AIS Transceiver information", base.DEC, NULL, 0x3e)
local sequenceNumber = ProtoField.uint32("nmea-2000-129801.sequenceNumber", "Sequence Number")
local destinationId = ProtoField.uint32("nmea-2000-129801.destinationId", "Destination ID")
local retransmitFlag = ProtoField.uint8("nmea-2000-129801.retransmitFlag", "Retransmit flag", base.DEC, NULL, 0x40)
local safetyRelatedText = ProtoField.string("nmea-2000-129801.safetyRelatedText", "Safety Related Text")

NMEA_2000_129801.fields = {messageId,repeatIndicator,sourceId,aisTransceiverInformation,sequenceNumber,destinationId,retransmitFlag,safetyRelatedText}

function NMEA_2000_129801.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129801 (AIS Addressed Safety Related Message)"
    local subtree = tree:add(NMEA_2000_129801, buffer(), subtree_title)
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
    if buffer:len() >= (str_offset + 11 + 1) then
        length = buffer(str_offset + 11, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 11 + 2 + length) then
            -- type = buffer(str_offset + 11 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(safetyRelatedText, buffer(str_offset + 11 + 2, length))
            str_offset = str_offset + 11 + length + 2
        end
    end
end

return NMEA_2000_129801
