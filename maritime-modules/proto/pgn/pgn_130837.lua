-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130837 = Proto("nmea-2000-130837", "Maretron: Switch Status Timer (130837)")
local manufacturerCode = ProtoField.uint32("nmea-2000-130837.manufacturerCode", "Manufacturer Code")
local industryCode = ProtoField.uint8("nmea-2000-130837.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local instance = ProtoField.uint8("nmea-2000-130837.instance", "Instance")
local indicatorNumber = ProtoField.uint8("nmea-2000-130837.indicatorNumber", "Indicator Number")
local startDate = ProtoField.uint16("nmea-2000-130837.startDate", "Start Date (d)")
local startTime = ProtoField.float("nmea-2000-130837.startTime", "Start Time (s)")
local accumulatedOffPeriod = ProtoField.uint32("nmea-2000-130837.accumulatedOffPeriod", "Accumulated OFF Period (s)")
local accumulatedOnPeriod = ProtoField.uint32("nmea-2000-130837.accumulatedOnPeriod", "Accumulated ON Period (s)")
local accumulatedErrorPeriod = ProtoField.uint32("nmea-2000-130837.accumulatedErrorPeriod", "Accumulated ERROR Period (s)")
local switchStatus = ProtoField.uint8("nmea-2000-130837.switchStatus", "Switch Status", base.DEC, NULL, 0x3)

NMEA_2000_130837.fields = {manufacturerCode,industryCode,instance,indicatorNumber,startDate,startTime,accumulatedOffPeriod,accumulatedOnPeriod,accumulatedErrorPeriod,switchStatus}

function NMEA_2000_130837.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130837 (Maretron: Switch Status Timer)"
    local subtree = tree:add(NMEA_2000_130837, buffer(), subtree_title)
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
        subtree:add_le(accumulatedOffPeriod, buffer(str_offset + 10, 4))
    end
    if buffer:len() >= (str_offset + 14 + 4) then
        subtree:add_le(accumulatedOnPeriod, buffer(str_offset + 14, 4))
    end
    if buffer:len() >= (str_offset + 18 + 4) then
        subtree:add_le(accumulatedErrorPeriod, buffer(str_offset + 18, 4))
    end
    if buffer:len() >= (str_offset + 22 + 1) then
        subtree:add(switchStatus, buffer(str_offset + 22, 1))
    end
end

return NMEA_2000_130837
