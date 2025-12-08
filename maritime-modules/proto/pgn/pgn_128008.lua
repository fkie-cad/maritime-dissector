-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128008 = Proto("nmea-2000-128008", "Thruster Motor Status (128008)")
local sid = ProtoField.uint8("nmea-2000-128008.sid", "SID")
local identifier = ProtoField.uint8("nmea-2000-128008.identifier", "Identifier")
local motorEvents = ProtoField.uint8("nmea-2000-128008.motorEvents", "Motor Events", base.HEX)
local current = ProtoField.uint8("nmea-2000-128008.current", "Current (A)")
local temperature = ProtoField.float("nmea-2000-128008.temperature", "Temperature (K)")
local operatingTime = ProtoField.float("nmea-2000-128008.operatingTime", "Operating Time (s)")

NMEA_2000_128008.fields = {sid,identifier,motorEvents,current,temperature,operatingTime}

function NMEA_2000_128008.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128008 (Thruster Motor Status)"
    local subtree = tree:add(NMEA_2000_128008, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sid, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(identifier, buffer(str_offset + 1, 1))
    end
    subtree:add(motorEvents, buffer(str_offset + 2, 1))
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(current, buffer(str_offset + 3, 1))
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add(temperature, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 6 + 2) then
        subtree:add(operatingTime, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 60)
    end
end

return NMEA_2000_128008
