-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129028 = Proto("nmea-2000-129028", "Altitude Delta, Rapid Update (129028)")
local sid = ProtoField.float("nmea-2000-129028.sid", "SID")
local timeDelta = ProtoField.float("nmea-2000-129028.timeDelta", "Time Delta (s)")
local gnssQuality = ProtoField.uint8("nmea-2000-129028.gnssQuality", "GNSS Quality", base.DEC, NULL, 0xf)
local direction = ProtoField.uint8("nmea-2000-129028.direction", "Direction", base.DEC, NULL, 0x30)
local cog = ProtoField.float("nmea-2000-129028.cog", "COG (rad)")
local altitudeDelta = ProtoField.float("nmea-2000-129028.altitudeDelta", "Altitude Delta (m)")

NMEA_2000_129028.fields = {sid,timeDelta,gnssQuality,direction,cog,altitudeDelta}

function NMEA_2000_129028.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129028 (Altitude Delta, Rapid Update)"
    local subtree = tree:add(NMEA_2000_129028, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(timeDelta, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 0.005)
    subtree:add(gnssQuality, buffer(str_offset + 2, 1))
    subtree:add(direction, buffer(str_offset + 2, 1))
    subtree:add(cog, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_uint() * 0.0001)
    subtree:add(altitudeDelta, buffer(str_offset + 5, 3), buffer(str_offset + 5, 3):le_int() * 0.001)
end

return NMEA_2000_129028
