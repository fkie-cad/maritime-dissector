-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130847 = Proto("nmea-2000-130847", "SeaTalk: Node Statistics (130847)")
local industryCode = ProtoField.uint8("nmea-2000-130847.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local productCode = ProtoField.float("nmea-2000-130847.productCode", "Product Code")
local year = ProtoField.float("nmea-2000-130847.year", "Year")
local month = ProtoField.float("nmea-2000-130847.month", "Month")
local deviceNumber = ProtoField.float("nmea-2000-130847.deviceNumber", "Device Number")
local nodeVoltage = ProtoField.float("nmea-2000-130847.nodeVoltage", "Node Voltage (V)")

NMEA_2000_130847.fields = {industryCode,productCode,year,month,deviceNumber,nodeVoltage}

function NMEA_2000_130847.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130847 (SeaTalk: Node Statistics)"
    local subtree = tree:add(NMEA_2000_130847, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
    subtree:add(productCode, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 1)
    subtree:add(year, buffer(str_offset + 4, 1), buffer(str_offset + 4, 1):le_uint() * 1)
    subtree:add(month, buffer(str_offset + 5, 1), buffer(str_offset + 5, 1):le_uint() * 1)
    subtree:add(deviceNumber, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 1)
    subtree:add(nodeVoltage, buffer(str_offset + 8, 2), buffer(str_offset + 8, 2):le_uint() * 0.01)
end

return NMEA_2000_130847
