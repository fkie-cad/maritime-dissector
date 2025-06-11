-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130573 = Proto("nmea-2000-130573", "Supported Source Data (130573)")
local idOffset = ProtoField.float("nmea-2000-130573.idOffset", "ID offset")
local idCount = ProtoField.float("nmea-2000-130573.idCount", "ID count")
local totalIdCount = ProtoField.float("nmea-2000-130573.totalIdCount", "Total ID count")
local id = ProtoField.float("nmea-2000-130573.id", "ID")
local source = ProtoField.uint8("nmea-2000-130573.source", "Source", base.DEC, NULL, 0xff)
local number = ProtoField.float("nmea-2000-130573.number", "Number")
local name = ProtoField.string("nmea-2000-130573.name", "Name")

NMEA_2000_130573.fields = {idOffset,idCount,totalIdCount,id,source,number,name}

function NMEA_2000_130573.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130573 (Supported Source Data)"
    local subtree = tree:add(NMEA_2000_130573, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(idOffset, buffer(str_offset + 0, 2), buffer(str_offset + 0, 2):le_uint() * 1)
    subtree:add(idCount, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 1)
    subtree:add(totalIdCount, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 1)
    subtree:add(id, buffer(str_offset + 6, 1), buffer(str_offset + 6, 1):le_uint() * 1)
    subtree:add(source, buffer(str_offset + 7, 1))
    subtree:add(number, buffer(str_offset + 8, 1), buffer(str_offset + 8, 1):le_uint() * 1)
    length = buffer(str_offset + 9, 1):uint() - 2
    -- type = buffer(str_offset + 9 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(name, buffer(str_offset + 9 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_130573
