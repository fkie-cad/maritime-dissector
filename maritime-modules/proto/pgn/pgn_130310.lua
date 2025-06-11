-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130310 = Proto("nmea-2000-130310", "Environmental Parameters (obsolete) (130310)")
local sid = ProtoField.float("nmea-2000-130310.sid", "SID")
local waterTemperature = ProtoField.float("nmea-2000-130310.waterTemperature", "Water Temperature (K)")
local outsideAmbientAirTemperature = ProtoField.float("nmea-2000-130310.outsideAmbientAirTemperature", "Outside Ambient Air Temperature (K)")
local atmosphericPressure = ProtoField.float("nmea-2000-130310.atmosphericPressure", "Atmospheric Pressure (Pa)")

NMEA_2000_130310.fields = {sid,waterTemperature,outsideAmbientAirTemperature,atmosphericPressure}

function NMEA_2000_130310.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130310 (Environmental Parameters (obsolete))"
    local subtree = tree:add(NMEA_2000_130310, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(waterTemperature, buffer(str_offset + 1, 2), buffer(str_offset + 1, 2):le_uint() * 0.01)
    subtree:add(outsideAmbientAirTemperature, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_uint() * 0.01)
    subtree:add(atmosphericPressure, buffer(str_offset + 5, 2), buffer(str_offset + 5, 2):le_uint() * 100)
end

return NMEA_2000_130310
