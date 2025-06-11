-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127506 = Proto("nmea-2000-127506", "DC Detailed Status (127506)")
local sid = ProtoField.float("nmea-2000-127506.sid", "SID")
local instance = ProtoField.float("nmea-2000-127506.instance", "Instance")
local dcType = ProtoField.uint8("nmea-2000-127506.dcType", "DC Type", base.DEC, NULL, 0xff)
local stateOfCharge = ProtoField.float("nmea-2000-127506.stateOfCharge", "State of Charge (%)")
local stateOfHealth = ProtoField.float("nmea-2000-127506.stateOfHealth", "State of Health (%)")
local timeRemaining = ProtoField.float("nmea-2000-127506.timeRemaining", "Time Remaining (s)")
local rippleVoltage = ProtoField.float("nmea-2000-127506.rippleVoltage", "Ripple Voltage (V)")
local remainingCapacity = ProtoField.float("nmea-2000-127506.remainingCapacity", "Remaining capacity (C)")

NMEA_2000_127506.fields = {sid,instance,dcType,stateOfCharge,stateOfHealth,timeRemaining,rippleVoltage,remainingCapacity}

function NMEA_2000_127506.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127506 (DC Detailed Status)"
    local subtree = tree:add(NMEA_2000_127506, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(instance, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(dcType, buffer(str_offset + 2, 1))
    subtree:add(stateOfCharge, buffer(str_offset + 3, 1), buffer(str_offset + 3, 1):le_uint() * 1)
    subtree:add(stateOfHealth, buffer(str_offset + 4, 1), buffer(str_offset + 4, 1):le_uint() * 1)
    subtree:add(timeRemaining, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_uint() * 60)
    subtree:add(rippleVoltage, buffer(str_offset + 7, 2), buffer(str_offset + 7, 2):le_uint() * 0.001)
    subtree:add(remainingCapacity, buffer(str_offset + 9, 2), buffer(str_offset + 9, 2):le_uint() * 3600)
end

return NMEA_2000_127506
