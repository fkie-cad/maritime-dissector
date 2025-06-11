-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129041 = Proto("nmea-2000-129041", "AIS Aids to Navigation (AtoN) Report (129041)")
local messageId = ProtoField.uint8("nmea-2000-129041.messageId", "Message ID", base.DEC, NULL, 0x3f)
local repeatIndicator = ProtoField.uint8("nmea-2000-129041.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local userId = ProtoField.float("nmea-2000-129041.userId", "User ID")
local longitude = ProtoField.float("nmea-2000-129041.longitude", "Longitude (deg)")
local latitude = ProtoField.float("nmea-2000-129041.latitude", "Latitude (deg)")
local positionAccuracy = ProtoField.uint8("nmea-2000-129041.positionAccuracy", "Position Accuracy", base.DEC, NULL, 0x1)
local raim = ProtoField.uint8("nmea-2000-129041.raim", "RAIM", base.DEC, NULL, 0x2)
local timeStamp = ProtoField.uint8("nmea-2000-129041.timeStamp", "Time Stamp", base.DEC, NULL, 0xfc)
local lengthDiameter = ProtoField.float("nmea-2000-129041.lengthDiameter", "Length/Diameter (m)")
local beamDiameter = ProtoField.float("nmea-2000-129041.beamDiameter", "Beam/Diameter (m)")
local positionReferenceFromStarboardEdge = ProtoField.float("nmea-2000-129041.positionReferenceFromStarboardEdge", "Position Reference from Starboard Edge (m)")
local positionReferenceFromTrueNorthFacingEdge = ProtoField.float("nmea-2000-129041.positionReferenceFromTrueNorthFacingEdge", "Position Reference from True North Facing Edge (m)")
local atonType = ProtoField.uint8("nmea-2000-129041.atonType", "AtoN Type", base.DEC, NULL, 0x1f)
local offPositionIndicator = ProtoField.uint8("nmea-2000-129041.offPositionIndicator", "Off Position Indicator", base.DEC, NULL, 0x20)
local virtualAtonFlag = ProtoField.uint8("nmea-2000-129041.virtualAtonFlag", "Virtual AtoN Flag", base.DEC, NULL, 0x40)
local assignedModeFlag = ProtoField.uint8("nmea-2000-129041.assignedModeFlag", "Assigned Mode Flag", base.DEC, NULL, 0x80)
local positionFixingDeviceType = ProtoField.uint8("nmea-2000-129041.positionFixingDeviceType", "Position Fixing Device Type", base.DEC, NULL, 0x1e)
local aisTransceiverInformation = ProtoField.uint8("nmea-2000-129041.aisTransceiverInformation", "AIS Transceiver information", base.DEC, NULL, 0x1f)
local atonName = ProtoField.string("nmea-2000-129041.atonName", "AtoN Name")

NMEA_2000_129041.fields = {messageId,repeatIndicator,userId,longitude,latitude,positionAccuracy,raim,timeStamp,lengthDiameter,beamDiameter,positionReferenceFromStarboardEdge,positionReferenceFromTrueNorthFacingEdge,atonType,offPositionIndicator,virtualAtonFlag,assignedModeFlag,positionFixingDeviceType,aisTransceiverInformation,atonName}

function NMEA_2000_129041.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129041 (AIS Aids to Navigation (AtoN) Report)"
    local subtree = tree:add(NMEA_2000_129041, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(messageId, buffer(str_offset + 0, 1))
    subtree:add(repeatIndicator, buffer(str_offset + 0, 1))
    subtree:add(userId, buffer(str_offset + 1, 4), buffer(str_offset + 1, 4):le_uint() * 1)
    subtree:add(longitude, buffer(str_offset + 5, 4), buffer(str_offset + 5, 4):le_int() * 1e-07)
    subtree:add(latitude, buffer(str_offset + 9, 4), buffer(str_offset + 9, 4):le_int() * 1e-07)
    subtree:add(positionAccuracy, buffer(str_offset + 13, 1))
    subtree:add(raim, buffer(str_offset + 13, 1))
    subtree:add(timeStamp, buffer(str_offset + 13, 1))
    subtree:add(lengthDiameter, buffer(str_offset + 14, 2), buffer(str_offset + 14, 2):le_uint() * 0.1)
    subtree:add(beamDiameter, buffer(str_offset + 16, 2), buffer(str_offset + 16, 2):le_uint() * 0.1)
    subtree:add(positionReferenceFromStarboardEdge, buffer(str_offset + 18, 2), buffer(str_offset + 18, 2):le_uint() * 0.1)
    subtree:add(positionReferenceFromTrueNorthFacingEdge, buffer(str_offset + 20, 2), buffer(str_offset + 20, 2):le_uint() * 0.1)
    subtree:add(atonType, buffer(str_offset + 22, 1))
    subtree:add(offPositionIndicator, buffer(str_offset + 22, 1))
    subtree:add(virtualAtonFlag, buffer(str_offset + 22, 1))
    subtree:add(assignedModeFlag, buffer(str_offset + 22, 1))
    subtree:add(positionFixingDeviceType, buffer(str_offset + 23, 1))
    subtree:add(aisTransceiverInformation, buffer(str_offset + 25, 1))
    length = buffer(str_offset + 26, 1):uint() - 2
    -- type = buffer(str_offset + 26 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(atonName, buffer(str_offset + 26 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_129041
