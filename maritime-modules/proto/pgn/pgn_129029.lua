-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129029 = Proto("nmea-2000-129029", "GNSS Position Data (129029)")
local sid = ProtoField.uint8("nmea-2000-129029.sid", "SID")
local date = ProtoField.uint16("nmea-2000-129029.date", "Date (d)")
local time = ProtoField.float("nmea-2000-129029.time", "Time (s)")
local latitude = ProtoField.float("nmea-2000-129029.latitude", "Latitude (deg)")
local longitude = ProtoField.float("nmea-2000-129029.longitude", "Longitude (deg)")
local altitude = ProtoField.float("nmea-2000-129029.altitude", "Altitude (m)")
local gnssType = ProtoField.uint8("nmea-2000-129029.gnssType", "GNSS type", base.DEC, NULL, 0xf)
local method = ProtoField.uint8("nmea-2000-129029.method", "Method", base.DEC, NULL, 0xf0)
local integrity = ProtoField.uint8("nmea-2000-129029.integrity", "Integrity", base.DEC, NULL, 0x3)
local numberOfSvs = ProtoField.uint8("nmea-2000-129029.numberOfSvs", "Number of SVs")
local hdop = ProtoField.float("nmea-2000-129029.hdop", "HDOP")
local pdop = ProtoField.float("nmea-2000-129029.pdop", "PDOP")
local geoidalSeparation = ProtoField.float("nmea-2000-129029.geoidalSeparation", "Geoidal Separation (m)")
local referenceStations = ProtoField.uint8("nmea-2000-129029.referenceStations", "Reference Stations")
local referenceStationType = ProtoField.uint8("nmea-2000-129029.referenceStationType", "Reference Station Type", base.DEC, NULL, 0xf)
local referenceStationId = ProtoField.uint32("nmea-2000-129029.referenceStationId", "Reference Station ID")
local ageOfDgnssCorrections = ProtoField.float("nmea-2000-129029.ageOfDgnssCorrections", "Age of DGNSS Corrections (s)")

NMEA_2000_129029.fields = {sid,date,time,latitude,longitude,altitude,gnssType,method,integrity,numberOfSvs,hdop,pdop,geoidalSeparation,referenceStations,referenceStationType,referenceStationId,ageOfDgnssCorrections}

function NMEA_2000_129029.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129029 (GNSS Position Data)"
    local subtree = tree:add(NMEA_2000_129029, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sid, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 2) then
        subtree:add_le(date, buffer(str_offset + 1, 2))
    end
    if buffer:len() >= (str_offset + 3 + 4) then
        subtree:add(time, buffer(str_offset + 3, 4), buffer(str_offset + 3, 4):le_uint() * 0.0001)
    end
    if buffer:len() >= (str_offset + 7 + 8) then
        subtree:add(latitude, buffer(str_offset + 7, 8), buffer(str_offset + 7, 8):le_int64():tonumber() * 1e-16)
    end
    if buffer:len() >= (str_offset + 15 + 8) then
        subtree:add(longitude, buffer(str_offset + 15, 8), buffer(str_offset + 15, 8):le_int64():tonumber() * 1e-16)
    end
    if buffer:len() >= (str_offset + 23 + 8) then
        subtree:add(altitude, buffer(str_offset + 23, 8), buffer(str_offset + 23, 8):le_int64():tonumber() * 1e-06)
    end
    if buffer:len() >= (str_offset + 31 + 1) then
        subtree:add(gnssType, buffer(str_offset + 31, 1))
    end
    if buffer:len() >= (str_offset + 31 + 1) then
        subtree:add(method, buffer(str_offset + 31, 1))
    end
    if buffer:len() >= (str_offset + 32 + 1) then
        subtree:add(integrity, buffer(str_offset + 32, 1))
    end
    if buffer:len() >= (str_offset + 33 + 1) then
        subtree:add(numberOfSvs, buffer(str_offset + 33, 1))
    end
    if buffer:len() >= (str_offset + 34 + 2) then
        subtree:add(hdop, buffer(str_offset + 34, 2), buffer(str_offset + 34, 2):le_int() * 0.01)
    end
    if buffer:len() >= (str_offset + 36 + 2) then
        subtree:add(pdop, buffer(str_offset + 36, 2), buffer(str_offset + 36, 2):le_int() * 0.01)
    end
    if buffer:len() >= (str_offset + 38 + 4) then
        subtree:add(geoidalSeparation, buffer(str_offset + 38, 4), buffer(str_offset + 38, 4):le_int() * 0.01)
    end
    if buffer:len() >= (str_offset + 42 + 1) then
        subtree:add(referenceStations, buffer(str_offset + 42, 1))
    end
    local count_1 = buffer(str_offset + 42, 1):uint()
    if count_1 > 100 then count_1 = 0 end  -- likely 'not available' sentinel
    local rep_offset_1 = str_offset + 43
    for _i_1 = 1, count_1 do
    if rep_offset_1 + 4 > buffer:len() then break end
    do
        local _start = rep_offset_1 + 0
        if buffer:len() >= (_start + 1) then
            local _rng = buffer(_start, 1)
            local _raw = _rng:le_uint()
            local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 4)
            subtree:add(referenceStationType, _rng, _val)
        end
    end
    do
        local _start = rep_offset_1 + 0
        if buffer:len() >= (_start + 2) then
            local _rng = buffer(_start, 2)
            local _raw = _rng:le_uint()
            local _val = math.floor(_raw / (2 ^ 4)) % (2 ^ 12)
            subtree:add(referenceStationId, _rng, _val)
        end
    end
    do
        local _start = rep_offset_1 + 2
        if buffer:len() >= (_start + 2) then
            local _rng = buffer(_start, 2)
            local _raw = _rng:le_uint()
            local _val = _raw
            subtree:add(ageOfDgnssCorrections, _rng, _val * 0.01)
        end
    end
    rep_offset_1 = rep_offset_1 + 4
    end
end

return NMEA_2000_129029
