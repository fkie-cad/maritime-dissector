-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130313 = Proto("nmea-2000-130313", "Humidity (130313)")
local sid = ProtoField.float("nmea-2000-130313.sid", "SID")
local instance = ProtoField.float("nmea-2000-130313.instance", "Instance")
local source = ProtoField.uint8("nmea-2000-130313.source", "Source", base.DEC, NULL, 0xff)
local actualHumidity = ProtoField.float("nmea-2000-130313.actualHumidity", "Actual Humidity (%)")
local setHumidity = ProtoField.float("nmea-2000-130313.setHumidity", "Set Humidity (%)")

NMEA_2000_130313.fields = {sid,instance,source,actualHumidity,setHumidity}

function NMEA_2000_130313.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130313 (Humidity)"
    local subtree = tree:add(NMEA_2000_130313, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(instance, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(source, buffer(str_offset + 2, 1))
    subtree:add(actualHumidity, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_int() * 0.004)
    subtree:add(setHumidity, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_int() * 0.004)
end

return NMEA_2000_130313
