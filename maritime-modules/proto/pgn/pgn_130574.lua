-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130574 = Proto("nmea-2000-130574", "Supported Zone Data (130574)")
local firstZoneId = ProtoField.float("nmea-2000-130574.firstZoneId", "First zone ID")
local zoneCount = ProtoField.float("nmea-2000-130574.zoneCount", "Zone count")
local totalZoneCount = ProtoField.float("nmea-2000-130574.totalZoneCount", "Total zone count")
local zoneId = ProtoField.uint8("nmea-2000-130574.zoneId", "Zone ID", base.DEC, NULL, 0xff)
local name = ProtoField.string("nmea-2000-130574.name", "Name")

NMEA_2000_130574.fields = {firstZoneId,zoneCount,totalZoneCount,zoneId,name}

function NMEA_2000_130574.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130574 (Supported Zone Data)"
    local subtree = tree:add(NMEA_2000_130574, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(firstZoneId, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(zoneCount, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(totalZoneCount, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(zoneId, buffer(str_offset + 3, 1))
    length = buffer(str_offset + 4, 1):uint() - 2
    -- type = buffer(str_offset + 4 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(name, buffer(str_offset + 4 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_130574
