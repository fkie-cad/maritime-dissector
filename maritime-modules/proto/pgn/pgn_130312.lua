-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130312 = Proto("nmea-2000-130312", "Temperature (130312)")
local sid = ProtoField.float("nmea-2000-130312.sid", "SID")
local instance = ProtoField.float("nmea-2000-130312.instance", "Instance")
local source = ProtoField.uint8("nmea-2000-130312.source", "Source", base.DEC, NULL, 0xff)
local actualTemperature = ProtoField.float("nmea-2000-130312.actualTemperature", "Actual Temperature (K)")
local setTemperature = ProtoField.float("nmea-2000-130312.setTemperature", "Set Temperature (K)")

NMEA_2000_130312.fields = {sid,instance,source,actualTemperature,setTemperature}

function NMEA_2000_130312.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130312 (Temperature)"
    local subtree = tree:add(NMEA_2000_130312, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(instance, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(source, buffer(str_offset + 2, 1))
    subtree:add(actualTemperature, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_uint() * 0.01)
    subtree:add(setTemperature, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_uint() * 0.01)
end

return NMEA_2000_130312
