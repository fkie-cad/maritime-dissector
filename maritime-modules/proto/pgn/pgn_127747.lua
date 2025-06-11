-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127747 = Proto("nmea-2000-127747", "AC Voltage / Frequency - Phase A (127747)")
local sid = ProtoField.float("nmea-2000-127747.sid", "SID")
local connectionNumber = ProtoField.float("nmea-2000-127747.connectionNumber", "Connection Number")
local acVoltageLineToNeutral = ProtoField.float("nmea-2000-127747.acVoltageLineToNeutral", "AC Voltage Line to Neutral (V)")
local acVoltageLineToLine = ProtoField.float("nmea-2000-127747.acVoltageLineToLine", "AC Voltage Line to Line (V)")
local frequency = ProtoField.float("nmea-2000-127747.frequency", "Frequency (Hz)")

NMEA_2000_127747.fields = {sid,connectionNumber,acVoltageLineToNeutral,acVoltageLineToLine,frequency}

function NMEA_2000_127747.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127747 (AC Voltage / Frequency - Phase A)"
    local subtree = tree:add(NMEA_2000_127747, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(connectionNumber, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(acVoltageLineToNeutral, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 0.1)
    subtree:add(acVoltageLineToLine, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 0.1)
    subtree:add(frequency, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 0.1)
end

return NMEA_2000_127747
