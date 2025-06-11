-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130581 = Proto("nmea-2000-130581", "Zone Configuration (deprecated) (130581)")
local firstZoneId = ProtoField.float("nmea-2000-130581.firstZoneId", "First zone ID")
local zoneCount = ProtoField.float("nmea-2000-130581.zoneCount", "Zone count")
local totalZoneCount = ProtoField.float("nmea-2000-130581.totalZoneCount", "Total zone count")
local zoneId = ProtoField.uint8("nmea-2000-130581.zoneId", "Zone ID", base.DEC, NULL, 0xff)
local zoneName = ProtoField.string("nmea-2000-130581.zoneName", "Zone name")

NMEA_2000_130581.fields = {firstZoneId,zoneCount,totalZoneCount,zoneId,zoneName}

function NMEA_2000_130581.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130581 (Zone Configuration (deprecated))"
    local subtree = tree:add(NMEA_2000_130581, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(firstZoneId, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(zoneCount, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(totalZoneCount, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(zoneId, buffer(str_offset + 3, 1))
    length = buffer(str_offset + 4, 1):uint() - 2
    -- type = buffer(str_offset + 4 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(zoneName, buffer(str_offset + 4 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_130581
