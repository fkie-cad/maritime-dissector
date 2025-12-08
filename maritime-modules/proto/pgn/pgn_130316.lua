-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130316 = Proto("nmea-2000-130316", "Temperature Extended Range (130316)")
local sid = ProtoField.uint8("nmea-2000-130316.sid", "SID")
local instance = ProtoField.uint8("nmea-2000-130316.instance", "Instance")
local source = ProtoField.uint8("nmea-2000-130316.source", "Source", base.DEC, NULL, 0xff)
local temperature = ProtoField.float("nmea-2000-130316.temperature", "Temperature (K)")
local setTemperature = ProtoField.float("nmea-2000-130316.setTemperature", "Set Temperature (K)")

NMEA_2000_130316.fields = {sid,instance,source,temperature,setTemperature}

function NMEA_2000_130316.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130316 (Temperature Extended Range)"
    local subtree = tree:add(NMEA_2000_130316, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sid, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(instance, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(source, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 3 + 3) then
        subtree:add(temperature, buffer(str_offset + 3, 3), buffer(str_offset + 3, 3):le_uint() * 0.001)
    end
    if buffer:len() >= (str_offset + 6 + 2) then
        subtree:add(setTemperature, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 0.1)
    end
end

return NMEA_2000_130316
