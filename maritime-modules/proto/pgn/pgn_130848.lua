-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130848 = Proto("nmea-2000-130848", "SeaTalk: Waypoint Information (130848)")
local industryCode = ProtoField.uint8("nmea-2000-130848.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local sid = ProtoField.float("nmea-2000-130848.sid", "SID")
local waypointName = ProtoField.string("nmea-2000-130848.waypointName", "Waypoint Name")
local waypointSequence = ProtoField.string("nmea-2000-130848.waypointSequence", "Waypoint Sequence")
local bearingToWaypointTrue = ProtoField.float("nmea-2000-130848.bearingToWaypointTrue", "Bearing to Waypoint, True (rad)")
local bearingToWaypointMagnetic = ProtoField.float("nmea-2000-130848.bearingToWaypointMagnetic", "Bearing to Waypoint, Magnetic (rad)")
local distanceToWaypoint = ProtoField.float("nmea-2000-130848.distanceToWaypoint", "Distance to Waypoint (m)")

NMEA_2000_130848.fields = {industryCode,sid,waypointName,waypointSequence,bearingToWaypointTrue,bearingToWaypointMagnetic,distanceToWaypoint}

function NMEA_2000_130848.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130848 (SeaTalk: Waypoint Information)"
    local subtree = tree:add(NMEA_2000_130848, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
    subtree:add(sid, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(waypointName, buffer(str_offset + 3, 16))
    subtree:add(waypointSequence, buffer(str_offset + 19, 4))
    subtree:add(bearingToWaypointTrue, buffer(str_offset + 23, 2), buffer(str_offset + 23, 2):le_uint() * 0.0001)
    subtree:add(bearingToWaypointMagnetic, buffer(str_offset + 25, 2), buffer(str_offset + 25, 2):le_uint() * 0.0001)
    subtree:add(distanceToWaypoint, buffer(str_offset + 27, 4), buffer(str_offset + 27, 4):le_uint() * 0.01)
end

return NMEA_2000_130848
