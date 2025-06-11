-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130842 = Proto("nmea-2000-130842", "Simnet: AIS Class B static data (msg 24 Part B) (130842)")
local industryCode = ProtoField.uint8("nmea-2000-130842.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local repeatIndicator = ProtoField.uint8("nmea-2000-130842.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local d = ProtoField.float("nmea-2000-130842.d", "D")
local e = ProtoField.float("nmea-2000-130842.e", "E")
local userId = ProtoField.float("nmea-2000-130842.userId", "User ID")
local typeOfShip = ProtoField.uint8("nmea-2000-130842.typeOfShip", "Type of ship", base.DEC, NULL, 0xff)
local vendorId = ProtoField.string("nmea-2000-130842.vendorId", "Vendor ID")
local callsign = ProtoField.string("nmea-2000-130842.callsign", "Callsign")
local length = ProtoField.float("nmea-2000-130842.length", "Length (m)")
local beam = ProtoField.float("nmea-2000-130842.beam", "Beam (m)")
local positionReferenceFromStarboard = ProtoField.float("nmea-2000-130842.positionReferenceFromStarboard", "Position reference from Starboard (m)")
local positionReferenceFromBow = ProtoField.float("nmea-2000-130842.positionReferenceFromBow", "Position reference from Bow (m)")
local mothershipUserId = ProtoField.float("nmea-2000-130842.mothershipUserId", "Mothership User ID")

NMEA_2000_130842.fields = {industryCode,repeatIndicator,d,e,userId,typeOfShip,vendorId,callsign,length,beam,positionReferenceFromStarboard,positionReferenceFromBow,mothershipUserId}

function NMEA_2000_130842.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130842 (Simnet: AIS Class B static data (msg 24 Part B))"
    local subtree = tree:add(NMEA_2000_130842, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
    subtree:add(repeatIndicator, buffer(str_offset + 2, 1))
    subtree:add(d, buffer(str_offset + 3, 1), buffer(str_offset + 3, 1):le_uint() * 1)
    subtree:add(e, buffer(str_offset + 4, 1), buffer(str_offset + 4, 1):le_uint() * 1)
    subtree:add(userId, buffer(str_offset + 5, 4), buffer(str_offset + 5, 4):le_uint() * 1)
    subtree:add(typeOfShip, buffer(str_offset + 9, 1))
    subtree:add(vendorId, buffer(str_offset + 10, 7))
    subtree:add(callsign, buffer(str_offset + 17, 7))
    subtree:add(length, buffer(str_offset + 24, 2), buffer(str_offset + 24, 2):le_uint() * 0.1)
    subtree:add(beam, buffer(str_offset + 26, 2), buffer(str_offset + 26, 2):le_uint() * 0.1)
    subtree:add(positionReferenceFromStarboard, buffer(str_offset + 28, 2), buffer(str_offset + 28, 2):le_uint() * 0.1)
    subtree:add(positionReferenceFromBow, buffer(str_offset + 30, 2), buffer(str_offset + 30, 2):le_uint() * 0.1)
    subtree:add(mothershipUserId, buffer(str_offset + 32, 4), buffer(str_offset + 32, 4):le_uint() * 1)
end

return NMEA_2000_130842
