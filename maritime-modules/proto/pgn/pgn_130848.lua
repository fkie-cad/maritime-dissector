-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130848 = Proto("nmea-2000-130848", "SeaTalk: Waypoint Information (130848)")
local manufacturerCode = ProtoField.uint32("nmea-2000-130848.manufacturerCode", "Manufacturer Code")
local industryCode = ProtoField.uint8("nmea-2000-130848.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local sid = ProtoField.uint8("nmea-2000-130848.sid", "SID")
local waypointName = ProtoField.string("nmea-2000-130848.waypointName", "Waypoint Name")
local waypointSequence = ProtoField.string("nmea-2000-130848.waypointSequence", "Waypoint Sequence")
local bearingToWaypointTrue = ProtoField.float("nmea-2000-130848.bearingToWaypointTrue", "Bearing to Waypoint, True (rad)")
local bearingToWaypointMagnetic = ProtoField.float("nmea-2000-130848.bearingToWaypointMagnetic", "Bearing to Waypoint, Magnetic (rad)")
local distanceToWaypoint = ProtoField.float("nmea-2000-130848.distanceToWaypoint", "Distance to Waypoint (m)")

NMEA_2000_130848.fields = {manufacturerCode,industryCode,sid,waypointName,waypointSequence,bearingToWaypointTrue,bearingToWaypointMagnetic,distanceToWaypoint}

function NMEA_2000_130848.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130848 (SeaTalk: Waypoint Information)"
    local subtree = tree:add(NMEA_2000_130848, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 2) then
        local _rng = buffer(str_offset, 2)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 11)
        subtree:add(manufacturerCode, _rng, _val)
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(industryCode, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(sid, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 3 + 16) then
        local _waypointName_raw = buffer(str_offset + 3, 16):string()
        local _waypointName_clean = _waypointName_raw:gsub("[%s@%z\xff]+$", "")
        subtree:add(waypointName, buffer(str_offset + 3, 16), _waypointName_clean)
    end
    if buffer:len() >= (str_offset + 19 + 4) then
        local _waypointSequence_raw = buffer(str_offset + 19, 4):string()
        local _waypointSequence_clean = _waypointSequence_raw:gsub("[%s@%z\xff]+$", "")
        subtree:add(waypointSequence, buffer(str_offset + 19, 4), _waypointSequence_clean)
    end
    if buffer:len() >= (str_offset + 23 + 2) then
        subtree:add(bearingToWaypointTrue, buffer(str_offset + 23, 2), buffer(str_offset + 23, 2):le_uint() * 0.0001)
    end
    if buffer:len() >= (str_offset + 25 + 2) then
        subtree:add(bearingToWaypointMagnetic, buffer(str_offset + 25, 2), buffer(str_offset + 25, 2):le_uint() * 0.0001)
    end
    if buffer:len() >= (str_offset + 27 + 4) then
        subtree:add(distanceToWaypoint, buffer(str_offset + 27, 4), buffer(str_offset + 27, 4):le_uint() * 0.01)
    end
end

return NMEA_2000_130848
