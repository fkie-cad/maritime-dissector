-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130571 = Proto("nmea-2000-130571", "Library Data Group (130571)")
local source = ProtoField.uint8("nmea-2000-130571.source", "Source", base.DEC, NULL, 0xff)
local number = ProtoField.float("nmea-2000-130571.number", "Number")
local type = ProtoField.uint8("nmea-2000-130571.type", "Type", base.DEC, NULL, 0xff)
local zone = ProtoField.uint8("nmea-2000-130571.zone", "Zone", base.DEC, NULL, 0xff)
local groupId = ProtoField.float("nmea-2000-130571.groupId", "Group ID")
local idOffset = ProtoField.float("nmea-2000-130571.idOffset", "ID offset")
local idCount = ProtoField.float("nmea-2000-130571.idCount", "ID count")
local totalIdCount = ProtoField.float("nmea-2000-130571.totalIdCount", "Total ID count")
local idType = ProtoField.uint8("nmea-2000-130571.idType", "ID type", base.DEC, NULL, 0xff)
local id = ProtoField.float("nmea-2000-130571.id", "ID")
local name = ProtoField.string("nmea-2000-130571.name", "Name")
local artist = ProtoField.string("nmea-2000-130571.artist", "Artist")

NMEA_2000_130571.fields = {source,number,type,zone,groupId,idOffset,idCount,totalIdCount,idType,id,name,artist}

function NMEA_2000_130571.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130571 (Library Data Group)"
    local subtree = tree:add(NMEA_2000_130571, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(source, buffer(str_offset + 0, 1))
    subtree:add(number, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(type, buffer(str_offset + 2, 1))
    subtree:add(zone, buffer(str_offset + 3, 1))
    subtree:add(groupId, buffer(str_offset + 4, 4), buffer(str_offset + 4, 4):le_uint() * 1)
    subtree:add(idOffset, buffer(str_offset + 8, 2), buffer(str_offset + 8, 2):le_uint() * 1)
    subtree:add(idCount, buffer(str_offset + 10, 2), buffer(str_offset + 10, 2):le_uint() * 1)
    subtree:add(totalIdCount, buffer(str_offset + 12, 2), buffer(str_offset + 12, 2):le_uint() * 1)
    subtree:add(idType, buffer(str_offset + 14, 1))
    subtree:add(id, buffer(str_offset + 15, 4), buffer(str_offset + 15, 4):le_uint() * 1)
    length = buffer(str_offset + 19, 1):uint() - 2
    -- type = buffer(str_offset + 19 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(name, buffer(str_offset + 19 + 2, length))
    str_offset = str_offset + length + 2
    length = buffer(str_offset + 0, 1):uint() - 2
    -- type = buffer(str_offset + 0 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(artist, buffer(str_offset + 0 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_130571
