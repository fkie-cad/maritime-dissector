-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130847 = Proto("nmea-2000-130847", "SeaTalk: Node Statistics (130847)")
local manufacturerCode = ProtoField.uint32("nmea-2000-130847.manufacturerCode", "Manufacturer Code")
local industryCode = ProtoField.uint8("nmea-2000-130847.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local productCode = ProtoField.uint16("nmea-2000-130847.productCode", "Product Code")
local year = ProtoField.uint8("nmea-2000-130847.year", "Year")
local month = ProtoField.uint8("nmea-2000-130847.month", "Month")
local deviceNumber = ProtoField.uint16("nmea-2000-130847.deviceNumber", "Device Number")
local nodeVoltage = ProtoField.float("nmea-2000-130847.nodeVoltage", "Node Voltage (V)")

NMEA_2000_130847.fields = {manufacturerCode,industryCode,productCode,year,month,deviceNumber,nodeVoltage}

function NMEA_2000_130847.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130847 (SeaTalk: Node Statistics)"
    local subtree = tree:add(NMEA_2000_130847, buffer(), subtree_title)
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
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add_le(productCode, buffer(str_offset + 2, 2))
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        subtree:add(year, buffer(str_offset + 4, 1))
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        subtree:add(month, buffer(str_offset + 5, 1))
    end
    if buffer:len() >= (str_offset + 6 + 2) then
        subtree:add_le(deviceNumber, buffer(str_offset + 6, 2))
    end
    if buffer:len() >= (str_offset + 8 + 2) then
        subtree:add(nodeVoltage, buffer(str_offset + 8, 2), buffer(str_offset + 8, 2):le_uint() * 0.01)
    end
end

return NMEA_2000_130847
