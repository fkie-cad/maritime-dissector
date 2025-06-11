-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129541 = Proto("nmea-2000-129541", "GPS Almanac Data (129541)")
local prn = ProtoField.float("nmea-2000-129541.prn", "PRN")
local gpsWeekNumber = ProtoField.float("nmea-2000-129541.gpsWeekNumber", "GPS Week number")
local eccentricity = ProtoField.float("nmea-2000-129541.eccentricity", "Eccentricity (m/m)")
local almanacReferenceTime = ProtoField.float("nmea-2000-129541.almanacReferenceTime", "Almanac Reference Time (s)")
local inclinationAngle = ProtoField.float("nmea-2000-129541.inclinationAngle", "Inclination Angle (semi-circle)")
local rateOfRightAscension = ProtoField.float("nmea-2000-129541.rateOfRightAscension", "Rate of Right Ascension (semi-circle/s)")
local rootOfSemiMajorAxis = ProtoField.float("nmea-2000-129541.rootOfSemiMajorAxis", "Root of Semi-major Axis (sqrt(m))")
local argumentOfPerigee = ProtoField.float("nmea-2000-129541.argumentOfPerigee", "Argument of Perigee (semi-circle)")
local longitudeOfAscensionNode = ProtoField.float("nmea-2000-129541.longitudeOfAscensionNode", "Longitude of Ascension Node (semi-circle)")
local meanAnomaly = ProtoField.float("nmea-2000-129541.meanAnomaly", "Mean Anomaly (semi-circle)")

NMEA_2000_129541.fields = {prn,gpsWeekNumber,eccentricity,almanacReferenceTime,inclinationAngle,rateOfRightAscension,rootOfSemiMajorAxis,argumentOfPerigee,longitudeOfAscensionNode,meanAnomaly}

function NMEA_2000_129541.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129541 (GPS Almanac Data)"
    local subtree = tree:add(NMEA_2000_129541, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(prn, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(gpsWeekNumber, buffer(str_offset + 1, 2), buffer(str_offset + 1, 2):le_uint() * 1)
    subtree:add(eccentricity, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 4.76837e-07)
    subtree:add(almanacReferenceTime, buffer(str_offset + 6, 1), buffer(str_offset + 6, 1):le_uint() * 4096)
    subtree:add(inclinationAngle, buffer(str_offset + 7, 2), buffer(str_offset + 7, 2):le_int() * 1.90735e-06)
    subtree:add(rateOfRightAscension, buffer(str_offset + 9, 2), buffer(str_offset + 9, 2):le_int() * 3.63798e-12)
    subtree:add(rootOfSemiMajorAxis, buffer(str_offset + 11, 3), buffer(str_offset + 11, 3):le_uint() * 0.000488281)
    subtree:add(argumentOfPerigee, buffer(str_offset + 14, 3), buffer(str_offset + 14, 3):le_int() * 1.19209e-07)
    subtree:add(longitudeOfAscensionNode, buffer(str_offset + 17, 3), buffer(str_offset + 17, 3):le_int() * 1.19209e-07)
    subtree:add(meanAnomaly, buffer(str_offset + 20, 3), buffer(str_offset + 20, 3):le_int() * 1.19209e-07)
end

return NMEA_2000_129541
