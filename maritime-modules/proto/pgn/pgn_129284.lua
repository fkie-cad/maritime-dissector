-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129284 = Proto("nmea-2000-129284", "Navigation Data (129284)")
local sid = ProtoField.float("nmea-2000-129284.sid", "SID")
local distanceToWaypoint = ProtoField.float("nmea-2000-129284.distanceToWaypoint", "Distance to Waypoint (m)")
local courseBearingReference = ProtoField.uint8("nmea-2000-129284.courseBearingReference", "Course/Bearing reference", base.DEC, NULL, 0x3)
local perpendicularCrossed = ProtoField.uint8("nmea-2000-129284.perpendicularCrossed", "Perpendicular Crossed", base.DEC, NULL, 0xc)
local arrivalCircleEntered = ProtoField.uint8("nmea-2000-129284.arrivalCircleEntered", "Arrival Circle Entered", base.DEC, NULL, 0x30)
local calculationType = ProtoField.uint8("nmea-2000-129284.calculationType", "Calculation Type", base.DEC, NULL, 0xc0)
local etaTime = ProtoField.float("nmea-2000-129284.etaTime", "ETA Time (s)")
local etaDate = ProtoField.float("nmea-2000-129284.etaDate", "ETA Date (d)")
local bearingOriginToDestinationWaypoint = ProtoField.float("nmea-2000-129284.bearingOriginToDestinationWaypoint", "Bearing, Origin to Destination Waypoint (rad)")
local bearingPositionToDestinationWaypoint = ProtoField.float("nmea-2000-129284.bearingPositionToDestinationWaypoint", "Bearing, Position to Destination Waypoint (rad)")
local originWaypointNumber = ProtoField.float("nmea-2000-129284.originWaypointNumber", "Origin Waypoint Number")
local destinationWaypointNumber = ProtoField.float("nmea-2000-129284.destinationWaypointNumber", "Destination Waypoint Number")
local destinationLatitude = ProtoField.float("nmea-2000-129284.destinationLatitude", "Destination Latitude (deg)")
local destinationLongitude = ProtoField.float("nmea-2000-129284.destinationLongitude", "Destination Longitude (deg)")
local waypointClosingVelocity = ProtoField.float("nmea-2000-129284.waypointClosingVelocity", "Waypoint Closing Velocity (m/s)")

NMEA_2000_129284.fields = {sid,distanceToWaypoint,courseBearingReference,perpendicularCrossed,arrivalCircleEntered,calculationType,etaTime,etaDate,bearingOriginToDestinationWaypoint,bearingPositionToDestinationWaypoint,originWaypointNumber,destinationWaypointNumber,destinationLatitude,destinationLongitude,waypointClosingVelocity}

function NMEA_2000_129284.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129284 (Navigation Data)"
    local subtree = tree:add(NMEA_2000_129284, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(distanceToWaypoint, buffer(str_offset + 1, 4), buffer(str_offset + 1, 4):le_uint() * 0.01)
    subtree:add(courseBearingReference, buffer(str_offset + 5, 1))
    subtree:add(perpendicularCrossed, buffer(str_offset + 5, 1))
    subtree:add(arrivalCircleEntered, buffer(str_offset + 5, 1))
    subtree:add(calculationType, buffer(str_offset + 5, 1))
    subtree:add(etaTime, buffer(str_offset + 6, 4), buffer(str_offset + 6, 4):le_uint() * 0.0001)
    subtree:add(etaDate, buffer(str_offset + 10, 2), buffer(str_offset + 10, 2):le_uint() * 1)
    subtree:add(bearingOriginToDestinationWaypoint, buffer(str_offset + 12, 2), buffer(str_offset + 12, 2):le_uint() * 0.0001)
    subtree:add(bearingPositionToDestinationWaypoint, buffer(str_offset + 14, 2), buffer(str_offset + 14, 2):le_uint() * 0.0001)
    subtree:add(originWaypointNumber, buffer(str_offset + 16, 4), buffer(str_offset + 16, 4):le_uint() * 1)
    subtree:add(destinationWaypointNumber, buffer(str_offset + 20, 4), buffer(str_offset + 20, 4):le_uint() * 1)
    subtree:add(destinationLatitude, buffer(str_offset + 24, 4), buffer(str_offset + 24, 4):le_int() * 1e-07)
    subtree:add(destinationLongitude, buffer(str_offset + 28, 4), buffer(str_offset + 28, 4):le_int() * 1e-07)
    subtree:add(waypointClosingVelocity, buffer(str_offset + 32, 2), buffer(str_offset + 32, 2):le_int() * 0.01)
end

return NMEA_2000_129284
