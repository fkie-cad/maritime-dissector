-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127503 = Proto("nmea-2000-127503", "AC Input Status (127503)")
local instance = ProtoField.float("nmea-2000-127503.instance", "Instance")
local numberOfLines = ProtoField.float("nmea-2000-127503.numberOfLines", "Number of Lines")
local line = ProtoField.uint8("nmea-2000-127503.line", "Line", base.DEC, NULL, 0x3)
local acceptability = ProtoField.uint8("nmea-2000-127503.acceptability", "Acceptability", base.DEC, NULL, 0xc)
local voltage = ProtoField.float("nmea-2000-127503.voltage", "Voltage (V)")
local current = ProtoField.float("nmea-2000-127503.current", "Current (A)")
local frequency = ProtoField.float("nmea-2000-127503.frequency", "Frequency (Hz)")
local breakerSize = ProtoField.float("nmea-2000-127503.breakerSize", "Breaker Size (A)")
local realPower = ProtoField.float("nmea-2000-127503.realPower", "Real Power (W)")
local reactivePower = ProtoField.float("nmea-2000-127503.reactivePower", "Reactive Power (VAR)")
local powerFactor = ProtoField.float("nmea-2000-127503.powerFactor", "Power factor (Cos Phi)")

NMEA_2000_127503.fields = {instance,numberOfLines,line,acceptability,voltage,current,frequency,breakerSize,realPower,reactivePower,powerFactor}

function NMEA_2000_127503.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127503 (AC Input Status)"
    local subtree = tree:add(NMEA_2000_127503, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(instance, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(numberOfLines, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(line, buffer(str_offset + 2, 1))
    subtree:add(acceptability, buffer(str_offset + 2, 1))
    subtree:add(voltage, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_uint() * 0.01)
    subtree:add(current, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_uint() * 0.1)
    subtree:add(frequency, buffer(str_offset + 7, 2), buffer(str_offset + 7, 2):le_uint() * 0.01)
    subtree:add(breakerSize, buffer(str_offset + 9, 2), buffer(str_offset + 9, 2):le_uint() * 0.1)
    subtree:add(realPower, buffer(str_offset + 11, 4), buffer(str_offset + 11, 4):le_uint() * 1)
    subtree:add(reactivePower, buffer(str_offset + 15, 4), buffer(str_offset + 15, 4):le_uint() * 1)
    subtree:add(powerFactor, buffer(str_offset + 19, 1), buffer(str_offset + 19, 1):le_int() * 0.01)
end

return NMEA_2000_127503
