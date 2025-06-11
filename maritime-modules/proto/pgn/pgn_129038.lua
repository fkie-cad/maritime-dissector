-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129038 = Proto("nmea-2000-129038", "AIS Class A Position Report (129038)")
local messageId = ProtoField.uint8("nmea-2000-129038.messageId", "Message ID", base.DEC, NULL, 0x3f)
local repeatIndicator = ProtoField.uint8("nmea-2000-129038.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local userId = ProtoField.float("nmea-2000-129038.userId", "User ID")
local longitude = ProtoField.float("nmea-2000-129038.longitude", "Longitude (deg)")
local latitude = ProtoField.float("nmea-2000-129038.latitude", "Latitude (deg)")
local positionAccuracy = ProtoField.uint8("nmea-2000-129038.positionAccuracy", "Position Accuracy", base.DEC, NULL, 0x1)
local raim = ProtoField.uint8("nmea-2000-129038.raim", "RAIM", base.DEC, NULL, 0x2)
local timeStamp = ProtoField.uint8("nmea-2000-129038.timeStamp", "Time Stamp", base.DEC, NULL, 0xfc)
local cog = ProtoField.float("nmea-2000-129038.cog", "COG (rad)")
local sog = ProtoField.float("nmea-2000-129038.sog", "SOG (m/s)")
local aisTransceiverInformation = ProtoField.uint8("nmea-2000-129038.aisTransceiverInformation", "AIS Transceiver information", base.DEC, NULL, 0xf8)
local heading = ProtoField.float("nmea-2000-129038.heading", "Heading (rad)")
local rateOfTurn = ProtoField.float("nmea-2000-129038.rateOfTurn", "Rate of Turn (rad/s)")
local navStatus = ProtoField.uint8("nmea-2000-129038.navStatus", "Nav Status", base.DEC, NULL, 0xf)
local specialManeuverIndicator = ProtoField.uint8("nmea-2000-129038.specialManeuverIndicator", "Special Maneuver Indicator", base.DEC, NULL, 0x30)
local sequenceId = ProtoField.float("nmea-2000-129038.sequenceId", "Sequence ID")

NMEA_2000_129038.fields = {messageId,repeatIndicator,userId,longitude,latitude,positionAccuracy,raim,timeStamp,cog,sog,aisTransceiverInformation,heading,rateOfTurn,navStatus,specialManeuverIndicator,sequenceId}

function NMEA_2000_129038.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129038 (AIS Class A Position Report)"
    local subtree = tree:add(NMEA_2000_129038, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(messageId, buffer(str_offset + 0, 1))
    subtree:add(repeatIndicator, buffer(str_offset + 0, 1))
    subtree:add(userId, buffer(str_offset + 1, 4), buffer(str_offset + 1, 4):le_uint() * 1)
    subtree:add(longitude, buffer(str_offset + 5, 4), buffer(str_offset + 5, 4):le_int() * 1e-07)
    subtree:add(latitude, buffer(str_offset + 9, 4), buffer(str_offset + 9, 4):le_int() * 1e-07)
    subtree:add(positionAccuracy, buffer(str_offset + 13, 1))
    subtree:add(raim, buffer(str_offset + 13, 1))
    subtree:add(timeStamp, buffer(str_offset + 13, 1))
    subtree:add(cog, buffer(str_offset + 14, 2), buffer(str_offset + 14, 2):le_uint() * 0.0001)
    subtree:add(sog, buffer(str_offset + 16, 2), buffer(str_offset + 16, 2):le_uint() * 0.01)
    subtree:add(aisTransceiverInformation, buffer(str_offset + 20, 1))
    subtree:add(heading, buffer(str_offset + 21, 2), buffer(str_offset + 21, 2):le_uint() * 0.0001)
    subtree:add(rateOfTurn, buffer(str_offset + 23, 2), buffer(str_offset + 23, 2):le_int() * 3.125e-05)
    subtree:add(navStatus, buffer(str_offset + 25, 1))
    subtree:add(specialManeuverIndicator, buffer(str_offset + 25, 1))
    subtree:add(sequenceId, buffer(str_offset + 27, 1), buffer(str_offset + 27, 1):le_uint() * 1)
end

return NMEA_2000_129038
