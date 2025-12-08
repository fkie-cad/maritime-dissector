-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130577 = Proto("nmea-2000-130577", "Direction Data (130577)")
local dataMode = ProtoField.uint8("nmea-2000-130577.dataMode", "Data Mode", base.DEC, NULL, 0xf)
local cogReference = ProtoField.uint8("nmea-2000-130577.cogReference", "COG Reference", base.DEC, NULL, 0x30)
local sid = ProtoField.uint8("nmea-2000-130577.sid", "SID")
local cog = ProtoField.float("nmea-2000-130577.cog", "COG (rad)")
local sog = ProtoField.float("nmea-2000-130577.sog", "SOG (m/s)")
local heading = ProtoField.float("nmea-2000-130577.heading", "Heading (rad)")
local speedThroughWater = ProtoField.float("nmea-2000-130577.speedThroughWater", "Speed through Water (m/s)")
local set = ProtoField.float("nmea-2000-130577.set", "Set (rad)")
local drift = ProtoField.float("nmea-2000-130577.drift", "Drift (m/s)")

NMEA_2000_130577.fields = {dataMode,cogReference,sid,cog,sog,heading,speedThroughWater,set,drift}

function NMEA_2000_130577.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130577 (Direction Data)"
    local subtree = tree:add(NMEA_2000_130577, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(dataMode, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(cogReference, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(sid, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add(cog, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 0.0001)
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add(sog, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 6 + 2) then
        subtree:add(heading, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 0.0001)
    end
    if buffer:len() >= (str_offset + 8 + 2) then
        subtree:add(speedThroughWater, buffer(str_offset + 8, 2), buffer(str_offset + 8, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 10 + 2) then
        subtree:add(set, buffer(str_offset + 10, 2), buffer(str_offset + 10, 2):le_uint() * 0.0001)
    end
    if buffer:len() >= (str_offset + 12 + 2) then
        subtree:add(drift, buffer(str_offset + 12, 2), buffer(str_offset + 12, 2):le_uint() * 0.01)
    end
end

return NMEA_2000_130577
