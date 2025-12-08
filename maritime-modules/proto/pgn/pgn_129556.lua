-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129556 = Proto("nmea-2000-129556", "GLONASS Almanac Data (129556)")
local prn = ProtoField.uint8("nmea-2000-129556.prn", "PRN")
local na = ProtoField.uint16("nmea-2000-129556.na", "NA")
local cna = ProtoField.uint32("nmea-2000-129556.cna", "CnA")
local hna = ProtoField.uint32("nmea-2000-129556.hna", "HnA")
local EpsilonNa = ProtoField.uint16("nmea-2000-129556.EpsilonNa", "(epsilon)nA")
local DeltatnaDot = ProtoField.uint8("nmea-2000-129556.DeltatnaDot", "(deltaTnA)DOT")
local OmegaNa = ProtoField.uint16("nmea-2000-129556.OmegaNa", "(omega)nA")
local DeltaTna = ProtoField.uint24("nmea-2000-129556.DeltaTna", "(delta)TnA")
local tna = ProtoField.uint24("nmea-2000-129556.tna", "tnA")
local LambdaNa = ProtoField.uint24("nmea-2000-129556.LambdaNa", "(lambda)nA")
local DeltaIna = ProtoField.uint24("nmea-2000-129556.DeltaIna", "(delta)inA")
local TauCa = ProtoField.uint32("nmea-2000-129556.TauCa", "(tau)cA")
local TauNa = ProtoField.uint32("nmea-2000-129556.TauNa", "(tau)nA")

NMEA_2000_129556.fields = {prn,na,cna,hna,EpsilonNa,DeltatnaDot,OmegaNa,DeltaTna,tna,LambdaNa,DeltaIna,TauCa,TauNa}

function NMEA_2000_129556.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129556 (GLONASS Almanac Data)"
    local subtree = tree:add(NMEA_2000_129556, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(prn, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 2) then
        subtree:add_le(na, buffer(str_offset + 1, 2))
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        local _rng = buffer(str_offset + 3, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 2)) % (2 ^ 1)
        subtree:add(cna, _rng, _val)
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        local _rng = buffer(str_offset + 3, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 3)) % (2 ^ 5)
        subtree:add(hna, _rng, _val)
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add_le(EpsilonNa, buffer(str_offset + 4, 2))
    end
    if buffer:len() >= (str_offset + 6 + 1) then
        subtree:add(DeltatnaDot, buffer(str_offset + 6, 1))
    end
    if buffer:len() >= (str_offset + 7 + 2) then
        subtree:add_le(OmegaNa, buffer(str_offset + 7, 2))
    end
    if buffer:len() >= (str_offset + 9 + 3) then
        subtree:add_le(DeltaTna, buffer(str_offset + 9, 3))
    end
    if buffer:len() >= (str_offset + 12 + 3) then
        subtree:add_le(tna, buffer(str_offset + 12, 3))
    end
    if buffer:len() >= (str_offset + 15 + 3) then
        subtree:add_le(LambdaNa, buffer(str_offset + 15, 3))
    end
    if buffer:len() >= (str_offset + 18 + 3) then
        subtree:add_le(DeltaIna, buffer(str_offset + 18, 3))
    end
    if buffer:len() >= (str_offset + 21 + 4) then
        local _rng = buffer(str_offset + 21, 4)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 28)
        subtree:add(TauCa, _rng, _val)
    end
    if buffer:len() >= (str_offset + 24 + 2) then
        local _rng = buffer(str_offset + 24, 2)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 4)) % (2 ^ 12)
        subtree:add(TauNa, _rng, _val)
    end
end

return NMEA_2000_129556
