-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130306 = Proto("nmea-2000-130306", "Wind Data (130306)")
local sid = ProtoField.uint8("nmea-2000-130306.sid", "SID")
local windSpeed = ProtoField.float("nmea-2000-130306.windSpeed", "Wind Speed (m/s)")
local windAngle = ProtoField.float("nmea-2000-130306.windAngle", "Wind Angle (rad)")
local reference = ProtoField.uint8("nmea-2000-130306.reference", "Reference", base.DEC, NULL, 0x7)

NMEA_2000_130306.fields = {sid,windSpeed,windAngle,reference}

function NMEA_2000_130306.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130306 (Wind Data)"
    local subtree = tree:add(NMEA_2000_130306, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sid, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 2) then
        subtree:add(windSpeed, buffer(str_offset + 1, 2), buffer(str_offset + 1, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 3 + 2) then
        subtree:add(windAngle, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_uint() * 0.0001)
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        subtree:add(reference, buffer(str_offset + 5, 1))
    end
end

return NMEA_2000_130306
