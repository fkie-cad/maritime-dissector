-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130836 = Proto("nmea-2000-130836", "Maretron: Switch Status Counter (130836)")
local industryCode = ProtoField.uint8("nmea-2000-130836.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local instance = ProtoField.float("nmea-2000-130836.instance", "Instance")
local indicatorNumber = ProtoField.float("nmea-2000-130836.indicatorNumber", "Indicator Number")
local startDate = ProtoField.float("nmea-2000-130836.startDate", "Start Date (d)")
local startTime = ProtoField.float("nmea-2000-130836.startTime", "Start Time (s)")
local offCounter = ProtoField.float("nmea-2000-130836.offCounter", "OFF Counter")
local onCounter = ProtoField.float("nmea-2000-130836.onCounter", "ON Counter")
local errorCounter = ProtoField.float("nmea-2000-130836.errorCounter", "ERROR Counter")
local switchStatus = ProtoField.uint8("nmea-2000-130836.switchStatus", "Switch Status", base.DEC, NULL, 0x3)

NMEA_2000_130836.fields = {industryCode,instance,indicatorNumber,startDate,startTime,offCounter,onCounter,errorCounter,switchStatus}

function NMEA_2000_130836.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130836 (Maretron: Switch Status Counter)"
    local subtree = tree:add(NMEA_2000_130836, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
    subtree:add(instance, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(indicatorNumber, buffer(str_offset + 3, 1), buffer(str_offset + 3, 1):le_uint() * 1)
    subtree:add(startDate, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 1)
    subtree:add(startTime, buffer(str_offset + 6, 4), buffer(str_offset + 6, 4):le_uint() * 0.0001)
    subtree:add(offCounter, buffer(str_offset + 10, 4), buffer(str_offset + 10, 4):le_uint() * 1)
    subtree:add(onCounter, buffer(str_offset + 14, 4), buffer(str_offset + 14, 4):le_uint() * 1)
    subtree:add(errorCounter, buffer(str_offset + 18, 4), buffer(str_offset + 18, 4):le_uint() * 1)
    subtree:add(switchStatus, buffer(str_offset + 22, 1))
end

return NMEA_2000_130836
