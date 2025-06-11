-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129793 = Proto("nmea-2000-129793", "AIS UTC and Date Report (129793)")
local messageId = ProtoField.uint8("nmea-2000-129793.messageId", "Message ID", base.DEC, NULL, 0x3f)
local repeatIndicator = ProtoField.uint8("nmea-2000-129793.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local userId = ProtoField.float("nmea-2000-129793.userId", "User ID")
local longitude = ProtoField.float("nmea-2000-129793.longitude", "Longitude (deg)")
local latitude = ProtoField.float("nmea-2000-129793.latitude", "Latitude (deg)")
local positionAccuracy = ProtoField.uint8("nmea-2000-129793.positionAccuracy", "Position Accuracy", base.DEC, NULL, 0x1)
local raim = ProtoField.uint8("nmea-2000-129793.raim", "RAIM", base.DEC, NULL, 0x2)
local positionTime = ProtoField.float("nmea-2000-129793.positionTime", "Position Time (s)")
local aisTransceiverInformation = ProtoField.uint8("nmea-2000-129793.aisTransceiverInformation", "AIS Transceiver information", base.DEC, NULL, 0xf8)
local positionDate = ProtoField.float("nmea-2000-129793.positionDate", "Position Date (d)")
local gnssType = ProtoField.uint8("nmea-2000-129793.gnssType", "GNSS type", base.DEC, NULL, 0xf0)

NMEA_2000_129793.fields = {messageId,repeatIndicator,userId,longitude,latitude,positionAccuracy,raim,positionTime,aisTransceiverInformation,positionDate,gnssType}

function NMEA_2000_129793.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129793 (AIS UTC and Date Report)"
    local subtree = tree:add(NMEA_2000_129793, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(messageId, buffer(str_offset + 0, 1))
    subtree:add(repeatIndicator, buffer(str_offset + 0, 1))
    subtree:add(userId, buffer(str_offset + 1, 4), buffer(str_offset + 1, 4):le_uint() * 1)
    subtree:add(longitude, buffer(str_offset + 5, 4), buffer(str_offset + 5, 4):le_int() * 1e-07)
    subtree:add(latitude, buffer(str_offset + 9, 4), buffer(str_offset + 9, 4):le_int() * 1e-07)
    subtree:add(positionAccuracy, buffer(str_offset + 13, 1))
    subtree:add(raim, buffer(str_offset + 13, 1))
    subtree:add(positionTime, buffer(str_offset + 14, 4), buffer(str_offset + 14, 4):le_uint() * 0.0001)
    subtree:add(aisTransceiverInformation, buffer(str_offset + 20, 1))
    subtree:add(positionDate, buffer(str_offset + 21, 2), buffer(str_offset + 21, 2):le_uint() * 1)
    subtree:add(gnssType, buffer(str_offset + 23, 1))
end

return NMEA_2000_129793
