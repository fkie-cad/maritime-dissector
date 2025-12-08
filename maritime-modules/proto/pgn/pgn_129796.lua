-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129796 = Proto("nmea-2000-129796", "AIS Acknowledge (129796)")
local messageId = ProtoField.uint8("nmea-2000-129796.messageId", "Message ID", base.DEC, NULL, 0x3f)
local repeatIndicator = ProtoField.uint8("nmea-2000-129796.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local sourceId = ProtoField.uint32("nmea-2000-129796.sourceId", "Source ID")
local aisTransceiverInformation = ProtoField.uint8("nmea-2000-129796.aisTransceiverInformation", "AIS Transceiver information", base.DEC, NULL, 0x3e)
local destinationId = ProtoField.uint32("nmea-2000-129796.destinationId", "Destination ID")
local sequenceNumber = ProtoField.uint32("nmea-2000-129796.sequenceNumber", "Sequence Number")

NMEA_2000_129796.fields = {messageId,repeatIndicator,sourceId,aisTransceiverInformation,destinationId,sequenceNumber}

function NMEA_2000_129796.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129796 (AIS Acknowledge)"
    local subtree = tree:add(NMEA_2000_129796, buffer(), subtree_title)
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
    local rem_1 = buffer:len() - (str_offset + 6)
    local count_1 = math.floor(rem_1 / 5)
    local rep_offset_1 = str_offset + 6
    for _i_1 = 1, count_1 do
    if rep_offset_1 + 5 > buffer:len() then break end
    do
        local _start = rep_offset_1 + 0
        if buffer:len() >= (_start + 4) then
            local _rng = buffer(_start, 4)
            local _raw = _rng:le_uint()
            local _val = _raw
            subtree:add(destinationId, _rng, _val)
        end
    end
    do
        local _start = rep_offset_1 + 4
        if buffer:len() >= (_start + 1) then
            local _rng = buffer(_start, 1)
            local _raw = _rng:uint()
            local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 2)
            subtree:add(sequenceNumber, _rng, _val)
        end
    end
    rep_offset_1 = rep_offset_1 + 5
    end
end

return NMEA_2000_129796
