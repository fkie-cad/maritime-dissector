-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129291 = Proto("nmea-2000-129291", "Set & Drift, Rapid Update (129291)")
local sid = ProtoField.float("nmea-2000-129291.sid", "SID")
local setReference = ProtoField.uint8("nmea-2000-129291.setReference", "Set Reference", base.DEC, NULL, 0x3)
local set = ProtoField.float("nmea-2000-129291.set", "Set (rad)")
local drift = ProtoField.float("nmea-2000-129291.drift", "Drift (m/s)")

NMEA_2000_129291.fields = {sid,setReference,set,drift}

function NMEA_2000_129291.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129291 (Set & Drift, Rapid Update)"
    local subtree = tree:add(NMEA_2000_129291, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(setReference, buffer(str_offset + 1, 1))
    subtree:add(set, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 0.0001)
    subtree:add(drift, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 0.01)
end

return NMEA_2000_129291
