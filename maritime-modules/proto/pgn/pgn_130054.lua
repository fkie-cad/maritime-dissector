-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130054 = Proto("nmea-2000-130054", "Loran-C Signal Data (130054)")
local groupRepetitionIntervalGri = ProtoField.float("nmea-2000-130054.groupRepetitionIntervalGri", "Group Repetition Interval (GRI) (s)")
local stationIdentifier = ProtoField.string("nmea-2000-130054.stationIdentifier", "Station identifier")
local stationSnr = ProtoField.float("nmea-2000-130054.stationSnr", "Station SNR (dB)")
local stationEcd = ProtoField.float("nmea-2000-130054.stationEcd", "Station ECD (s)")
local stationAsf = ProtoField.float("nmea-2000-130054.stationAsf", "Station ASF (s)")

NMEA_2000_130054.fields = {groupRepetitionIntervalGri,stationIdentifier,stationSnr,stationEcd,stationAsf}

function NMEA_2000_130054.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130054 (Loran-C Signal Data)"
    local subtree = tree:add(NMEA_2000_130054, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 4) then
        subtree:add(groupRepetitionIntervalGri, buffer(str_offset, 4), buffer(str_offset, 4):le_int() * 1e-09)
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        local _stationIdentifier_raw = buffer(str_offset + 4, 1):string()
        local _stationIdentifier_clean = _stationIdentifier_raw:gsub("[%s@%z\xff]+$", "")
        subtree:add(stationIdentifier, buffer(str_offset + 4, 1), _stationIdentifier_clean)
    end
    if buffer:len() >= (str_offset + 5 + 2) then
        subtree:add(stationSnr, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_int() * 0.01)
    end
    if buffer:len() >= (str_offset + 7 + 4) then
        subtree:add(stationEcd, buffer(str_offset + 7, 4), buffer(str_offset + 7, 4):le_int() * 1e-09)
    end
    if buffer:len() >= (str_offset + 11 + 4) then
        subtree:add(stationAsf, buffer(str_offset + 11, 4), buffer(str_offset + 11, 4):le_int() * 1e-09)
    end
end

return NMEA_2000_130054
