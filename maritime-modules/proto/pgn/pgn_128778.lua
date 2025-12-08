-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128778 = Proto("nmea-2000-128778", "Anchor Windlass Monitoring Status (128778)")
local sid = ProtoField.uint8("nmea-2000-128778.sid", "SID")
local windlassId = ProtoField.uint8("nmea-2000-128778.windlassId", "Windlass ID")
local windlassMonitoringEvents = ProtoField.uint8("nmea-2000-128778.windlassMonitoringEvents", "Windlass Monitoring Events", base.HEX)
local controllerVoltage = ProtoField.float("nmea-2000-128778.controllerVoltage", "Controller voltage (V)")
local motorCurrent = ProtoField.uint8("nmea-2000-128778.motorCurrent", "Motor current (A)")
local totalMotorTime = ProtoField.float("nmea-2000-128778.totalMotorTime", "Total Motor Time (s)")

NMEA_2000_128778.fields = {sid,windlassId,windlassMonitoringEvents,controllerVoltage,motorCurrent,totalMotorTime}

function NMEA_2000_128778.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128778 (Anchor Windlass Monitoring Status)"
    local subtree = tree:add(NMEA_2000_128778, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sid, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(windlassId, buffer(str_offset + 1, 1))
    end
    subtree:add(windlassMonitoringEvents, buffer(str_offset + 2, 1))
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(controllerVoltage, buffer(str_offset + 3, 1), buffer(str_offset + 3, 1):le_uint() * 0.2)
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        subtree:add(motorCurrent, buffer(str_offset + 4, 1))
    end
    if buffer:len() >= (str_offset + 5 + 2) then
        subtree:add(totalMotorTime, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_uint() * 60)
    end
end

return NMEA_2000_128778
