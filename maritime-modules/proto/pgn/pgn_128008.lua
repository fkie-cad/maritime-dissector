-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128008 = Proto("nmea-2000-128008", "Thruster Motor Status (128008)")
local sid = ProtoField.float("nmea-2000-128008.sid", "SID")
local identifier = ProtoField.float("nmea-2000-128008.identifier", "Identifier")
local current = ProtoField.float("nmea-2000-128008.current", "Current (A)")
local temperature = ProtoField.float("nmea-2000-128008.temperature", "Temperature (K)")
local operatingTime = ProtoField.float("nmea-2000-128008.operatingTime", "Operating Time (s)")

NMEA_2000_128008.fields = {sid,identifier,current,temperature,operatingTime}

function NMEA_2000_128008.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128008 (Thruster Motor Status)"
    local subtree = tree:add(NMEA_2000_128008, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(identifier, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(current, buffer(str_offset + 3, 1), buffer(str_offset + 3, 1):le_uint() * 1)
    subtree:add(temperature, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 0.01)
    subtree:add(operatingTime, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 60)
end

return NMEA_2000_128008
