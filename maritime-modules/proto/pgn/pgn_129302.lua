-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129302 = Proto("nmea-2000-129302", "Bearing and Distance between two Marks (129302)")
local sid = ProtoField.float("nmea-2000-129302.sid", "SID")
local bearingReference = ProtoField.uint8("nmea-2000-129302.bearingReference", "Bearing Reference", base.DEC, NULL, 0x3)
local calculationType = ProtoField.uint8("nmea-2000-129302.calculationType", "Calculation Type", base.DEC, NULL, 0xc)
local bearingOriginToDestination = ProtoField.float("nmea-2000-129302.bearingOriginToDestination", "Bearing, Origin to Destination (rad)")
local distance = ProtoField.float("nmea-2000-129302.distance", "Distance (m)")
local originMarkType = ProtoField.uint8("nmea-2000-129302.originMarkType", "Origin Mark Type", base.DEC, NULL, 0xf)
local destinationMarkType = ProtoField.uint8("nmea-2000-129302.destinationMarkType", "Destination Mark Type", base.DEC, NULL, 0xf0)
local originMarkId = ProtoField.float("nmea-2000-129302.originMarkId", "Origin Mark ID")
local destinationMarkId = ProtoField.float("nmea-2000-129302.destinationMarkId", "Destination Mark ID")

NMEA_2000_129302.fields = {sid,bearingReference,calculationType,bearingOriginToDestination,distance,originMarkType,destinationMarkType,originMarkId,destinationMarkId}

function NMEA_2000_129302.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129302 (Bearing and Distance between two Marks)"
    local subtree = tree:add(NMEA_2000_129302, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(bearingReference, buffer(str_offset + 1, 1))
    subtree:add(calculationType, buffer(str_offset + 1, 1))
    subtree:add(bearingOriginToDestination, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 0.0001)
    subtree:add(distance, buffer(str_offset + 4, 4), buffer(str_offset + 4, 4):le_uint() * 0.01)
    subtree:add(originMarkType, buffer(str_offset + 8, 1))
    subtree:add(destinationMarkType, buffer(str_offset + 8, 1))
    subtree:add(originMarkId, buffer(str_offset + 9, 4), buffer(str_offset + 9, 4):le_uint() * 1)
    subtree:add(destinationMarkId, buffer(str_offset + 13, 4), buffer(str_offset + 13, 4):le_uint() * 1)
end

return NMEA_2000_129302
