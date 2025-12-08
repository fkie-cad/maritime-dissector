-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130918 = Proto("nmea-2000-130918", "SeaTalk: Route Information (130918)")
local manufacturerCode = ProtoField.uint32("nmea-2000-130918.manufacturerCode", "Manufacturer Code")
local industryCode = ProtoField.uint8("nmea-2000-130918.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local currentWaypointSequence = ProtoField.uint16("nmea-2000-130918.currentWaypointSequence", "Current Waypoint Sequence")
local currentWaypointName = ProtoField.string("nmea-2000-130918.currentWaypointName", "Current Waypoint Name")
local nextWaypointSequence = ProtoField.uint16("nmea-2000-130918.nextWaypointSequence", "Next Waypoint Sequence")
local nextWaypointName = ProtoField.string("nmea-2000-130918.nextWaypointName", "Next Waypoint Name")
local unknown = ProtoField.uint8("nmea-2000-130918.unknown", "Unknown")
local distancePositionToNextWaypoint = ProtoField.uint32("nmea-2000-130918.distancePositionToNextWaypoint", "Distance, Position to Next Waypoint (m)")
local bearingPositionToNextWaypointTrue = ProtoField.float("nmea-2000-130918.bearingPositionToNextWaypointTrue", "Bearing, Position to Next Waypoint, True (rad)")
local bearingCurrentWaypointToNextWaypointTrue = ProtoField.float("nmea-2000-130918.bearingCurrentWaypointToNextWaypointTrue", "Bearing, Current Waypoint to Next Waypoint, True (rad)")

NMEA_2000_130918.fields = {manufacturerCode,industryCode,currentWaypointSequence,currentWaypointName,nextWaypointSequence,nextWaypointName,unknown,distancePositionToNextWaypoint,bearingPositionToNextWaypointTrue,bearingCurrentWaypointToNextWaypointTrue}

function NMEA_2000_130918.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130918 (SeaTalk: Route Information)"
    local subtree = tree:add(NMEA_2000_130918, buffer(), subtree_title)
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
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add_le(currentWaypointSequence, buffer(str_offset + 2, 2))
    end
    if buffer:len() >= (str_offset + 4 + 16) then
        local _currentWaypointName_raw = buffer(str_offset + 4, 16):string()
        local _currentWaypointName_clean = _currentWaypointName_raw:gsub("[%s@%z\xff]+$", "")
        subtree:add(currentWaypointName, buffer(str_offset + 4, 16), _currentWaypointName_clean)
    end
    if buffer:len() >= (str_offset + 20 + 2) then
        subtree:add_le(nextWaypointSequence, buffer(str_offset + 20, 2))
    end
    if buffer:len() >= (str_offset + 22 + 16) then
        local _nextWaypointName_raw = buffer(str_offset + 22, 16):string()
        local _nextWaypointName_clean = _nextWaypointName_raw:gsub("[%s@%z\xff]+$", "")
        subtree:add(nextWaypointName, buffer(str_offset + 22, 16), _nextWaypointName_clean)
    end
    if buffer:len() >= (str_offset + 38 + 1) then
        subtree:add(unknown, buffer(str_offset + 38, 1))
    end
    if buffer:len() >= (str_offset + 39 + 4) then
        subtree:add_le(distancePositionToNextWaypoint, buffer(str_offset + 39, 4))
    end
    if buffer:len() >= (str_offset + 43 + 2) then
        subtree:add(bearingPositionToNextWaypointTrue, buffer(str_offset + 43, 2), buffer(str_offset + 43, 2):le_uint() * 0.0001)
    end
    if buffer:len() >= (str_offset + 45 + 2) then
        subtree:add(bearingCurrentWaypointToNextWaypointTrue, buffer(str_offset + 45, 2), buffer(str_offset + 45, 2):le_uint() * 0.0001)
    end
end

return NMEA_2000_130918
