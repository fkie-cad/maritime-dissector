-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129792 = Proto("nmea-2000-129792", "AIS DGNSS Broadcast Binary Message (129792)")
local messageId = ProtoField.uint8("nmea-2000-129792.messageId", "Message ID", base.DEC, NULL, 0x3f)
local repeatIndicator = ProtoField.uint32("nmea-2000-129792.repeatIndicator", "Repeat Indicator")
local sourceId = ProtoField.uint32("nmea-2000-129792.sourceId", "Source ID")
local aisTransceiverInformation = ProtoField.uint8("nmea-2000-129792.aisTransceiverInformation", "AIS Transceiver information", base.DEC, NULL, 0x3e)
local longitude = ProtoField.float("nmea-2000-129792.longitude", "Longitude (deg)")
local latitude = ProtoField.float("nmea-2000-129792.latitude", "Latitude (deg)")
local numberOfBitsInBinaryDataField = ProtoField.uint16("nmea-2000-129792.numberOfBitsInBinaryDataField", "Number of Bits in Binary Data Field")
local binaryData = ProtoField.bytes("nmea-2000-129792.binaryData", "Binary Data")

NMEA_2000_129792.fields = {messageId,repeatIndicator,sourceId,aisTransceiverInformation,longitude,latitude,numberOfBitsInBinaryDataField,binaryData}

function NMEA_2000_129792.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129792 (AIS DGNSS Broadcast Binary Message)"
    local subtree = tree:add(NMEA_2000_129792, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(messageId, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1) then
        local _rng = buffer(str_offset, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 6)) % (2 ^ 2)
        subtree:add(repeatIndicator, _rng, _val)
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
        subtree:add(longitude, buffer(str_offset + 6, 4), buffer(str_offset + 6, 4):le_int() * 1e-07)
    end
    if buffer:len() >= (str_offset + 10 + 4) then
        subtree:add(latitude, buffer(str_offset + 10, 4), buffer(str_offset + 10, 4):le_int() * 1e-07)
    end
    if buffer:len() >= (str_offset + 15 + 2) then
        subtree:add_le(numberOfBitsInBinaryDataField, buffer(str_offset + 15, 2))
    end
    local _rem = buffer:len() - str_offset
    if _rem > 0 then
        subtree:add(binaryData, buffer(str_offset, _rem))
        str_offset = str_offset + _rem
    end
end

return NMEA_2000_129792
