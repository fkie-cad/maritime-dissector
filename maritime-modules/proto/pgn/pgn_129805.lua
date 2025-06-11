-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129805 = Proto("nmea-2000-129805", "AIS Data Link Management Message (129805)")
local messageId = ProtoField.uint8("nmea-2000-129805.messageId", "Message ID", base.DEC, NULL, 0x3f)
local repeatIndicator = ProtoField.uint8("nmea-2000-129805.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local sourceId = ProtoField.float("nmea-2000-129805.sourceId", "Source ID")
local aisTransceiverInformation = ProtoField.uint8("nmea-2000-129805.aisTransceiverInformation", "AIS Transceiver information", base.DEC, NULL, 0x3e)
local offset = ProtoField.float("nmea-2000-129805.offset", "Offset")
local numberOfSlots = ProtoField.float("nmea-2000-129805.numberOfSlots", "Number of Slots")
local timeout = ProtoField.float("nmea-2000-129805.timeout", "Timeout (s)")
local increment = ProtoField.float("nmea-2000-129805.increment", "Increment")

NMEA_2000_129805.fields = {messageId,repeatIndicator,sourceId,aisTransceiverInformation,offset,numberOfSlots,timeout,increment}

function NMEA_2000_129805.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129805 (AIS Data Link Management Message)"
    local subtree = tree:add(NMEA_2000_129805, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(messageId, buffer(str_offset + 0, 1))
    subtree:add(repeatIndicator, buffer(str_offset + 0, 1))
    subtree:add(sourceId, buffer(str_offset + 1, 4), buffer(str_offset + 1, 4):le_uint() * 1)
    subtree:add(aisTransceiverInformation, buffer(str_offset + 5, 1))
    subtree:add(offset, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 1)
    subtree:add(numberOfSlots, buffer(str_offset + 8, 1), buffer(str_offset + 8, 1):le_uint() * 1)
    subtree:add(timeout, buffer(str_offset + 9, 1), buffer(str_offset + 9, 1):le_uint() * 60)
    subtree:add(increment, buffer(str_offset + 10, 2), buffer(str_offset + 10, 2):le_uint() * 1)
end

return NMEA_2000_129805
