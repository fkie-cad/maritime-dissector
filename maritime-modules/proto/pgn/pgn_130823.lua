-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130823 = Proto("nmea-2000-130823", "Maretron: Proprietary Temperature High Range (130823)")
local manufacturerCode = ProtoField.uint32("nmea-2000-130823.manufacturerCode", "Manufacturer Code")
local industryCode = ProtoField.uint8("nmea-2000-130823.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local sid = ProtoField.uint8("nmea-2000-130823.sid", "SID")
local instance = ProtoField.uint8("nmea-2000-130823.instance", "Instance")
local source = ProtoField.uint8("nmea-2000-130823.source", "Source", base.DEC, NULL, 0xff)
local actualTemperature = ProtoField.float("nmea-2000-130823.actualTemperature", "Actual Temperature (K)")
local setTemperature = ProtoField.float("nmea-2000-130823.setTemperature", "Set Temperature (K)")

NMEA_2000_130823.fields = {manufacturerCode,industryCode,sid,instance,source,actualTemperature,setTemperature}

function NMEA_2000_130823.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130823 (Maretron: Proprietary Temperature High Range)"
    local subtree = tree:add(NMEA_2000_130823, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 2) then
        local _rng = buffer(str_offset, 2)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 11)
        subtree:add(manufacturerCode, _rng, _val)
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(industryCode, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(sid, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(instance, buffer(str_offset + 3, 1))
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        subtree:add(source, buffer(str_offset + 4, 1))
    end
    if buffer:len() >= (str_offset + 5 + 2) then
        subtree:add(actualTemperature, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_uint() * 0.1)
    end
    if buffer:len() >= (str_offset + 7 + 2) then
        subtree:add(setTemperature, buffer(str_offset + 7, 2), buffer(str_offset + 7, 2):le_uint() * 0.1)
    end
end

return NMEA_2000_130823
