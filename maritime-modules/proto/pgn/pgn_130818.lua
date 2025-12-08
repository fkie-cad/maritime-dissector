-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130818 = Proto("nmea-2000-130818", "Furuno: Sensor setup (130818)")
local manufacturerCode = ProtoField.uint32("nmea-2000-130818.manufacturerCode", "Manufacturer Code")
local industryCode = ProtoField.uint8("nmea-2000-130818.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local rotationSmoothing = ProtoField.float("nmea-2000-130818.rotationSmoothing", "Rotation smoothing (s)")
local headingOffset = ProtoField.float("nmea-2000-130818.headingOffset", "Heading offset (deg)")
local pitchOffset = ProtoField.float("nmea-2000-130818.pitchOffset", "Pitch offset (deg)")
local rollOffset = ProtoField.float("nmea-2000-130818.rollOffset", "Roll offset (deg)")
local f8 = ProtoField.uint8("nmea-2000-130818.f8", "F8")
local f9 = ProtoField.uint8("nmea-2000-130818.f9", "F9")
local sogAndCogSmoothing = ProtoField.float("nmea-2000-130818.sogAndCogSmoothing", "SOG and COG smoothing (s)")
local _3AxisSpeedSmoothing = ProtoField.float("nmea-2000-130818._3AxisSpeedSmoothing", "3 Axis speed smoothing (s)")
local fc = ProtoField.uint16("nmea-2000-130818.fc", "FC")
local _3AxisOffset = ProtoField.float("nmea-2000-130818._3AxisOffset", "3 axis offset (%)")
local airPressureOffset = ProtoField.float("nmea-2000-130818.airPressureOffset", "Air pressure offset (Pa)")
local airTemperatureOffset = ProtoField.float("nmea-2000-130818.airTemperatureOffset", "Air temperature offset (K)")

NMEA_2000_130818.fields = {manufacturerCode,industryCode,rotationSmoothing,headingOffset,pitchOffset,rollOffset,f8,f9,sogAndCogSmoothing,_3AxisSpeedSmoothing,fc,_3AxisOffset,airPressureOffset,airTemperatureOffset}

function NMEA_2000_130818.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130818 (Furuno: Sensor setup)"
    local subtree = tree:add(NMEA_2000_130818, buffer(), subtree_title)
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
        subtree:add(rotationSmoothing, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 0.1)
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add(headingOffset, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_int() * 0.1)
    end
    if buffer:len() >= (str_offset + 6 + 2) then
        subtree:add(pitchOffset, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_int() * 0.1)
    end
    if buffer:len() >= (str_offset + 8 + 2) then
        subtree:add(rollOffset, buffer(str_offset + 8, 2), buffer(str_offset + 8, 2):le_int() * 0.1)
    end
    if buffer:len() >= (str_offset + 10 + 1) then
        subtree:add(f8, buffer(str_offset + 10, 1))
    end
    if buffer:len() >= (str_offset + 11 + 1) then
        subtree:add(f9, buffer(str_offset + 11, 1))
    end
    if buffer:len() >= (str_offset + 12 + 4) then
        subtree:add(sogAndCogSmoothing, buffer(str_offset + 12, 4), buffer(str_offset + 12, 4):le_int() * 0.001)
    end
    if buffer:len() >= (str_offset + 16 + 4) then
        subtree:add(_3AxisSpeedSmoothing, buffer(str_offset + 16, 4), buffer(str_offset + 16, 4):le_int() * 0.001)
    end
    if buffer:len() >= (str_offset + 20 + 2) then
        subtree:add_le(fc, buffer(str_offset + 20, 2))
    end
    if buffer:len() >= (str_offset + 22 + 2) then
        subtree:add(_3AxisOffset, buffer(str_offset + 22, 2), buffer(str_offset + 22, 2):le_int() * 0.00032)
    end
    if buffer:len() >= (str_offset + 24 + 2) then
        subtree:add(airPressureOffset, buffer(str_offset + 24, 2), buffer(str_offset + 24, 2):le_int() * 10)
    end
    if buffer:len() >= (str_offset + 26 + 2) then
        subtree:add(airTemperatureOffset, buffer(str_offset + 26, 2), buffer(str_offset + 26, 2):le_int() * 0.1)
    end
end

return NMEA_2000_130818
