-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130306 = Proto("nmea-2000-130306", "Wind Data (130306)")
local sid = ProtoField.float("nmea-2000-130306.sid", "SID")
local windSpeed = ProtoField.float("nmea-2000-130306.windSpeed", "Wind Speed (m/s)")
local windAngle = ProtoField.float("nmea-2000-130306.windAngle", "Wind Angle (rad)")
local reference = ProtoField.uint8("nmea-2000-130306.reference", "Reference", base.DEC, NULL, 0x7)

NMEA_2000_130306.fields = {sid,windSpeed,windAngle,reference}

function NMEA_2000_130306.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130306 (Wind Data)"
    local subtree = tree:add(NMEA_2000_130306, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(windSpeed, buffer(str_offset + 1, 2), buffer(str_offset + 1, 2):le_uint() * 0.01)
    subtree:add(windAngle, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_uint() * 0.0001)
    subtree:add(reference, buffer(str_offset + 5, 1))
end

return NMEA_2000_130306
