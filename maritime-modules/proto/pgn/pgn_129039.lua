-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129039 = Proto("nmea-2000-129039", "AIS Class B Position Report (129039)")
local messageId = ProtoField.uint8("nmea-2000-129039.messageId", "Message ID", base.DEC, NULL, 0x3f)
local repeatIndicator = ProtoField.uint8("nmea-2000-129039.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local userId = ProtoField.float("nmea-2000-129039.userId", "User ID")
local longitude = ProtoField.float("nmea-2000-129039.longitude", "Longitude (deg)")
local latitude = ProtoField.float("nmea-2000-129039.latitude", "Latitude (deg)")
local positionAccuracy = ProtoField.uint8("nmea-2000-129039.positionAccuracy", "Position Accuracy", base.DEC, NULL, 0x1)
local raim = ProtoField.uint8("nmea-2000-129039.raim", "RAIM", base.DEC, NULL, 0x2)
local timeStamp = ProtoField.uint8("nmea-2000-129039.timeStamp", "Time Stamp", base.DEC, NULL, 0xfc)
local cog = ProtoField.float("nmea-2000-129039.cog", "COG (rad)")
local sog = ProtoField.float("nmea-2000-129039.sog", "SOG (m/s)")
local aisTransceiverInformation = ProtoField.uint8("nmea-2000-129039.aisTransceiverInformation", "AIS Transceiver information", base.DEC, NULL, 0xf8)
local heading = ProtoField.float("nmea-2000-129039.heading", "Heading (rad)")
local unitType = ProtoField.uint8("nmea-2000-129039.unitType", "Unit type", base.DEC, NULL, 0x4)
local integratedDisplay = ProtoField.uint8("nmea-2000-129039.integratedDisplay", "Integrated Display", base.DEC, NULL, 0x8)
local dsc = ProtoField.uint8("nmea-2000-129039.dsc", "DSC", base.DEC, NULL, 0x10)
local band = ProtoField.uint8("nmea-2000-129039.band", "Band", base.DEC, NULL, 0x20)
local canHandleMsg22 = ProtoField.uint8("nmea-2000-129039.canHandleMsg22", "Can handle Msg 22", base.DEC, NULL, 0x40)
local aisMode = ProtoField.uint8("nmea-2000-129039.aisMode", "AIS mode", base.DEC, NULL, 0x80)
local aisCommunicationState = ProtoField.uint8("nmea-2000-129039.aisCommunicationState", "AIS communication state", base.DEC, NULL, 0x1)

NMEA_2000_129039.fields = {messageId,repeatIndicator,userId,longitude,latitude,positionAccuracy,raim,timeStamp,cog,sog,aisTransceiverInformation,heading,unitType,integratedDisplay,dsc,band,canHandleMsg22,aisMode,aisCommunicationState}

function NMEA_2000_129039.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129039 (AIS Class B Position Report)"
    local subtree = tree:add(NMEA_2000_129039, buffer(), subtree_title)
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
    subtree:add(unitType, buffer(str_offset + 24, 1))
    subtree:add(integratedDisplay, buffer(str_offset + 24, 1))
    subtree:add(dsc, buffer(str_offset + 24, 1))
    subtree:add(band, buffer(str_offset + 24, 1))
    subtree:add(canHandleMsg22, buffer(str_offset + 24, 1))
    subtree:add(aisMode, buffer(str_offset + 24, 1))
    subtree:add(aisCommunicationState, buffer(str_offset + 25, 1))
end

return NMEA_2000_129039
