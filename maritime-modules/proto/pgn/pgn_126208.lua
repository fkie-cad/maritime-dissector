-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_126208 = Proto("nmea-2000-126208", "NMEA - Write Fields reply group function (126208)")
local functionCode = ProtoField.uint8("nmea-2000-126208.functionCode", "Function Code", base.DEC, NULL, 0xff)
local pgn = ProtoField.float("nmea-2000-126208.pgn", "PGN")

NMEA_2000_126208.fields = {functionCode,pgn}

function NMEA_2000_126208.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 126208 (NMEA - Write Fields reply group function)"
    local subtree = tree:add(NMEA_2000_126208, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(functionCode, buffer(str_offset + 0, 1))
    subtree:add(pgn, buffer(str_offset + 1, 3), buffer(str_offset + 1, 3):le_uint() * 1)
end

return NMEA_2000_126208
