-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129541 = Proto("nmea-2000-129541", "GPS Almanac Data (129541)")
local prn = ProtoField.uint8("nmea-2000-129541.prn", "PRN")
local gpsWeekNumber = ProtoField.uint16("nmea-2000-129541.gpsWeekNumber", "GPS Week number")
local svHealthBits = ProtoField.bytes("nmea-2000-129541.svHealthBits", "SV Health Bits")
local eccentricity = ProtoField.float("nmea-2000-129541.eccentricity", "Eccentricity (m/m)")
local almanacReferenceTime = ProtoField.float("nmea-2000-129541.almanacReferenceTime", "Almanac Reference Time (s)")
local inclinationAngle = ProtoField.float("nmea-2000-129541.inclinationAngle", "Inclination Angle (semi-circle)")
local rateOfRightAscension = ProtoField.float("nmea-2000-129541.rateOfRightAscension", "Rate of Right Ascension (semi-circle/s)")
local rootOfSemiMajorAxis = ProtoField.float("nmea-2000-129541.rootOfSemiMajorAxis", "Root of Semi-major Axis (sqrt(m))")
local argumentOfPerigee = ProtoField.float("nmea-2000-129541.argumentOfPerigee", "Argument of Perigee (semi-circle)")
local longitudeOfAscensionNode = ProtoField.float("nmea-2000-129541.longitudeOfAscensionNode", "Longitude of Ascension Node (semi-circle)")
local meanAnomaly = ProtoField.float("nmea-2000-129541.meanAnomaly", "Mean Anomaly (semi-circle)")
local clockParameter1 = ProtoField.float("nmea-2000-129541.clockParameter1", "Clock Parameter 1 (s)")
local clockParameter2 = ProtoField.float("nmea-2000-129541.clockParameter2", "Clock Parameter 2 (s/s)")

NMEA_2000_129541.fields = {prn,gpsWeekNumber,svHealthBits,eccentricity,almanacReferenceTime,inclinationAngle,rateOfRightAscension,rootOfSemiMajorAxis,argumentOfPerigee,longitudeOfAscensionNode,meanAnomaly,clockParameter1,clockParameter2}

function NMEA_2000_129541.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129541 (GPS Almanac Data)"
    local subtree = tree:add(NMEA_2000_129541, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(prn, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 2) then
        subtree:add_le(gpsWeekNumber, buffer(str_offset + 1, 2))
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(svHealthBits, buffer(str_offset + 3, 1))
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add(eccentricity, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 4.76837e-07)
    end
    if buffer:len() >= (str_offset + 6 + 1) then
        subtree:add(almanacReferenceTime, buffer(str_offset + 6, 1), buffer(str_offset + 6, 1):le_uint() * 4096)
    end
    if buffer:len() >= (str_offset + 7 + 2) then
        subtree:add(inclinationAngle, buffer(str_offset + 7, 2), buffer(str_offset + 7, 2):le_int() * 1.90735e-06)
    end
    if buffer:len() >= (str_offset + 9 + 2) then
        subtree:add(rateOfRightAscension, buffer(str_offset + 9, 2), buffer(str_offset + 9, 2):le_int() * 3.63798e-12)
    end
    if buffer:len() >= (str_offset + 11 + 3) then
        subtree:add(rootOfSemiMajorAxis, buffer(str_offset + 11, 3), buffer(str_offset + 11, 3):le_uint() * 0.000488281)
    end
    if buffer:len() >= (str_offset + 14 + 3) then
        subtree:add(argumentOfPerigee, buffer(str_offset + 14, 3), buffer(str_offset + 14, 3):le_int() * 1.19209e-07)
    end
    if buffer:len() >= (str_offset + 17 + 3) then
        subtree:add(longitudeOfAscensionNode, buffer(str_offset + 17, 3), buffer(str_offset + 17, 3):le_int() * 1.19209e-07)
    end
    if buffer:len() >= (str_offset + 20 + 3) then
        subtree:add(meanAnomaly, buffer(str_offset + 20, 3), buffer(str_offset + 20, 3):le_int() * 1.19209e-07)
    end
    if buffer:len() >= (str_offset + 23 + 2) then
        local _rng = buffer(str_offset + 23, 2)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 11)
        if _val >= 2 ^ (11 - 1) then
            _val = _val - 2 ^ 11
        end
        subtree:add(clockParameter1, _rng, _val * 9.53674e-07)
    end
    if buffer:len() >= (str_offset + 24 + 2) then
        local _rng = buffer(str_offset + 24, 2)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 3)) % (2 ^ 11)
        if _val >= 2 ^ (11 - 1) then
            _val = _val - 2 ^ 11
        end
        subtree:add(clockParameter2, _rng, _val * 3.63798e-12)
    end
end

return NMEA_2000_129541
