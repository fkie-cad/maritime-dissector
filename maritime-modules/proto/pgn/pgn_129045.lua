-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129045 = Proto("nmea-2000-129045", "User Datum (129045)")
local deltaX = ProtoField.float("nmea-2000-129045.deltaX", "Delta X (m)")
local deltaY = ProtoField.float("nmea-2000-129045.deltaY", "Delta Y (m)")
local deltaZ = ProtoField.float("nmea-2000-129045.deltaZ", "Delta Z (m)")
local rotationInX = ProtoField.float("nmea-2000-129045.rotationInX", "Rotation in X (rad)")
local rotationInY = ProtoField.float("nmea-2000-129045.rotationInY", "Rotation in Y (rad)")
local rotationInZ = ProtoField.float("nmea-2000-129045.rotationInZ", "Rotation in Z (rad)")
local scale = ProtoField.float("nmea-2000-129045.scale", "Scale (ppm)")
local ellipsoidSemiMajorAxis = ProtoField.float("nmea-2000-129045.ellipsoidSemiMajorAxis", "Ellipsoid Semi-major Axis (m)")
local ellipsoidFlatteningInverse = ProtoField.float("nmea-2000-129045.ellipsoidFlatteningInverse", "Ellipsoid Flattening Inverse")
local datumName = ProtoField.string("nmea-2000-129045.datumName", "Datum Name")

NMEA_2000_129045.fields = {deltaX,deltaY,deltaZ,rotationInX,rotationInY,rotationInZ,scale,ellipsoidSemiMajorAxis,ellipsoidFlatteningInverse,datumName}

function NMEA_2000_129045.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129045 (User Datum)"
    local subtree = tree:add(NMEA_2000_129045, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(deltaX, buffer(str_offset + 0, 4), buffer(str_offset + 0, 4):le_int() * 0.01)
    subtree:add(deltaY, buffer(str_offset + 4, 4), buffer(str_offset + 4, 4):le_int() * 0.01)
    subtree:add(deltaZ, buffer(str_offset + 8, 4), buffer(str_offset + 8, 4):le_int() * 0.01)
    subtree:add(rotationInX, buffer(str_offset + 12, 4))
    subtree:add(rotationInY, buffer(str_offset + 16, 4))
    subtree:add(rotationInZ, buffer(str_offset + 20, 4))
    subtree:add(scale, buffer(str_offset + 24, 4))
    subtree:add(ellipsoidSemiMajorAxis, buffer(str_offset + 28, 4), buffer(str_offset + 28, 4):le_int() * 0.01)
    subtree:add(ellipsoidFlatteningInverse, buffer(str_offset + 32, 4))
    subtree:add(datumName, buffer(str_offset + 36, 4))
end

return NMEA_2000_129045
