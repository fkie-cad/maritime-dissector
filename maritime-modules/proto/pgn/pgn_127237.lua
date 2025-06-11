-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127237 = Proto("nmea-2000-127237", "Heading/Track control (127237)")
local rudderLimitExceeded = ProtoField.uint8("nmea-2000-127237.rudderLimitExceeded", "Rudder Limit Exceeded", base.DEC, NULL, 0x3)
local offHeadingLimitExceeded = ProtoField.uint8("nmea-2000-127237.offHeadingLimitExceeded", "Off-Heading Limit Exceeded", base.DEC, NULL, 0xc)
local offTrackLimitExceeded = ProtoField.uint8("nmea-2000-127237.offTrackLimitExceeded", "Off-Track Limit Exceeded", base.DEC, NULL, 0x30)
local override = ProtoField.uint8("nmea-2000-127237.override", "Override", base.DEC, NULL, 0xc0)
local steeringMode = ProtoField.uint8("nmea-2000-127237.steeringMode", "Steering Mode", base.DEC, NULL, 0x7)
local turnMode = ProtoField.uint8("nmea-2000-127237.turnMode", "Turn Mode", base.DEC, NULL, 0x38)
local headingReference = ProtoField.uint8("nmea-2000-127237.headingReference", "Heading Reference", base.DEC, NULL, 0xc0)
local commandedRudderDirection = ProtoField.uint8("nmea-2000-127237.commandedRudderDirection", "Commanded Rudder Direction", base.DEC, NULL, 0xe0)
local commandedRudderAngle = ProtoField.float("nmea-2000-127237.commandedRudderAngle", "Commanded Rudder Angle (rad)")
local headingToSteerCourse = ProtoField.float("nmea-2000-127237.headingToSteerCourse", "Heading-To-Steer (Course) (rad)")
local track = ProtoField.float("nmea-2000-127237.track", "Track (rad)")
local rudderLimit = ProtoField.float("nmea-2000-127237.rudderLimit", "Rudder Limit (rad)")
local offHeadingLimit = ProtoField.float("nmea-2000-127237.offHeadingLimit", "Off-Heading Limit (rad)")
local radiusOfTurnOrder = ProtoField.float("nmea-2000-127237.radiusOfTurnOrder", "Radius of Turn Order (m)")
local rateOfTurnOrder = ProtoField.float("nmea-2000-127237.rateOfTurnOrder", "Rate of Turn Order (rad/s)")
local offTrackLimit = ProtoField.float("nmea-2000-127237.offTrackLimit", "Off-Track Limit (m)")
local vesselHeading = ProtoField.float("nmea-2000-127237.vesselHeading", "Vessel Heading (rad)")

NMEA_2000_127237.fields = {rudderLimitExceeded,offHeadingLimitExceeded,offTrackLimitExceeded,override,steeringMode,turnMode,headingReference,commandedRudderDirection,commandedRudderAngle,headingToSteerCourse,track,rudderLimit,offHeadingLimit,radiusOfTurnOrder,rateOfTurnOrder,offTrackLimit,vesselHeading}

function NMEA_2000_127237.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127237 (Heading/Track control)"
    local subtree = tree:add(NMEA_2000_127237, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(rudderLimitExceeded, buffer(str_offset + 0, 1))
    subtree:add(offHeadingLimitExceeded, buffer(str_offset + 0, 1))
    subtree:add(offTrackLimitExceeded, buffer(str_offset + 0, 1))
    subtree:add(override, buffer(str_offset + 0, 1))
    subtree:add(steeringMode, buffer(str_offset + 1, 1))
    subtree:add(turnMode, buffer(str_offset + 1, 1))
    subtree:add(headingReference, buffer(str_offset + 1, 1))
    subtree:add(commandedRudderDirection, buffer(str_offset + 2, 1))
    subtree:add(commandedRudderAngle, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_int() * 0.0001)
    subtree:add(headingToSteerCourse, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_uint() * 0.0001)
    subtree:add(track, buffer(str_offset + 7, 2), buffer(str_offset + 7, 2):le_uint() * 0.0001)
    subtree:add(rudderLimit, buffer(str_offset + 9, 2), buffer(str_offset + 9, 2):le_uint() * 0.0001)
    subtree:add(offHeadingLimit, buffer(str_offset + 11, 2), buffer(str_offset + 11, 2):le_uint() * 0.0001)
    subtree:add(radiusOfTurnOrder, buffer(str_offset + 13, 2), buffer(str_offset + 13, 2):le_int() * 1)
    subtree:add(rateOfTurnOrder, buffer(str_offset + 15, 2), buffer(str_offset + 15, 2):le_int() * 3.125e-05)
    subtree:add(offTrackLimit, buffer(str_offset + 17, 2), buffer(str_offset + 17, 2):le_int() * 1)
    subtree:add(vesselHeading, buffer(str_offset + 19, 2), buffer(str_offset + 19, 2):le_uint() * 0.0001)
end

return NMEA_2000_127237
