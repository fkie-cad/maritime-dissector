-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130314 = Proto("nmea-2000-130314", "Actual Pressure (130314)")
local sid = ProtoField.float("nmea-2000-130314.sid", "SID")
local instance = ProtoField.float("nmea-2000-130314.instance", "Instance")
local source = ProtoField.uint8("nmea-2000-130314.source", "Source", base.DEC, NULL, 0xff)
local pressure = ProtoField.float("nmea-2000-130314.pressure", "Pressure (Pa)")

NMEA_2000_130314.fields = {sid,instance,source,pressure}

function NMEA_2000_130314.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130314 (Actual Pressure)"
    local subtree = tree:add(NMEA_2000_130314, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(instance, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(source, buffer(str_offset + 2, 1))
    subtree:add(pressure, buffer(str_offset + 3, 4), buffer(str_offset + 3, 4):le_int() * 0.1)
end

return NMEA_2000_130314
