-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130053 = Proto("nmea-2000-130053", "Loran-C Range Data (130053)")
local groupRepetitionIntervalGri = ProtoField.float("nmea-2000-130053.groupRepetitionIntervalGri", "Group Repetition Interval (GRI) (s)")
local masterRange = ProtoField.float("nmea-2000-130053.masterRange", "Master Range (s)")
local vSecondaryRange = ProtoField.float("nmea-2000-130053.vSecondaryRange", "V Secondary Range (s)")
local wSecondaryRange = ProtoField.float("nmea-2000-130053.wSecondaryRange", "W Secondary Range (s)")
local xSecondaryRange = ProtoField.float("nmea-2000-130053.xSecondaryRange", "X Secondary Range (s)")
local ySecondaryRange = ProtoField.float("nmea-2000-130053.ySecondaryRange", "Y Secondary Range (s)")
local zSecondaryRange = ProtoField.float("nmea-2000-130053.zSecondaryRange", "Z Secondary Range (s)")
local stationStatusMaster = ProtoField.uint32("nmea-2000-130053.stationStatusMaster", "Station status: Master", base.HEX)
local stationStatusV = ProtoField.uint32("nmea-2000-130053.stationStatusV", "Station status: V", base.HEX)
local stationStatusW = ProtoField.uint32("nmea-2000-130053.stationStatusW", "Station status: W", base.HEX)
local stationStatusX = ProtoField.uint32("nmea-2000-130053.stationStatusX", "Station status: X", base.HEX)
local stationStatusY = ProtoField.uint32("nmea-2000-130053.stationStatusY", "Station status: Y", base.HEX)
local stationStatusZ = ProtoField.uint32("nmea-2000-130053.stationStatusZ", "Station status: Z", base.HEX)
local mode = ProtoField.uint8("nmea-2000-130053.mode", "Mode", base.DEC, NULL, 0xf)

NMEA_2000_130053.fields = {groupRepetitionIntervalGri,masterRange,vSecondaryRange,wSecondaryRange,xSecondaryRange,ySecondaryRange,zSecondaryRange,stationStatusMaster,stationStatusV,stationStatusW,stationStatusX,stationStatusY,stationStatusZ,mode}

function NMEA_2000_130053.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130053 (Loran-C Range Data)"
    local subtree = tree:add(NMEA_2000_130053, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 4) then
        subtree:add(groupRepetitionIntervalGri, buffer(str_offset, 4), buffer(str_offset, 4):le_int() * 1e-09)
    end
    if buffer:len() >= (str_offset + 4 + 4) then
        subtree:add(masterRange, buffer(str_offset + 4, 4), buffer(str_offset + 4, 4):le_int() * 1e-09)
    end
    if buffer:len() >= (str_offset + 8 + 4) then
        subtree:add(vSecondaryRange, buffer(str_offset + 8, 4), buffer(str_offset + 8, 4):le_int() * 1e-09)
    end
    if buffer:len() >= (str_offset + 12 + 4) then
        subtree:add(wSecondaryRange, buffer(str_offset + 12, 4), buffer(str_offset + 12, 4):le_int() * 1e-09)
    end
    if buffer:len() >= (str_offset + 16 + 4) then
        subtree:add(xSecondaryRange, buffer(str_offset + 16, 4), buffer(str_offset + 16, 4):le_int() * 1e-09)
    end
    if buffer:len() >= (str_offset + 20 + 4) then
        subtree:add(ySecondaryRange, buffer(str_offset + 20, 4), buffer(str_offset + 20, 4):le_int() * 1e-09)
    end
    if buffer:len() >= (str_offset + 24 + 4) then
        subtree:add(zSecondaryRange, buffer(str_offset + 24, 4), buffer(str_offset + 24, 4):le_int() * 1e-09)
    end
    if buffer:len() >= (str_offset + 28 + 1) then
        local _rng = buffer(str_offset + 28, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 4)
        subtree:add(stationStatusMaster, _rng, _val)
    end
    if buffer:len() >= (str_offset + 28 + 1) then
        local _rng = buffer(str_offset + 28, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 4)) % (2 ^ 4)
        subtree:add(stationStatusV, _rng, _val)
    end
    if buffer:len() >= (str_offset + 29 + 1) then
        local _rng = buffer(str_offset + 29, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 4)
        subtree:add(stationStatusW, _rng, _val)
    end
    if buffer:len() >= (str_offset + 29 + 1) then
        local _rng = buffer(str_offset + 29, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 4)) % (2 ^ 4)
        subtree:add(stationStatusX, _rng, _val)
    end
    if buffer:len() >= (str_offset + 30 + 1) then
        local _rng = buffer(str_offset + 30, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 4)
        subtree:add(stationStatusY, _rng, _val)
    end
    if buffer:len() >= (str_offset + 30 + 1) then
        local _rng = buffer(str_offset + 30, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 4)) % (2 ^ 4)
        subtree:add(stationStatusZ, _rng, _val)
    end
    if buffer:len() >= (str_offset + 31 + 1) then
        subtree:add(mode, buffer(str_offset + 31, 1))
    end
end

return NMEA_2000_130053
