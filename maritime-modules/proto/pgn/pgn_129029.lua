-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129029 = Proto("nmea-2000-129029", "GNSS Position Data (129029)")
local sid = ProtoField.float("nmea-2000-129029.sid", "SID")
local date = ProtoField.float("nmea-2000-129029.date", "Date (d)")
local time = ProtoField.float("nmea-2000-129029.time", "Time (s)")
local latitude = ProtoField.float("nmea-2000-129029.latitude", "Latitude (deg)")
local longitude = ProtoField.float("nmea-2000-129029.longitude", "Longitude (deg)")
local altitude = ProtoField.float("nmea-2000-129029.altitude", "Altitude (m)")
local gnssType = ProtoField.uint8("nmea-2000-129029.gnssType", "GNSS type", base.DEC, NULL, 0xf)
local method = ProtoField.uint8("nmea-2000-129029.method", "Method", base.DEC, NULL, 0xf0)
local integrity = ProtoField.uint8("nmea-2000-129029.integrity", "Integrity", base.DEC, NULL, 0x3)
local numberOfSvs = ProtoField.float("nmea-2000-129029.numberOfSvs", "Number of SVs")
local hdop = ProtoField.float("nmea-2000-129029.hdop", "HDOP")
local pdop = ProtoField.float("nmea-2000-129029.pdop", "PDOP")
local geoidalSeparation = ProtoField.float("nmea-2000-129029.geoidalSeparation", "Geoidal Separation (m)")
local referenceStations = ProtoField.float("nmea-2000-129029.referenceStations", "Reference Stations")
local referenceStationType = ProtoField.uint8("nmea-2000-129029.referenceStationType", "Reference Station Type", base.DEC, NULL, 0xf)
local ageOfDgnssCorrections = ProtoField.float("nmea-2000-129029.ageOfDgnssCorrections", "Age of DGNSS Corrections (s)")

NMEA_2000_129029.fields = {sid,date,time,latitude,longitude,altitude,gnssType,method,integrity,numberOfSvs,hdop,pdop,geoidalSeparation,referenceStations,referenceStationType,ageOfDgnssCorrections}

function NMEA_2000_129029.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129029 (GNSS Position Data)"
    local subtree = tree:add(NMEA_2000_129029, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(date, buffer(str_offset + 1, 2), buffer(str_offset + 1, 2):le_uint() * 1)
    subtree:add(time, buffer(str_offset + 3, 4), buffer(str_offset + 3, 4):le_uint() * 0.0001)
    subtree:add(latitude, buffer(str_offset + 7, 8), buffer(str_offset + 7, 8):le_int() * 1e-16)
    subtree:add(longitude, buffer(str_offset + 15, 8), buffer(str_offset + 15, 8):le_int() * 1e-16)
    subtree:add(altitude, buffer(str_offset + 23, 8), buffer(str_offset + 23, 8):le_int() * 1e-06)
    subtree:add(gnssType, buffer(str_offset + 31, 1))
    subtree:add(method, buffer(str_offset + 31, 1))
    subtree:add(integrity, buffer(str_offset + 32, 1))
    subtree:add(numberOfSvs, buffer(str_offset + 33, 1), buffer(str_offset + 33, 1):le_uint() * 1)
    subtree:add(hdop, buffer(str_offset + 34, 2), buffer(str_offset + 34, 2):le_int() * 0.01)
    subtree:add(pdop, buffer(str_offset + 36, 2), buffer(str_offset + 36, 2):le_int() * 0.01)
    subtree:add(geoidalSeparation, buffer(str_offset + 38, 4), buffer(str_offset + 38, 4):le_int() * 0.01)
    subtree:add(referenceStations, buffer(str_offset + 42, 1), buffer(str_offset + 42, 1):le_uint() * 1)
    subtree:add(referenceStationType, buffer(str_offset + 43, 1))
    subtree:add(ageOfDgnssCorrections, buffer(str_offset + 45, 2), buffer(str_offset + 45, 2):le_uint() * 0.01)
end

return NMEA_2000_129029
