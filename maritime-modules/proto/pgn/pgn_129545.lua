-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129545 = Proto("nmea-2000-129545", "GNSS RAIM Output (129545)")
local sid = ProtoField.uint8("nmea-2000-129545.sid", "SID")
local integrityFlag = ProtoField.uint8("nmea-2000-129545.integrityFlag", "Integrity flag", base.DEC, NULL, 0x3)
local latitudeExpectedError = ProtoField.float("nmea-2000-129545.latitudeExpectedError", "Latitude expected error (m)")
local longitudeExpectedError = ProtoField.float("nmea-2000-129545.longitudeExpectedError", "Longitude expected error (m)")
local altitudeExpectedError = ProtoField.float("nmea-2000-129545.altitudeExpectedError", "Altitude expected error (m)")
local svIdOfMostLikelyFailedSat = ProtoField.uint8("nmea-2000-129545.svIdOfMostLikelyFailedSat", "SV ID of most likely failed sat")
local probabilityOfMissedDetection = ProtoField.float("nmea-2000-129545.probabilityOfMissedDetection", "Probability of missed detection (m)")
local estimateOfPseudorangeBias = ProtoField.float("nmea-2000-129545.estimateOfPseudorangeBias", "Estimate of pseudorange bias (m)")
local stdDeviationOfBias = ProtoField.float("nmea-2000-129545.stdDeviationOfBias", "Std Deviation of bias (m)")

NMEA_2000_129545.fields = {sid,integrityFlag,latitudeExpectedError,longitudeExpectedError,altitudeExpectedError,svIdOfMostLikelyFailedSat,probabilityOfMissedDetection,estimateOfPseudorangeBias,stdDeviationOfBias}

function NMEA_2000_129545.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129545 (GNSS RAIM Output)"
    local subtree = tree:add(NMEA_2000_129545, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sid, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(integrityFlag, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add(latitudeExpectedError, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_int() * 0.01)
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add(longitudeExpectedError, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_int() * 0.01)
    end
    if buffer:len() >= (str_offset + 6 + 2) then
        subtree:add(altitudeExpectedError, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_int() * 0.01)
    end
    if buffer:len() >= (str_offset + 8 + 1) then
        subtree:add(svIdOfMostLikelyFailedSat, buffer(str_offset + 8, 1))
    end
    if buffer:len() >= (str_offset + 9 + 2) then
        subtree:add(probabilityOfMissedDetection, buffer(str_offset + 9, 2), buffer(str_offset + 9, 2):le_int() * 0.01)
    end
    if buffer:len() >= (str_offset + 11 + 2) then
        subtree:add(estimateOfPseudorangeBias, buffer(str_offset + 11, 2), buffer(str_offset + 11, 2):le_int() * 0.01)
    end
    if buffer:len() >= (str_offset + 13 + 2) then
        subtree:add(stdDeviationOfBias, buffer(str_offset + 13, 2), buffer(str_offset + 13, 2):le_int() * 0.01)
    end
end

return NMEA_2000_129545
