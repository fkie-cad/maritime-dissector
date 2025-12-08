-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129549 = Proto("nmea-2000-129549", "DGNSS Corrections (129549)")
local sid = ProtoField.uint8("nmea-2000-129549.sid", "SID")
local referenceStationId = ProtoField.uint32("nmea-2000-129549.referenceStationId", "Reference Station ID")
local referenceStationType = ProtoField.uint8("nmea-2000-129549.referenceStationType", "Reference Station Type", base.DEC, NULL, 0xf0)
local timeOfCorrections = ProtoField.float("nmea-2000-129549.timeOfCorrections", "Time of corrections (s)")
local stationHealth = ProtoField.uint8("nmea-2000-129549.stationHealth", "Station Health", base.DEC, NULL, 0xf)
local satelliteId = ProtoField.uint8("nmea-2000-129549.satelliteId", "Satellite ID")
local prc = ProtoField.float("nmea-2000-129549.prc", "PRC (m)")
local rrc = ProtoField.float("nmea-2000-129549.rrc", "RRC (m/s)")
local udre = ProtoField.float("nmea-2000-129549.udre", "UDRE (m)")
local iod = ProtoField.uint8("nmea-2000-129549.iod", "IOD")

NMEA_2000_129549.fields = {sid,referenceStationId,referenceStationType,timeOfCorrections,stationHealth,satelliteId,prc,rrc,udre,iod}

function NMEA_2000_129549.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129549 (DGNSS Corrections)"
    local subtree = tree:add(NMEA_2000_129549, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sid, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 2) then
        local _rng = buffer(str_offset + 1, 2)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 12)
        subtree:add(referenceStationId, _rng, _val)
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(referenceStationType, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 3 + 2) then
        subtree:add(timeOfCorrections, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_uint() * 0.1)
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        subtree:add(stationHealth, buffer(str_offset + 5, 1))
    end
    if buffer:len() >= (str_offset + 6 + 1) then
        subtree:add(satelliteId, buffer(str_offset + 6, 1))
    end
    if buffer:len() >= (str_offset + 7 + 4) then
        subtree:add(prc, buffer(str_offset + 7, 4), buffer(str_offset + 7, 4):le_int() * 0.0001)
    end
    if buffer:len() >= (str_offset + 11 + 2) then
        subtree:add(rrc, buffer(str_offset + 11, 2), buffer(str_offset + 11, 2):le_int() * 0.0001)
    end
    if buffer:len() >= (str_offset + 13 + 2) then
        subtree:add(udre, buffer(str_offset + 13, 2), buffer(str_offset + 13, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 15 + 1) then
        subtree:add(iod, buffer(str_offset + 15, 1))
    end
end

return NMEA_2000_129549
