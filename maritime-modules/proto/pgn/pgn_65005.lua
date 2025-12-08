-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_65005 = Proto("nmea-2000-65005", "Utility Total AC Energy (65005)")
local totalEnergyExport = ProtoField.uint32("nmea-2000-65005.totalEnergyExport", "Total Energy Export (kWh)")
local totalEnergyImport = ProtoField.uint32("nmea-2000-65005.totalEnergyImport", "Total Energy Import (kWh)")

NMEA_2000_65005.fields = {totalEnergyExport,totalEnergyImport}

function NMEA_2000_65005.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 65005 (Utility Total AC Energy)"
    local subtree = tree:add(NMEA_2000_65005, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 4) then
        subtree:add_le(totalEnergyExport, buffer(str_offset, 4))
    end
    if buffer:len() >= (str_offset + 4 + 4) then
        subtree:add_le(totalEnergyImport, buffer(str_offset + 4, 4))
    end
end

return NMEA_2000_65005
