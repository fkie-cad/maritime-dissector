-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130918 = Proto("nmea-2000-130918", "SeaTalk: Route Information (130918)")
local industryCode = ProtoField.uint8("nmea-2000-130918.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local currentWaypointSequence = ProtoField.float("nmea-2000-130918.currentWaypointSequence", "Current Waypoint Sequence")
local currentWaypointName = ProtoField.string("nmea-2000-130918.currentWaypointName", "Current Waypoint Name")
local nextWaypointSequence = ProtoField.float("nmea-2000-130918.nextWaypointSequence", "Next Waypoint Sequence")
local nextWaypointName = ProtoField.string("nmea-2000-130918.nextWaypointName", "Next Waypoint Name")
local unknown = ProtoField.float("nmea-2000-130918.unknown", "Unknown")
local distancePositionToNextWaypoint = ProtoField.float("nmea-2000-130918.distancePositionToNextWaypoint", "Distance, Position to Next Waypoint (m)")
local bearingPositionToNextWaypointTrue = ProtoField.float("nmea-2000-130918.bearingPositionToNextWaypointTrue", "Bearing, Position to Next Waypoint, True (rad)")
local bearingCurrentWaypointToNextWaypointTrue = ProtoField.float("nmea-2000-130918.bearingCurrentWaypointToNextWaypointTrue", "Bearing, Current Waypoint to Next Waypoint, True (rad)")

NMEA_2000_130918.fields = {industryCode,currentWaypointSequence,currentWaypointName,nextWaypointSequence,nextWaypointName,unknown,distancePositionToNextWaypoint,bearingPositionToNextWaypointTrue,bearingCurrentWaypointToNextWaypointTrue}

function NMEA_2000_130918.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130918 (SeaTalk: Route Information)"
    local subtree = tree:add(NMEA_2000_130918, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
    subtree:add(currentWaypointSequence, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 1)
    subtree:add(currentWaypointName, buffer(str_offset + 4, 16))
    subtree:add(nextWaypointSequence, buffer(str_offset + 20, 2), buffer(str_offset + 20, 2):le_uint() * 1)
    subtree:add(nextWaypointName, buffer(str_offset + 22, 16))
    subtree:add(unknown, buffer(str_offset + 38, 1), buffer(str_offset + 38, 1):le_uint() * 1)
    subtree:add(distancePositionToNextWaypoint, buffer(str_offset + 39, 4), buffer(str_offset + 39, 4):le_uint() * 1)
    subtree:add(bearingPositionToNextWaypointTrue, buffer(str_offset + 43, 2), buffer(str_offset + 43, 2):le_uint() * 0.0001)
    subtree:add(bearingCurrentWaypointToNextWaypointTrue, buffer(str_offset + 45, 2), buffer(str_offset + 45, 2):le_uint() * 0.0001)
end

return NMEA_2000_130918
