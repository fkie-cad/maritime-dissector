-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129556 = Proto("nmea-2000-129556", "GLONASS Almanac Data (129556)")
local prn = ProtoField.float("nmea-2000-129556.prn", "PRN")
local na = ProtoField.float("nmea-2000-129556.na", "NA")
local EpsilonNa = ProtoField.float("nmea-2000-129556.EpsilonNa", "(epsilon)nA")
local DeltatnaDot = ProtoField.float("nmea-2000-129556.DeltatnaDot", "(deltaTnA)DOT")
local OmegaNa = ProtoField.float("nmea-2000-129556.OmegaNa", "(omega)nA")
local DeltaTna = ProtoField.float("nmea-2000-129556.DeltaTna", "(delta)TnA")
local tna = ProtoField.float("nmea-2000-129556.tna", "tnA")
local LambdaNa = ProtoField.float("nmea-2000-129556.LambdaNa", "(lambda)nA")
local DeltaIna = ProtoField.float("nmea-2000-129556.DeltaIna", "(delta)inA")

NMEA_2000_129556.fields = {prn,na,EpsilonNa,DeltatnaDot,OmegaNa,DeltaTna,tna,LambdaNa,DeltaIna}

function NMEA_2000_129556.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129556 (GLONASS Almanac Data)"
    local subtree = tree:add(NMEA_2000_129556, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(prn, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(na, buffer(str_offset + 1, 2), buffer(str_offset + 1, 2):le_uint() * 1)
    subtree:add(EpsilonNa, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 1)
    subtree:add(DeltatnaDot, buffer(str_offset + 6, 1), buffer(str_offset + 6, 1):le_uint() * 1)
    subtree:add(OmegaNa, buffer(str_offset + 7, 2), buffer(str_offset + 7, 2):le_uint() * 1)
    subtree:add(DeltaTna, buffer(str_offset + 9, 3), buffer(str_offset + 9, 3):le_uint() * 1)
    subtree:add(tna, buffer(str_offset + 12, 3), buffer(str_offset + 12, 3):le_uint() * 1)
    subtree:add(LambdaNa, buffer(str_offset + 15, 3), buffer(str_offset + 15, 3):le_uint() * 1)
    subtree:add(DeltaIna, buffer(str_offset + 18, 3), buffer(str_offset + 18, 3):le_uint() * 1)
end

return NMEA_2000_129556
