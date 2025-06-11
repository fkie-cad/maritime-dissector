-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129792 = Proto("nmea-2000-129792", "AIS DGNSS Broadcast Binary Message (129792)")
local messageId = ProtoField.uint8("nmea-2000-129792.messageId", "Message ID", base.DEC, NULL, 0x3f)
local sourceId = ProtoField.float("nmea-2000-129792.sourceId", "Source ID")
local aisTransceiverInformation = ProtoField.uint8("nmea-2000-129792.aisTransceiverInformation", "AIS Transceiver information", base.DEC, NULL, 0x3e)
local longitude = ProtoField.float("nmea-2000-129792.longitude", "Longitude (deg)")
local latitude = ProtoField.float("nmea-2000-129792.latitude", "Latitude (deg)")
local numberOfBitsInBinaryDataField = ProtoField.float("nmea-2000-129792.numberOfBitsInBinaryDataField", "Number of Bits in Binary Data Field")

NMEA_2000_129792.fields = {messageId,sourceId,aisTransceiverInformation,longitude,latitude,numberOfBitsInBinaryDataField}

function NMEA_2000_129792.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129792 (AIS DGNSS Broadcast Binary Message)"
    local subtree = tree:add(NMEA_2000_129792, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(messageId, buffer(str_offset + 0, 1))
    subtree:add(sourceId, buffer(str_offset + 1, 4), buffer(str_offset + 1, 4):le_uint() * 1)
    subtree:add(aisTransceiverInformation, buffer(str_offset + 5, 1))
    subtree:add(longitude, buffer(str_offset + 6, 4), buffer(str_offset + 6, 4):le_int() * 1e-07)
    subtree:add(latitude, buffer(str_offset + 10, 4), buffer(str_offset + 10, 4):le_int() * 1e-07)
    subtree:add(numberOfBitsInBinaryDataField, buffer(str_offset + 15, 2), buffer(str_offset + 15, 2):le_uint() * 1)
end

return NMEA_2000_129792
