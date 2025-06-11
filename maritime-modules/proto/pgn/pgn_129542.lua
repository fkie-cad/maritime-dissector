-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129542 = Proto("nmea-2000-129542", "GNSS Pseudorange Noise Statistics (129542)")
local sid = ProtoField.float("nmea-2000-129542.sid", "SID")
local rmsOfPositionUncertainty = ProtoField.float("nmea-2000-129542.rmsOfPositionUncertainty", "RMS of Position Uncertainty (m)")
local stdOfMajorAxis = ProtoField.float("nmea-2000-129542.stdOfMajorAxis", "STD of Major axis (m)")
local stdOfMinorAxis = ProtoField.float("nmea-2000-129542.stdOfMinorAxis", "STD of Minor axis (m)")
local orientationOfMajorAxis = ProtoField.float("nmea-2000-129542.orientationOfMajorAxis", "Orientation of Major axis (rad)")
local stdOfLatError = ProtoField.float("nmea-2000-129542.stdOfLatError", "STD of Lat Error (m)")
local stdOfLonError = ProtoField.float("nmea-2000-129542.stdOfLonError", "STD of Lon Error (m)")
local stdOfAltError = ProtoField.float("nmea-2000-129542.stdOfAltError", "STD of Alt Error (m)")

NMEA_2000_129542.fields = {sid,rmsOfPositionUncertainty,stdOfMajorAxis,stdOfMinorAxis,orientationOfMajorAxis,stdOfLatError,stdOfLonError,stdOfAltError}

function NMEA_2000_129542.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129542 (GNSS Pseudorange Noise Statistics)"
    local subtree = tree:add(NMEA_2000_129542, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(rmsOfPositionUncertainty, buffer(str_offset + 1, 2), buffer(str_offset + 1, 2):le_uint() * 0.01)
    subtree:add(stdOfMajorAxis, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_uint() * 0.01)
    subtree:add(stdOfMinorAxis, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_uint() * 0.01)
    subtree:add(orientationOfMajorAxis, buffer(str_offset + 7, 2), buffer(str_offset + 7, 2):le_uint() * 0.0001)
    subtree:add(stdOfLatError, buffer(str_offset + 9, 2), buffer(str_offset + 9, 2):le_uint() * 0.01)
    subtree:add(stdOfLonError, buffer(str_offset + 11, 2), buffer(str_offset + 11, 2):le_uint() * 0.01)
    subtree:add(stdOfAltError, buffer(str_offset + 13, 2), buffer(str_offset + 13, 2):le_uint() * 0.01)
end

return NMEA_2000_129542
