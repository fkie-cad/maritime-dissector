-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127251 = Proto("nmea-2000-127251", "Rate of Turn (127251)")
local sid = ProtoField.float("nmea-2000-127251.sid", "SID")
local rate = ProtoField.float("nmea-2000-127251.rate", "Rate (rad/s)")

NMEA_2000_127251.fields = {sid,rate}

function NMEA_2000_127251.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127251 (Rate of Turn)"
    local subtree = tree:add(NMEA_2000_127251, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(rate, buffer(str_offset + 1, 4), buffer(str_offset + 1, 4):le_int() * 3.125e-08)
end

return NMEA_2000_127251
