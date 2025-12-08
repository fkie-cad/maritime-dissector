-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_126976 = Proto("nmea-2000-126976", "0x1F000-0x1FEFF: Standardized mixed single/fast packet non-addressed (126976)")
local data = ProtoField.bytes("nmea-2000-126976.data", "Data")

NMEA_2000_126976.fields = {data}

function NMEA_2000_126976.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 126976 (0x1F000-0x1FEFF: Standardized mixed single/fast packet non-addressed)"
    local subtree = tree:add(NMEA_2000_126976, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 223) then
        subtree:add(data, buffer(str_offset, 223))
    end
end

return NMEA_2000_126976
