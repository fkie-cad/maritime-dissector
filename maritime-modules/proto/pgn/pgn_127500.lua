-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127500 = Proto("nmea-2000-127500", "Load Controller Connection State/Control (127500)")
local sequenceId = ProtoField.float("nmea-2000-127500.sequenceId", "Sequence ID")
local connectionId = ProtoField.float("nmea-2000-127500.connectionId", "Connection ID")
local state = ProtoField.float("nmea-2000-127500.state", "State")
local status = ProtoField.float("nmea-2000-127500.status", "Status")
local operationalStatusControl = ProtoField.float("nmea-2000-127500.operationalStatusControl", "Operational Status & Control")
local pwmDutyCycle = ProtoField.float("nmea-2000-127500.pwmDutyCycle", "PWM Duty Cycle")
local timeon = ProtoField.float("nmea-2000-127500.timeon", "TimeON")
local timeoff = ProtoField.float("nmea-2000-127500.timeoff", "TimeOFF")

NMEA_2000_127500.fields = {sequenceId,connectionId,state,status,operationalStatusControl,pwmDutyCycle,timeon,timeoff}

function NMEA_2000_127500.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127500 (Load Controller Connection State/Control)"
    local subtree = tree:add(NMEA_2000_127500, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sequenceId, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(connectionId, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(state, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(status, buffer(str_offset + 3, 1), buffer(str_offset + 3, 1):le_uint() * 1)
    subtree:add(operationalStatusControl, buffer(str_offset + 4, 1), buffer(str_offset + 4, 1):le_uint() * 1)
    subtree:add(pwmDutyCycle, buffer(str_offset + 5, 1), buffer(str_offset + 5, 1):le_uint() * 1)
    subtree:add(timeon, buffer(str_offset + 6, 1), buffer(str_offset + 6, 1):le_uint() * 1)
    subtree:add(timeoff, buffer(str_offset + 7, 1), buffer(str_offset + 7, 1):le_uint() * 1)
end

return NMEA_2000_127500
