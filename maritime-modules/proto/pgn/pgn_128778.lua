-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128778 = Proto("nmea-2000-128778", "Anchor Windlass Monitoring Status (128778)")
local sid = ProtoField.float("nmea-2000-128778.sid", "SID")
local windlassId = ProtoField.float("nmea-2000-128778.windlassId", "Windlass ID")
local controllerVoltage = ProtoField.float("nmea-2000-128778.controllerVoltage", "Controller voltage (V)")
local motorCurrent = ProtoField.float("nmea-2000-128778.motorCurrent", "Motor current (A)")
local totalMotorTime = ProtoField.float("nmea-2000-128778.totalMotorTime", "Total Motor Time (s)")

NMEA_2000_128778.fields = {sid,windlassId,controllerVoltage,motorCurrent,totalMotorTime}

function NMEA_2000_128778.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128778 (Anchor Windlass Monitoring Status)"
    local subtree = tree:add(NMEA_2000_128778, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(windlassId, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(controllerVoltage, buffer(str_offset + 3, 1), buffer(str_offset + 3, 1):le_uint() * 0.2)
    subtree:add(motorCurrent, buffer(str_offset + 4, 1), buffer(str_offset + 4, 1):le_uint() * 1)
    subtree:add(totalMotorTime, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_uint() * 60)
end

return NMEA_2000_128778
