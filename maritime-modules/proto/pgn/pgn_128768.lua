-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128768 = Proto("nmea-2000-128768", "Elevator Motor Control (128768)")
local sid = ProtoField.float("nmea-2000-128768.sid", "SID")
local elevatorCarId = ProtoField.float("nmea-2000-128768.elevatorCarId", "Elevator Car ID")
local elevatorCarUsage = ProtoField.float("nmea-2000-128768.elevatorCarUsage", "Elevator Car Usage")

NMEA_2000_128768.fields = {sid,elevatorCarId,elevatorCarUsage}

function NMEA_2000_128768.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128768 (Elevator Motor Control)"
    local subtree = tree:add(NMEA_2000_128768, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(elevatorCarId, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(elevatorCarUsage, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
end

return NMEA_2000_128768
