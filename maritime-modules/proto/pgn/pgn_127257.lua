-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127257 = Proto("nmea-2000-127257", "Attitude (127257)")
local sid = ProtoField.uint8("nmea-2000-127257.sid", "SID")
local yaw = ProtoField.float("nmea-2000-127257.yaw", "Yaw (rad)")
local pitch = ProtoField.float("nmea-2000-127257.pitch", "Pitch (rad)")
local roll = ProtoField.float("nmea-2000-127257.roll", "Roll (rad)")

NMEA_2000_127257.fields = {sid,yaw,pitch,roll}

function NMEA_2000_127257.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127257 (Attitude)"
    local subtree = tree:add(NMEA_2000_127257, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sid, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 2) then
        subtree:add(yaw, buffer(str_offset + 1, 2), buffer(str_offset + 1, 2):le_int() * 0.0001)
    end
    if buffer:len() >= (str_offset + 3 + 2) then
        subtree:add(pitch, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_int() * 0.0001)
    end
    if buffer:len() >= (str_offset + 5 + 2) then
        subtree:add(roll, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_int() * 0.0001)
    end
end

return NMEA_2000_127257
