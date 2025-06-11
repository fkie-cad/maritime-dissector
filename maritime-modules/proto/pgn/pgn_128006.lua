-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128006 = Proto("nmea-2000-128006", "Thruster Control Status (128006)")
local sid = ProtoField.float("nmea-2000-128006.sid", "SID")
local identifier = ProtoField.float("nmea-2000-128006.identifier", "Identifier")
local directionControl = ProtoField.uint8("nmea-2000-128006.directionControl", "Direction Control", base.DEC, NULL, 0xf)
local powerEnabled = ProtoField.uint8("nmea-2000-128006.powerEnabled", "Power Enabled", base.DEC, NULL, 0x30)
local retractControl = ProtoField.uint8("nmea-2000-128006.retractControl", "Retract Control", base.DEC, NULL, 0xc0)
local speedControl = ProtoField.float("nmea-2000-128006.speedControl", "Speed Control (%)")
local commandTimeout = ProtoField.float("nmea-2000-128006.commandTimeout", "Command Timeout (s)")
local azimuthControl = ProtoField.float("nmea-2000-128006.azimuthControl", "Azimuth Control (rad)")

NMEA_2000_128006.fields = {sid,identifier,directionControl,powerEnabled,retractControl,speedControl,commandTimeout,azimuthControl}

function NMEA_2000_128006.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128006 (Thruster Control Status)"
    local subtree = tree:add(NMEA_2000_128006, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(identifier, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(directionControl, buffer(str_offset + 2, 1))
    subtree:add(powerEnabled, buffer(str_offset + 2, 1))
    subtree:add(retractControl, buffer(str_offset + 2, 1))
    subtree:add(speedControl, buffer(str_offset + 3, 1), buffer(str_offset + 3, 1):le_uint() * 1)
    subtree:add(commandTimeout, buffer(str_offset + 5, 1), buffer(str_offset + 5, 1):le_uint() * 0.005)
    subtree:add(azimuthControl, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 0.0001)
end

return NMEA_2000_128006
