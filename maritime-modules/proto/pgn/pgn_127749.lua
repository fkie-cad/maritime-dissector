-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127749 = Proto("nmea-2000-127749", "AC Voltage / Frequency - Phase C (127749)")
local sid = ProtoField.uint8("nmea-2000-127749.sid", "SID")
local connectionNumber = ProtoField.uint8("nmea-2000-127749.connectionNumber", "Connection Number")
local acVoltageLineToNeutral = ProtoField.float("nmea-2000-127749.acVoltageLineToNeutral", "AC Voltage Line to Neutral (V)")
local acVoltageLineToLine = ProtoField.float("nmea-2000-127749.acVoltageLineToLine", "AC Voltage Line to Line (V)")
local frequency = ProtoField.float("nmea-2000-127749.frequency", "Frequency (Hz)")

NMEA_2000_127749.fields = {sid,connectionNumber,acVoltageLineToNeutral,acVoltageLineToLine,frequency}

function NMEA_2000_127749.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127749 (AC Voltage / Frequency - Phase C)"
    local subtree = tree:add(NMEA_2000_127749, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sid, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(connectionNumber, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add(acVoltageLineToNeutral, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 0.1)
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add(acVoltageLineToLine, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 0.1)
    end
    if buffer:len() >= (str_offset + 6 + 2) then
        subtree:add(frequency, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 0.1)
    end
end

return NMEA_2000_127749
