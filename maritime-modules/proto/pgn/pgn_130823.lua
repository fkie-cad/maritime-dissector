-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130823 = Proto("nmea-2000-130823", "Maretron: Proprietary Temperature High Range (130823)")
local industryCode = ProtoField.uint8("nmea-2000-130823.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local sid = ProtoField.float("nmea-2000-130823.sid", "SID")
local instance = ProtoField.float("nmea-2000-130823.instance", "Instance")
local source = ProtoField.uint8("nmea-2000-130823.source", "Source", base.DEC, NULL, 0xff)
local actualTemperature = ProtoField.float("nmea-2000-130823.actualTemperature", "Actual Temperature (K)")
local setTemperature = ProtoField.float("nmea-2000-130823.setTemperature", "Set Temperature (K)")

NMEA_2000_130823.fields = {industryCode,sid,instance,source,actualTemperature,setTemperature}

function NMEA_2000_130823.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130823 (Maretron: Proprietary Temperature High Range)"
    local subtree = tree:add(NMEA_2000_130823, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
    subtree:add(sid, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(instance, buffer(str_offset + 3, 1), buffer(str_offset + 3, 1):le_uint() * 1)
    subtree:add(source, buffer(str_offset + 4, 1))
    subtree:add(actualTemperature, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_uint() * 0.1)
    subtree:add(setTemperature, buffer(str_offset + 7, 2), buffer(str_offset + 7, 2):le_uint() * 0.1)
end

return NMEA_2000_130823
