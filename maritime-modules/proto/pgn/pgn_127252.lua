-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127252 = Proto("nmea-2000-127252", "Heave (127252)")
local sid = ProtoField.float("nmea-2000-127252.sid", "SID")
local heave = ProtoField.float("nmea-2000-127252.heave", "Heave (m)")

NMEA_2000_127252.fields = {sid,heave}

function NMEA_2000_127252.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127252 (Heave)"
    local subtree = tree:add(NMEA_2000_127252, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(heave, buffer(str_offset + 1, 2), buffer(str_offset + 1, 2):le_int() * 0.01)
end

return NMEA_2000_127252
