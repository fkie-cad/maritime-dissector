-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128007 = Proto("nmea-2000-128007", "Thruster Information (128007)")
local identifier = ProtoField.uint8("nmea-2000-128007.identifier", "Identifier")
local motorType = ProtoField.uint8("nmea-2000-128007.motorType", "Motor Type", base.DEC, NULL, 0xf)
local powerRating = ProtoField.uint16("nmea-2000-128007.powerRating", "Power Rating (W)")
local maximumTemperatureRating = ProtoField.float("nmea-2000-128007.maximumTemperatureRating", "Maximum Temperature Rating (K)")
local maximumRotationalSpeed = ProtoField.float("nmea-2000-128007.maximumRotationalSpeed", "Maximum Rotational Speed (rpm)")

NMEA_2000_128007.fields = {identifier,motorType,powerRating,maximumTemperatureRating,maximumRotationalSpeed}

function NMEA_2000_128007.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128007 (Thruster Information)"
    local subtree = tree:add(NMEA_2000_128007, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(identifier, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(motorType, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add_le(powerRating, buffer(str_offset + 2, 2))
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add(maximumTemperatureRating, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 6 + 2) then
        subtree:add(maximumRotationalSpeed, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 0.25)
    end
end

return NMEA_2000_128007
