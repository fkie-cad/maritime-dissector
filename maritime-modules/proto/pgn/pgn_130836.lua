-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130836 = Proto("nmea-2000-130836", "Maretron: Switch Status Counter (130836)")
local manufacturerCode = ProtoField.uint32("nmea-2000-130836.manufacturerCode", "Manufacturer Code")
local industryCode = ProtoField.uint8("nmea-2000-130836.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local instance = ProtoField.uint8("nmea-2000-130836.instance", "Instance")
local indicatorNumber = ProtoField.uint8("nmea-2000-130836.indicatorNumber", "Indicator Number")
local startDate = ProtoField.uint16("nmea-2000-130836.startDate", "Start Date (d)")
local startTime = ProtoField.float("nmea-2000-130836.startTime", "Start Time (s)")
local offCounter = ProtoField.uint32("nmea-2000-130836.offCounter", "OFF Counter")
local onCounter = ProtoField.uint32("nmea-2000-130836.onCounter", "ON Counter")
local errorCounter = ProtoField.uint32("nmea-2000-130836.errorCounter", "ERROR Counter")
local switchStatus = ProtoField.uint8("nmea-2000-130836.switchStatus", "Switch Status", base.DEC, NULL, 0x3)

NMEA_2000_130836.fields = {manufacturerCode,industryCode,instance,indicatorNumber,startDate,startTime,offCounter,onCounter,errorCounter,switchStatus}

function NMEA_2000_130836.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130836 (Maretron: Switch Status Counter)"
    local subtree = tree:add(NMEA_2000_130836, buffer(), subtree_title)
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
        subtree:add(instance, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(indicatorNumber, buffer(str_offset + 3, 1))
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add_le(startDate, buffer(str_offset + 4, 2))
    end
    if buffer:len() >= (str_offset + 6 + 4) then
        subtree:add(startTime, buffer(str_offset + 6, 4), buffer(str_offset + 6, 4):le_uint() * 0.0001)
    end
    if buffer:len() >= (str_offset + 10 + 4) then
        subtree:add_le(offCounter, buffer(str_offset + 10, 4))
    end
    if buffer:len() >= (str_offset + 14 + 4) then
        subtree:add_le(onCounter, buffer(str_offset + 14, 4))
    end
    if buffer:len() >= (str_offset + 18 + 4) then
        subtree:add_le(errorCounter, buffer(str_offset + 18, 4))
    end
    if buffer:len() >= (str_offset + 22 + 1) then
        subtree:add(switchStatus, buffer(str_offset + 22, 1))
    end
end

return NMEA_2000_130836
