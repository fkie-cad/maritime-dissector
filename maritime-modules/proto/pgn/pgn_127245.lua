-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127245 = Proto("nmea-2000-127245", "Rudder (127245)")
local instance = ProtoField.uint8("nmea-2000-127245.instance", "Instance")
local directionOrder = ProtoField.uint8("nmea-2000-127245.directionOrder", "Direction Order", base.DEC, NULL, 0x7)
local angleOrder = ProtoField.float("nmea-2000-127245.angleOrder", "Angle Order (rad)")
local position = ProtoField.float("nmea-2000-127245.position", "Position (rad)")

NMEA_2000_127245.fields = {instance,directionOrder,angleOrder,position}

function NMEA_2000_127245.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127245 (Rudder)"
    local subtree = tree:add(NMEA_2000_127245, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(instance, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(directionOrder, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add(angleOrder, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_int() * 0.0001)
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add(position, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_int() * 0.0001)
    end
end

return NMEA_2000_127245
