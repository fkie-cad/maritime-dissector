-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129802 = Proto("nmea-2000-129802", "AIS Safety Related Broadcast Message (129802)")
local messageId = ProtoField.uint8("nmea-2000-129802.messageId", "Message ID", base.DEC, NULL, 0x3f)
local repeatIndicator = ProtoField.uint8("nmea-2000-129802.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local sourceId = ProtoField.uint32("nmea-2000-129802.sourceId", "Source ID")
local aisTransceiverInformation = ProtoField.uint8("nmea-2000-129802.aisTransceiverInformation", "AIS Transceiver information", base.DEC, NULL, 0x3e)
local safetyRelatedText = ProtoField.string("nmea-2000-129802.safetyRelatedText", "Safety Related Text")

NMEA_2000_129802.fields = {messageId,repeatIndicator,sourceId,aisTransceiverInformation,safetyRelatedText}

function NMEA_2000_129802.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129802 (AIS Safety Related Broadcast Message)"
    local subtree = tree:add(NMEA_2000_129802, buffer(), subtree_title)
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
    if buffer:len() >= (str_offset + 6 + 1) then
        length = buffer(str_offset + 6, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 6 + 2 + length) then
            -- type = buffer(str_offset + 6 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(safetyRelatedText, buffer(str_offset + 6 + 2, length))
            str_offset = str_offset + 6 + length + 2
        end
    end
end

return NMEA_2000_129802
