-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128768 = Proto("nmea-2000-128768", "Elevator Motor Control (128768)")
local sid = ProtoField.uint8("nmea-2000-128768.sid", "SID")
local elevatorCarId = ProtoField.uint8("nmea-2000-128768.elevatorCarId", "Elevator Car ID")
local elevatorCarUsage = ProtoField.uint8("nmea-2000-128768.elevatorCarUsage", "Elevator Car Usage")
local motorAccelerationDecelerationProfileSelection = ProtoField.uint32("nmea-2000-128768.motorAccelerationDecelerationProfileSelection", "Motor Acceleration/Deceleration profile selection")
local motorRotationalControlStatus = ProtoField.uint32("nmea-2000-128768.motorRotationalControlStatus", "Motor Rotational Control Status")

NMEA_2000_128768.fields = {sid,elevatorCarId,elevatorCarUsage,motorAccelerationDecelerationProfileSelection,motorRotationalControlStatus}

function NMEA_2000_128768.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128768 (Elevator Motor Control)"
    local subtree = tree:add(NMEA_2000_128768, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sid, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(elevatorCarId, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(elevatorCarUsage, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        local _rng = buffer(str_offset + 3, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 4)
        subtree:add(motorAccelerationDecelerationProfileSelection, _rng, _val)
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        local _rng = buffer(str_offset + 3, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 4)) % (2 ^ 2)
        subtree:add(motorRotationalControlStatus, _rng, _val)
    end
end

return NMEA_2000_128768
