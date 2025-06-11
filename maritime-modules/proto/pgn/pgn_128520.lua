-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128520 = Proto("nmea-2000-128520", "Tracked Target Data (128520)")
local sid = ProtoField.float("nmea-2000-128520.sid", "SID")
local targetId = ProtoField.float("nmea-2000-128520.targetId", "Target ID #")
local reportedTarget = ProtoField.uint8("nmea-2000-128520.reportedTarget", "Reported Target", base.DEC, NULL, 0x4)
local targetAcquisition = ProtoField.uint8("nmea-2000-128520.targetAcquisition", "Target Acquisition", base.DEC, NULL, 0x8)
local bearingReference = ProtoField.uint8("nmea-2000-128520.bearingReference", "Bearing Reference", base.DEC, NULL, 0x30)
local bearing = ProtoField.float("nmea-2000-128520.bearing", "Bearing (rad)")
local distance = ProtoField.float("nmea-2000-128520.distance", "Distance (m)")
local course = ProtoField.float("nmea-2000-128520.course", "Course (rad)")
local speed = ProtoField.float("nmea-2000-128520.speed", "Speed (m/s)")
local cpa = ProtoField.float("nmea-2000-128520.cpa", "CPA (m)")
local tcpa = ProtoField.float("nmea-2000-128520.tcpa", "TCPA (s)")
local utcOfFix = ProtoField.float("nmea-2000-128520.utcOfFix", "UTC of Fix (s)")
local name = ProtoField.string("nmea-2000-128520.name", "Name")

NMEA_2000_128520.fields = {sid,targetId,reportedTarget,targetAcquisition,bearingReference,bearing,distance,course,speed,cpa,tcpa,utcOfFix,name}

function NMEA_2000_128520.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128520 (Tracked Target Data)"
    local subtree = tree:add(NMEA_2000_128520, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(targetId, buffer(str_offset + 1, 2), buffer(str_offset + 1, 2):le_uint() * 1)
    subtree:add(reportedTarget, buffer(str_offset + 3, 1))
    subtree:add(targetAcquisition, buffer(str_offset + 3, 1))
    subtree:add(bearingReference, buffer(str_offset + 3, 1))
    subtree:add(bearing, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 0.0001)
    subtree:add(distance, buffer(str_offset + 6, 4), buffer(str_offset + 6, 4):le_int() * 0.01)
    subtree:add(course, buffer(str_offset + 10, 2), buffer(str_offset + 10, 2):le_uint() * 0.0001)
    subtree:add(speed, buffer(str_offset + 12, 2), buffer(str_offset + 12, 2):le_uint() * 0.01)
    subtree:add(cpa, buffer(str_offset + 14, 4), buffer(str_offset + 14, 4):le_int() * 0.01)
    subtree:add(tcpa, buffer(str_offset + 18, 4), buffer(str_offset + 18, 4):le_int() * 0.001)
    subtree:add(utcOfFix, buffer(str_offset + 22, 4), buffer(str_offset + 22, 4):le_uint() * 0.0001)
    length = buffer(str_offset + 26, 1):uint() - 2
    -- type = buffer(str_offset + 26 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(name, buffer(str_offset + 26 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_128520
