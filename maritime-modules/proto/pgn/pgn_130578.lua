-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130578 = Proto("nmea-2000-130578", "Vessel Speed Components (130578)")
local longitudinalSpeedWaterReferenced = ProtoField.float("nmea-2000-130578.longitudinalSpeedWaterReferenced", "Longitudinal Speed, Water-referenced (m/s)")
local transverseSpeedWaterReferenced = ProtoField.float("nmea-2000-130578.transverseSpeedWaterReferenced", "Transverse Speed, Water-referenced (m/s)")
local longitudinalSpeedGroundReferenced = ProtoField.float("nmea-2000-130578.longitudinalSpeedGroundReferenced", "Longitudinal Speed, Ground-referenced (m/s)")
local transverseSpeedGroundReferenced = ProtoField.float("nmea-2000-130578.transverseSpeedGroundReferenced", "Transverse Speed, Ground-referenced (m/s)")
local sternSpeedWaterReferenced = ProtoField.float("nmea-2000-130578.sternSpeedWaterReferenced", "Stern Speed, Water-referenced (m/s)")
local sternSpeedGroundReferenced = ProtoField.float("nmea-2000-130578.sternSpeedGroundReferenced", "Stern Speed, Ground-referenced (m/s)")

NMEA_2000_130578.fields = {longitudinalSpeedWaterReferenced,transverseSpeedWaterReferenced,longitudinalSpeedGroundReferenced,transverseSpeedGroundReferenced,sternSpeedWaterReferenced,sternSpeedGroundReferenced}

function NMEA_2000_130578.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130578 (Vessel Speed Components)"
    local subtree = tree:add(NMEA_2000_130578, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(longitudinalSpeedWaterReferenced, buffer(str_offset + 0, 2), buffer(str_offset + 0, 2):le_int() * 0.001)
    subtree:add(transverseSpeedWaterReferenced, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_int() * 0.001)
    subtree:add(longitudinalSpeedGroundReferenced, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_int() * 0.001)
    subtree:add(transverseSpeedGroundReferenced, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_int() * 0.001)
    subtree:add(sternSpeedWaterReferenced, buffer(str_offset + 8, 2), buffer(str_offset + 8, 2):le_int() * 0.001)
    subtree:add(sternSpeedGroundReferenced, buffer(str_offset + 10, 2), buffer(str_offset + 10, 2):le_int() * 0.001)
end

return NMEA_2000_130578
