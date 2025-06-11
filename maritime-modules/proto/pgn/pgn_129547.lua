-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129547 = Proto("nmea-2000-129547", "GNSS Pseudorange Error Statistics (129547)")
local sid = ProtoField.float("nmea-2000-129547.sid", "SID")
local rmsStdDevOfRangeInputs = ProtoField.float("nmea-2000-129547.rmsStdDevOfRangeInputs", "RMS Std Dev of Range Inputs (m)")
local stdDevOfMajorErrorEllipse = ProtoField.float("nmea-2000-129547.stdDevOfMajorErrorEllipse", "Std Dev of Major error ellipse (m)")
local stdDevOfMinorErrorEllipse = ProtoField.float("nmea-2000-129547.stdDevOfMinorErrorEllipse", "Std Dev of Minor error ellipse (m)")
local orientationOfErrorEllipse = ProtoField.float("nmea-2000-129547.orientationOfErrorEllipse", "Orientation of error ellipse (rad)")
local stdDevLatError = ProtoField.float("nmea-2000-129547.stdDevLatError", "Std Dev Lat Error (m)")
local stdDevLonError = ProtoField.float("nmea-2000-129547.stdDevLonError", "Std Dev Lon Error (m)")
local stdDevAltError = ProtoField.float("nmea-2000-129547.stdDevAltError", "Std Dev Alt Error (m)")

NMEA_2000_129547.fields = {sid,rmsStdDevOfRangeInputs,stdDevOfMajorErrorEllipse,stdDevOfMinorErrorEllipse,orientationOfErrorEllipse,stdDevLatError,stdDevLonError,stdDevAltError}

function NMEA_2000_129547.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129547 (GNSS Pseudorange Error Statistics)"
    local subtree = tree:add(NMEA_2000_129547, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(rmsStdDevOfRangeInputs, buffer(str_offset + 1, 2), buffer(str_offset + 1, 2):le_uint() * 0.01)
    subtree:add(stdDevOfMajorErrorEllipse, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_uint() * 0.01)
    subtree:add(stdDevOfMinorErrorEllipse, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_uint() * 0.01)
    subtree:add(orientationOfErrorEllipse, buffer(str_offset + 7, 2), buffer(str_offset + 7, 2):le_uint() * 0.0001)
    subtree:add(stdDevLatError, buffer(str_offset + 9, 2), buffer(str_offset + 9, 2):le_uint() * 0.01)
    subtree:add(stdDevLonError, buffer(str_offset + 11, 2), buffer(str_offset + 11, 2):le_uint() * 0.01)
    subtree:add(stdDevAltError, buffer(str_offset + 13, 2), buffer(str_offset + 13, 2):le_uint() * 0.01)
end

return NMEA_2000_129547
