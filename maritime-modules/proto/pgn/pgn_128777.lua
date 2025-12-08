-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128777 = Proto("nmea-2000-128777", "Anchor Windlass Operating Status (128777)")
local sid = ProtoField.uint8("nmea-2000-128777.sid", "SID")
local windlassId = ProtoField.uint8("nmea-2000-128777.windlassId", "Windlass ID")
local windlassDirectionControl = ProtoField.uint8("nmea-2000-128777.windlassDirectionControl", "Windlass Direction Control", base.DEC, NULL, 0x3)
local windlassMotionStatus = ProtoField.uint8("nmea-2000-128777.windlassMotionStatus", "Windlass Motion Status", base.DEC, NULL, 0xc)
local rodeTypeStatus = ProtoField.uint8("nmea-2000-128777.rodeTypeStatus", "Rode Type Status", base.DEC, NULL, 0x30)
local rodeCounterValue = ProtoField.float("nmea-2000-128777.rodeCounterValue", "Rode Counter Value (m)")
local windlassLineSpeed = ProtoField.float("nmea-2000-128777.windlassLineSpeed", "Windlass Line Speed (m/s)")
local anchorDockingStatus = ProtoField.uint8("nmea-2000-128777.anchorDockingStatus", "Anchor Docking Status", base.DEC, NULL, 0x3)
local windlassOperatingEvents = ProtoField.uint32("nmea-2000-128777.windlassOperatingEvents", "Windlass Operating Events", base.HEX)

NMEA_2000_128777.fields = {sid,windlassId,windlassDirectionControl,windlassMotionStatus,rodeTypeStatus,rodeCounterValue,windlassLineSpeed,anchorDockingStatus,windlassOperatingEvents}

function NMEA_2000_128777.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128777 (Anchor Windlass Operating Status)"
    local subtree = tree:add(NMEA_2000_128777, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sid, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(windlassId, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(windlassDirectionControl, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(windlassMotionStatus, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(rodeTypeStatus, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 3 + 2) then
        subtree:add(rodeCounterValue, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_uint() * 0.1)
    end
    if buffer:len() >= (str_offset + 5 + 2) then
        subtree:add(windlassLineSpeed, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 7 + 1) then
        subtree:add(anchorDockingStatus, buffer(str_offset + 7, 1))
    end
    if buffer:len() >= (str_offset + 7 + 1) then
        local _rng = buffer(str_offset + 7, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 2)) % (2 ^ 6)
        subtree:add(windlassOperatingEvents, _rng, _val)
    end
end

return NMEA_2000_128777
