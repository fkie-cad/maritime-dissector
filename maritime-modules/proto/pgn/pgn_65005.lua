-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_65005 = Proto("nmea-2000-65005", "Utility Total AC Energy (65005)")
local totalEnergyExport = ProtoField.float("nmea-2000-65005.totalEnergyExport", "Total Energy Export (J)")
local totalEnergyImport = ProtoField.float("nmea-2000-65005.totalEnergyImport", "Total Energy Import (J)")

NMEA_2000_65005.fields = {totalEnergyExport,totalEnergyImport}

function NMEA_2000_65005.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 65005 (Utility Total AC Energy)"
    local subtree = tree:add(NMEA_2000_65005, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(totalEnergyExport, buffer(str_offset + 0, 4), buffer(str_offset + 0, 4):le_uint() * 3600000.0)
    subtree:add(totalEnergyImport, buffer(str_offset + 4, 4), buffer(str_offset + 4, 4):le_uint() * 3600000.0)
end

return NMEA_2000_65005
