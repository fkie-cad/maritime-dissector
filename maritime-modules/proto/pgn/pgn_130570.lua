-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130570 = Proto("nmea-2000-130570", "Library Data File (130570)")
local source = ProtoField.uint8("nmea-2000-130570.source", "Source", base.DEC, NULL, 0xff)
local number = ProtoField.float("nmea-2000-130570.number", "Number")
local id = ProtoField.float("nmea-2000-130570.id", "ID")
local type = ProtoField.uint8("nmea-2000-130570.type", "Type", base.DEC, NULL, 0xff)
local name = ProtoField.string("nmea-2000-130570.name", "Name")
local artistName = ProtoField.string("nmea-2000-130570.artistName", "Artist Name")
local albumName = ProtoField.string("nmea-2000-130570.albumName", "Album Name")
local stationName = ProtoField.string("nmea-2000-130570.stationName", "Station Name")

NMEA_2000_130570.fields = {source,number,id,type,name,artistName,albumName,stationName}

function NMEA_2000_130570.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130570 (Library Data File)"
    local subtree = tree:add(NMEA_2000_130570, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(source, buffer(str_offset + 0, 1))
    subtree:add(number, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(id, buffer(str_offset + 2, 4), buffer(str_offset + 2, 4):le_uint() * 1)
    subtree:add(type, buffer(str_offset + 6, 1))
    length = buffer(str_offset + 7, 1):uint() - 2
    -- type = buffer(str_offset + 7 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(name, buffer(str_offset + 7 + 2, length))
    str_offset = str_offset + length + 2
    length = buffer(str_offset + 0, 1):uint() - 2
    -- type = buffer(str_offset + 0 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(artistName, buffer(str_offset + 0 + 2, length))
    str_offset = str_offset + length + 2
    length = buffer(str_offset + 0, 1):uint() - 2
    -- type = buffer(str_offset + 0 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(albumName, buffer(str_offset + 0 + 2, length))
    str_offset = str_offset + length + 2
    length = buffer(str_offset + 0, 1):uint() - 2
    -- type = buffer(str_offset + 0 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(stationName, buffer(str_offset + 0 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_130570
