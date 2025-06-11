-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127508 = Proto("nmea-2000-127508", "Battery Status (127508)")
local instance = ProtoField.float("nmea-2000-127508.instance", "Instance")
local voltage = ProtoField.float("nmea-2000-127508.voltage", "Voltage (V)")
local current = ProtoField.float("nmea-2000-127508.current", "Current (A)")
local temperature = ProtoField.float("nmea-2000-127508.temperature", "Temperature (K)")
local sid = ProtoField.float("nmea-2000-127508.sid", "SID")

NMEA_2000_127508.fields = {instance,voltage,current,temperature,sid}

function NMEA_2000_127508.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127508 (Battery Status)"
    local subtree = tree:add(NMEA_2000_127508, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(instance, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(voltage, buffer(str_offset + 1, 2), buffer(str_offset + 1, 2):le_int() * 0.01)
    subtree:add(current, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_int() * 0.1)
    subtree:add(temperature, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_uint() * 0.01)
    subtree:add(sid, buffer(str_offset + 7, 1), buffer(str_offset + 7, 1):le_uint() * 1)
end

return NMEA_2000_127508
