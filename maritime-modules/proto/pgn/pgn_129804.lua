-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129804 = Proto("nmea-2000-129804", "AIS Assignment Mode Command (129804)")
local messageId = ProtoField.uint8("nmea-2000-129804.messageId", "Message ID", base.DEC, NULL, 0x3f)
local repeatIndicator = ProtoField.uint8("nmea-2000-129804.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local sourceId = ProtoField.uint32("nmea-2000-129804.sourceId", "Source ID")
local aisTransceiverInformation = ProtoField.uint8("nmea-2000-129804.aisTransceiverInformation", "AIS Transceiver information", base.DEC, NULL, 0x3e)
local destinationIdA = ProtoField.uint32("nmea-2000-129804.destinationIdA", "Destination ID A")
local offsetA = ProtoField.uint16("nmea-2000-129804.offsetA", "Offset A")
local incrementA = ProtoField.uint16("nmea-2000-129804.incrementA", "Increment A")
local destinationIdB = ProtoField.uint32("nmea-2000-129804.destinationIdB", "Destination ID B")
local offsetB = ProtoField.uint16("nmea-2000-129804.offsetB", "Offset B")
local incrementB = ProtoField.uint16("nmea-2000-129804.incrementB", "Increment B")

NMEA_2000_129804.fields = {messageId,repeatIndicator,sourceId,aisTransceiverInformation,destinationIdA,offsetA,incrementA,destinationIdB,offsetB,incrementB}

function NMEA_2000_129804.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129804 (AIS Assignment Mode Command)"
    local subtree = tree:add(NMEA_2000_129804, buffer(), subtree_title)
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
    if buffer:len() >= (str_offset + 6 + 4) then
        local destinationIdA_val = buffer(str_offset + 6, 4):le_uint()
        local _ti = subtree:add(destinationIdA, buffer(str_offset + 6, 4), destinationIdA_val)
        _ti:append_text(string.format(" (%09d)", destinationIdA_val))
    end
    if buffer:len() >= (str_offset + 10 + 2) then
        subtree:add_le(offsetA, buffer(str_offset + 10, 2))
    end
    if buffer:len() >= (str_offset + 12 + 2) then
        subtree:add_le(incrementA, buffer(str_offset + 12, 2))
    end
    if buffer:len() >= (str_offset + 14 + 4) then
        local destinationIdB_val = buffer(str_offset + 14, 4):le_uint()
        local _ti = subtree:add(destinationIdB, buffer(str_offset + 14, 4), destinationIdB_val)
        _ti:append_text(string.format(" (%09d)", destinationIdB_val))
    end
    if buffer:len() >= (str_offset + 18 + 2) then
        subtree:add_le(offsetB, buffer(str_offset + 18, 2))
    end
    if buffer:len() >= (str_offset + 20 + 2) then
        subtree:add_le(incrementB, buffer(str_offset + 20, 2))
    end
end

return NMEA_2000_129804
