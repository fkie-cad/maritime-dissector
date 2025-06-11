-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127493 = Proto("nmea-2000-127493", "Transmission Parameters, Dynamic (127493)")
local instance = ProtoField.uint8("nmea-2000-127493.instance", "Instance", base.DEC, NULL, 0xff)
local transmissionGear = ProtoField.uint8("nmea-2000-127493.transmissionGear", "Transmission Gear", base.DEC, NULL, 0x3)
local oilPressure = ProtoField.float("nmea-2000-127493.oilPressure", "Oil pressure (Pa)")
local oilTemperature = ProtoField.float("nmea-2000-127493.oilTemperature", "Oil temperature (K)")
local discreteStatus1 = ProtoField.float("nmea-2000-127493.discreteStatus1", "Discrete Status 1")

NMEA_2000_127493.fields = {instance,transmissionGear,oilPressure,oilTemperature,discreteStatus1}

function NMEA_2000_127493.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127493 (Transmission Parameters, Dynamic)"
    local subtree = tree:add(NMEA_2000_127493, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(instance, buffer(str_offset + 0, 1))
    subtree:add(transmissionGear, buffer(str_offset + 1, 1))
    subtree:add(oilPressure, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 100)
    subtree:add(oilTemperature, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 0.1)
    subtree:add(discreteStatus1, buffer(str_offset + 6, 1), buffer(str_offset + 6, 1):le_uint() * 1)
end

return NMEA_2000_127493
