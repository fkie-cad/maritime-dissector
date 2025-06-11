-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129804 = Proto("nmea-2000-129804", "AIS Assignment Mode Command (129804)")
local messageId = ProtoField.uint8("nmea-2000-129804.messageId", "Message ID", base.DEC, NULL, 0x3f)
local repeatIndicator = ProtoField.uint8("nmea-2000-129804.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local sourceId = ProtoField.float("nmea-2000-129804.sourceId", "Source ID")
local aisTransceiverInformation = ProtoField.uint8("nmea-2000-129804.aisTransceiverInformation", "AIS Transceiver information", base.DEC, NULL, 0x3e)
local destinationIdA = ProtoField.float("nmea-2000-129804.destinationIdA", "Destination ID A")
local offsetA = ProtoField.float("nmea-2000-129804.offsetA", "Offset A")
local incrementA = ProtoField.float("nmea-2000-129804.incrementA", "Increment A")
local destinationIdB = ProtoField.float("nmea-2000-129804.destinationIdB", "Destination ID B")
local offsetB = ProtoField.float("nmea-2000-129804.offsetB", "Offset B")
local incrementB = ProtoField.float("nmea-2000-129804.incrementB", "Increment B")

NMEA_2000_129804.fields = {messageId,repeatIndicator,sourceId,aisTransceiverInformation,destinationIdA,offsetA,incrementA,destinationIdB,offsetB,incrementB}

function NMEA_2000_129804.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129804 (AIS Assignment Mode Command)"
    local subtree = tree:add(NMEA_2000_129804, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(messageId, buffer(str_offset + 0, 1))
    subtree:add(repeatIndicator, buffer(str_offset + 0, 1))
    subtree:add(sourceId, buffer(str_offset + 1, 4), buffer(str_offset + 1, 4):le_uint() * 1)
    subtree:add(aisTransceiverInformation, buffer(str_offset + 5, 1))
    subtree:add(destinationIdA, buffer(str_offset + 6, 4), buffer(str_offset + 6, 4):le_uint() * 1)
    subtree:add(offsetA, buffer(str_offset + 10, 2), buffer(str_offset + 10, 2):le_uint() * 1)
    subtree:add(incrementA, buffer(str_offset + 12, 2), buffer(str_offset + 12, 2):le_uint() * 1)
    subtree:add(destinationIdB, buffer(str_offset + 14, 4), buffer(str_offset + 14, 4):le_uint() * 1)
    subtree:add(offsetB, buffer(str_offset + 18, 2), buffer(str_offset + 18, 2):le_uint() * 1)
    subtree:add(incrementB, buffer(str_offset + 20, 2), buffer(str_offset + 20, 2):le_uint() * 1)
end

return NMEA_2000_129804
