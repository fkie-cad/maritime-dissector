-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130561 = Proto("nmea-2000-130561", "Lighting Zone (130561)")
local zoneIndex = ProtoField.float("nmea-2000-130561.zoneIndex", "Zone Index")
local zoneName = ProtoField.string("nmea-2000-130561.zoneName", "Zone Name")

NMEA_2000_130561.fields = {zoneIndex,zoneName}

function NMEA_2000_130561.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130561 (Lighting Zone)"
    local subtree = tree:add(NMEA_2000_130561, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(zoneIndex, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    length = buffer(str_offset + 1, 1):uint() - 2
    -- type = buffer(str_offset + 1 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(zoneName, buffer(str_offset + 1 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_130561
