-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129794 = Proto("nmea-2000-129794", "AIS Class A Static and Voyage Related Data (129794)")
local messageId = ProtoField.uint8("nmea-2000-129794.messageId", "Message ID", base.DEC, NULL, 0x3f)
local repeatIndicator = ProtoField.uint8("nmea-2000-129794.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local userId = ProtoField.float("nmea-2000-129794.userId", "User ID")
local imoNumber = ProtoField.float("nmea-2000-129794.imoNumber", "IMO number")
local callsign = ProtoField.string("nmea-2000-129794.callsign", "Callsign")
local name = ProtoField.string("nmea-2000-129794.name", "Name")
local typeOfShip = ProtoField.uint8("nmea-2000-129794.typeOfShip", "Type of ship", base.DEC, NULL, 0xff)
local length = ProtoField.float("nmea-2000-129794.length", "Length (m)")
local beam = ProtoField.float("nmea-2000-129794.beam", "Beam (m)")
local positionReferenceFromStarboard = ProtoField.float("nmea-2000-129794.positionReferenceFromStarboard", "Position reference from Starboard (m)")
local positionReferenceFromBow = ProtoField.float("nmea-2000-129794.positionReferenceFromBow", "Position reference from Bow (m)")
local etaDate = ProtoField.float("nmea-2000-129794.etaDate", "ETA Date (d)")
local etaTime = ProtoField.float("nmea-2000-129794.etaTime", "ETA Time (s)")
local draft = ProtoField.float("nmea-2000-129794.draft", "Draft (m)")
local destination = ProtoField.string("nmea-2000-129794.destination", "Destination")
local aisVersionIndicator = ProtoField.uint8("nmea-2000-129794.aisVersionIndicator", "AIS version indicator", base.DEC, NULL, 0x3)
local gnssType = ProtoField.uint8("nmea-2000-129794.gnssType", "GNSS type", base.DEC, NULL, 0x3c)
local dte = ProtoField.uint8("nmea-2000-129794.dte", "DTE", base.DEC, NULL, 0x40)
local aisTransceiverInformation = ProtoField.uint8("nmea-2000-129794.aisTransceiverInformation", "AIS Transceiver information", base.DEC, NULL, 0x1f)

NMEA_2000_129794.fields = {messageId,repeatIndicator,userId,imoNumber,callsign,name,typeOfShip,length,beam,positionReferenceFromStarboard,positionReferenceFromBow,etaDate,etaTime,draft,destination,aisVersionIndicator,gnssType,dte,aisTransceiverInformation}

function NMEA_2000_129794.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129794 (AIS Class A Static and Voyage Related Data)"
    local subtree = tree:add(NMEA_2000_129794, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(messageId, buffer(str_offset + 0, 1))
    subtree:add(repeatIndicator, buffer(str_offset + 0, 1))
    subtree:add(userId, buffer(str_offset + 1, 4), buffer(str_offset + 1, 4):le_uint() * 1)
    subtree:add(imoNumber, buffer(str_offset + 5, 4), buffer(str_offset + 5, 4):le_uint() * 1)
    subtree:add(callsign, buffer(str_offset + 9, 7))
    subtree:add(name, buffer(str_offset + 16, 20))
    subtree:add(typeOfShip, buffer(str_offset + 36, 1))
    subtree:add(length, buffer(str_offset + 37, 2), buffer(str_offset + 37, 2):le_uint() * 0.1)
    subtree:add(beam, buffer(str_offset + 39, 2), buffer(str_offset + 39, 2):le_uint() * 0.1)
    subtree:add(positionReferenceFromStarboard, buffer(str_offset + 41, 2), buffer(str_offset + 41, 2):le_uint() * 0.1)
    subtree:add(positionReferenceFromBow, buffer(str_offset + 43, 2), buffer(str_offset + 43, 2):le_uint() * 0.1)
    subtree:add(etaDate, buffer(str_offset + 45, 2), buffer(str_offset + 45, 2):le_uint() * 1)
    subtree:add(etaTime, buffer(str_offset + 47, 4), buffer(str_offset + 47, 4):le_uint() * 0.0001)
    subtree:add(draft, buffer(str_offset + 51, 2), buffer(str_offset + 51, 2):le_uint() * 0.01)
    subtree:add(destination, buffer(str_offset + 53, 20))
    subtree:add(aisVersionIndicator, buffer(str_offset + 73, 1))
    subtree:add(gnssType, buffer(str_offset + 73, 1))
    subtree:add(dte, buffer(str_offset + 73, 1))
    subtree:add(aisTransceiverInformation, buffer(str_offset + 74, 1))
end

return NMEA_2000_129794
