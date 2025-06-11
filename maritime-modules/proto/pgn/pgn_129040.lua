-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129040 = Proto("nmea-2000-129040", "AIS Class B Extended Position Report (129040)")
local messageId = ProtoField.uint8("nmea-2000-129040.messageId", "Message ID", base.DEC, NULL, 0x3f)
local repeatIndicator = ProtoField.uint8("nmea-2000-129040.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local userId = ProtoField.float("nmea-2000-129040.userId", "User ID")
local longitude = ProtoField.float("nmea-2000-129040.longitude", "Longitude (deg)")
local latitude = ProtoField.float("nmea-2000-129040.latitude", "Latitude (deg)")
local positionAccuracy = ProtoField.uint8("nmea-2000-129040.positionAccuracy", "Position Accuracy", base.DEC, NULL, 0x1)
local raim = ProtoField.uint8("nmea-2000-129040.raim", "RAIM", base.DEC, NULL, 0x2)
local timeStamp = ProtoField.uint8("nmea-2000-129040.timeStamp", "Time Stamp", base.DEC, NULL, 0xfc)
local cog = ProtoField.float("nmea-2000-129040.cog", "COG (rad)")
local sog = ProtoField.float("nmea-2000-129040.sog", "SOG (m/s)")
local typeOfShip = ProtoField.uint8("nmea-2000-129040.typeOfShip", "Type of ship", base.DEC, NULL, 0xff)
local trueHeading = ProtoField.float("nmea-2000-129040.trueHeading", "True Heading (rad)")
local gnssType = ProtoField.uint8("nmea-2000-129040.gnssType", "GNSS type", base.DEC, NULL, 0xf0)
local length = ProtoField.float("nmea-2000-129040.length", "Length (m)")
local beam = ProtoField.float("nmea-2000-129040.beam", "Beam (m)")
local positionReferenceFromStarboard = ProtoField.float("nmea-2000-129040.positionReferenceFromStarboard", "Position reference from Starboard (m)")
local positionReferenceFromBow = ProtoField.float("nmea-2000-129040.positionReferenceFromBow", "Position reference from Bow (m)")
local name = ProtoField.string("nmea-2000-129040.name", "Name")
local dte = ProtoField.uint8("nmea-2000-129040.dte", "DTE", base.DEC, NULL, 0x1)
local aisMode = ProtoField.uint8("nmea-2000-129040.aisMode", "AIS mode", base.DEC, NULL, 0x2)
local aisTransceiverInformation = ProtoField.uint8("nmea-2000-129040.aisTransceiverInformation", "AIS Transceiver information", base.DEC, NULL, 0x7c0)

NMEA_2000_129040.fields = {messageId,repeatIndicator,userId,longitude,latitude,positionAccuracy,raim,timeStamp,cog,sog,typeOfShip,trueHeading,gnssType,length,beam,positionReferenceFromStarboard,positionReferenceFromBow,name,dte,aisMode,aisTransceiverInformation}

function NMEA_2000_129040.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129040 (AIS Class B Extended Position Report)"
    local subtree = tree:add(NMEA_2000_129040, buffer(), subtree_title)
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
    subtree:add(typeOfShip, buffer(str_offset + 20, 1))
    subtree:add(trueHeading, buffer(str_offset + 21, 2), buffer(str_offset + 21, 2):le_uint() * 0.0001)
    subtree:add(gnssType, buffer(str_offset + 23, 1))
    subtree:add(length, buffer(str_offset + 24, 2), buffer(str_offset + 24, 2):le_uint() * 0.1)
    subtree:add(beam, buffer(str_offset + 26, 2), buffer(str_offset + 26, 2):le_uint() * 0.1)
    subtree:add(positionReferenceFromStarboard, buffer(str_offset + 28, 2), buffer(str_offset + 28, 2):le_uint() * 0.1)
    subtree:add(positionReferenceFromBow, buffer(str_offset + 30, 2), buffer(str_offset + 30, 2):le_uint() * 0.1)
    subtree:add(name, buffer(str_offset + 32, 20))
    subtree:add(dte, buffer(str_offset + 52, 1))
    subtree:add(aisMode, buffer(str_offset + 52, 1))
    subtree:add(aisTransceiverInformation, buffer(str_offset + 52, 1))
end

return NMEA_2000_129040
