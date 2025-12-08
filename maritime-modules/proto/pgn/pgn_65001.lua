-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_65001 = Proto("nmea-2000-65001", "Bus #1 Phase C Basic AC Quantities (65001)")
local lineLineAcRmsVoltage = ProtoField.uint16("nmea-2000-65001.lineLineAcRmsVoltage", "Line-Line AC RMS Voltage (V)")
local lineNeutralAcRmsVoltage = ProtoField.uint16("nmea-2000-65001.lineNeutralAcRmsVoltage", "Line-Neutral AC RMS Voltage (V)")
local acFrequency = ProtoField.float("nmea-2000-65001.acFrequency", "AC Frequency (Hz)")

NMEA_2000_65001.fields = {lineLineAcRmsVoltage,lineNeutralAcRmsVoltage,acFrequency}

function NMEA_2000_65001.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 65001 (Bus #1 Phase C Basic AC Quantities)"
    local subtree = tree:add(NMEA_2000_65001, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 2) then
        subtree:add_le(lineLineAcRmsVoltage, buffer(str_offset, 2))
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add_le(lineNeutralAcRmsVoltage, buffer(str_offset + 2, 2))
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add(acFrequency, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 0.0078125)
    end
end

return NMEA_2000_65001
