-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129546 = Proto("nmea-2000-129546", "GNSS RAIM Settings (129546)")
local radialPositionErrorMaximumThreshold = ProtoField.float("nmea-2000-129546.radialPositionErrorMaximumThreshold", "Radial Position Error Maximum Threshold (m)")
local probabilityOfFalseAlarm = ProtoField.float("nmea-2000-129546.probabilityOfFalseAlarm", "Probability of False Alarm (%)")
local probabilityOfMissedDetection = ProtoField.float("nmea-2000-129546.probabilityOfMissedDetection", "Probability of Missed Detection (%)")
local pseudorangeResidualFilteringTimeConstant = ProtoField.float("nmea-2000-129546.pseudorangeResidualFilteringTimeConstant", "Pseudorange Residual Filtering Time Constant (s)")

NMEA_2000_129546.fields = {radialPositionErrorMaximumThreshold,probabilityOfFalseAlarm,probabilityOfMissedDetection,pseudorangeResidualFilteringTimeConstant}

function NMEA_2000_129546.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129546 (GNSS RAIM Settings)"
    local subtree = tree:add(NMEA_2000_129546, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(radialPositionErrorMaximumThreshold, buffer(str_offset + 0, 2), buffer(str_offset + 0, 2):le_uint() * 0.01)
    subtree:add(probabilityOfFalseAlarm, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_int() * 1)
    subtree:add(probabilityOfMissedDetection, buffer(str_offset + 3, 1), buffer(str_offset + 3, 1):le_int() * 1)
    subtree:add(pseudorangeResidualFilteringTimeConstant, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 1)
end

return NMEA_2000_129546
