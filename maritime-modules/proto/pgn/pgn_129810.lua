-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129810 = Proto("nmea-2000-129810", "AIS Class B static data (msg 24 Part B) (129810)")
local messageId = ProtoField.uint8("nmea-2000-129810.messageId", "Message ID", base.DEC, NULL, 0x3f)
local repeatIndicator = ProtoField.uint8("nmea-2000-129810.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local userId = ProtoField.float("nmea-2000-129810.userId", "User ID")
local typeOfShip = ProtoField.uint8("nmea-2000-129810.typeOfShip", "Type of ship", base.DEC, NULL, 0xff)
local vendorId = ProtoField.string("nmea-2000-129810.vendorId", "Vendor ID")
local callsign = ProtoField.string("nmea-2000-129810.callsign", "Callsign")
local length = ProtoField.float("nmea-2000-129810.length", "Length (m)")
local beam = ProtoField.float("nmea-2000-129810.beam", "Beam (m)")
local positionReferenceFromStarboard = ProtoField.float("nmea-2000-129810.positionReferenceFromStarboard", "Position reference from Starboard (m)")
local positionReferenceFromBow = ProtoField.float("nmea-2000-129810.positionReferenceFromBow", "Position reference from Bow (m)")
local mothershipUserId = ProtoField.float("nmea-2000-129810.mothershipUserId", "Mothership User ID")
local gnssType = ProtoField.uint8("nmea-2000-129810.gnssType", "GNSS type", base.DEC, NULL, 0xf0)
local aisTransceiverInformation = ProtoField.uint8("nmea-2000-129810.aisTransceiverInformation", "AIS Transceiver information", base.DEC, NULL, 0x1f)
local sequenceId = ProtoField.float("nmea-2000-129810.sequenceId", "Sequence ID")

NMEA_2000_129810.fields = {messageId,repeatIndicator,userId,typeOfShip,vendorId,callsign,length,beam,positionReferenceFromStarboard,positionReferenceFromBow,mothershipUserId,gnssType,aisTransceiverInformation,sequenceId}

function NMEA_2000_129810.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129810 (AIS Class B static data (msg 24 Part B))"
    local subtree = tree:add(NMEA_2000_129810, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(messageId, buffer(str_offset + 0, 1))
    subtree:add(repeatIndicator, buffer(str_offset + 0, 1))
    subtree:add(userId, buffer(str_offset + 1, 4), buffer(str_offset + 1, 4):le_uint() * 1)
    subtree:add(typeOfShip, buffer(str_offset + 5, 1))
    subtree:add(vendorId, buffer(str_offset + 6, 7))
    subtree:add(callsign, buffer(str_offset + 13, 7))
    subtree:add(length, buffer(str_offset + 20, 2), buffer(str_offset + 20, 2):le_uint() * 0.1)
    subtree:add(beam, buffer(str_offset + 22, 2), buffer(str_offset + 22, 2):le_uint() * 0.1)
    subtree:add(positionReferenceFromStarboard, buffer(str_offset + 24, 2), buffer(str_offset + 24, 2):le_uint() * 0.1)
    subtree:add(positionReferenceFromBow, buffer(str_offset + 26, 2), buffer(str_offset + 26, 2):le_uint() * 0.1)
    subtree:add(mothershipUserId, buffer(str_offset + 28, 4), buffer(str_offset + 28, 4):le_uint() * 1)
    subtree:add(gnssType, buffer(str_offset + 32, 1))
    subtree:add(aisTransceiverInformation, buffer(str_offset + 33, 1))
    subtree:add(sequenceId, buffer(str_offset + 34, 1), buffer(str_offset + 34, 1):le_uint() * 1)
end

return NMEA_2000_129810
