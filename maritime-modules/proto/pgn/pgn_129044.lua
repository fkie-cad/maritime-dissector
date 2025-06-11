-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129044 = Proto("nmea-2000-129044", "Datum (129044)")
local localDatum = ProtoField.string("nmea-2000-129044.localDatum", "Local Datum")
local deltaLatitude = ProtoField.float("nmea-2000-129044.deltaLatitude", "Delta Latitude (deg)")
local deltaLongitude = ProtoField.float("nmea-2000-129044.deltaLongitude", "Delta Longitude (deg)")
local deltaAltitude = ProtoField.float("nmea-2000-129044.deltaAltitude", "Delta Altitude (m)")
local referenceDatum = ProtoField.string("nmea-2000-129044.referenceDatum", "Reference Datum")

NMEA_2000_129044.fields = {localDatum,deltaLatitude,deltaLongitude,deltaAltitude,referenceDatum}

function NMEA_2000_129044.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129044 (Datum)"
    local subtree = tree:add(NMEA_2000_129044, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(localDatum, buffer(str_offset + 0, 4))
    subtree:add(deltaLatitude, buffer(str_offset + 4, 4), buffer(str_offset + 4, 4):le_int() * 1e-07)
    subtree:add(deltaLongitude, buffer(str_offset + 8, 4), buffer(str_offset + 8, 4):le_int() * 1e-07)
    subtree:add(deltaAltitude, buffer(str_offset + 12, 4), buffer(str_offset + 12, 4):le_int() * 0.01)
    subtree:add(referenceDatum, buffer(str_offset + 16, 4))
end

return NMEA_2000_129044
