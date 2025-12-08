-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130571 = Proto("nmea-2000-130571", "Library Data Group (130571)")
local source = ProtoField.uint8("nmea-2000-130571.source", "Source", base.DEC, NULL, 0xff)
local number = ProtoField.uint8("nmea-2000-130571.number", "Number")
local type = ProtoField.uint8("nmea-2000-130571.type", "Type", base.DEC, NULL, 0xff)
local zone = ProtoField.uint8("nmea-2000-130571.zone", "Zone", base.DEC, NULL, 0xff)
local groupId = ProtoField.uint32("nmea-2000-130571.groupId", "Group ID")
local idOffset = ProtoField.uint16("nmea-2000-130571.idOffset", "ID offset")
local idCount = ProtoField.uint16("nmea-2000-130571.idCount", "ID count")
local totalIdCount = ProtoField.uint16("nmea-2000-130571.totalIdCount", "Total ID count")
local idType = ProtoField.uint8("nmea-2000-130571.idType", "ID type", base.DEC, NULL, 0xff)
local id = ProtoField.uint32("nmea-2000-130571.id", "ID")
local name = ProtoField.string("nmea-2000-130571.name", "Name")
local artist = ProtoField.string("nmea-2000-130571.artist", "Artist")

NMEA_2000_130571.fields = {source,number,type,zone,groupId,idOffset,idCount,totalIdCount,idType,id,name,artist}

function NMEA_2000_130571.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130571 (Library Data Group)"
    local subtree = tree:add(NMEA_2000_130571, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(source, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(number, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(type, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(zone, buffer(str_offset + 3, 1))
    end
    if buffer:len() >= (str_offset + 4 + 4) then
        subtree:add_le(groupId, buffer(str_offset + 4, 4))
    end
    if buffer:len() >= (str_offset + 8 + 2) then
        subtree:add_le(idOffset, buffer(str_offset + 8, 2))
    end
    if buffer:len() >= (str_offset + 10 + 2) then
        subtree:add_le(idCount, buffer(str_offset + 10, 2))
    end
    if buffer:len() >= (str_offset + 12 + 2) then
        subtree:add_le(totalIdCount, buffer(str_offset + 12, 2))
    end
    local count_1 = buffer(10, 2):le_uint()
    if count_1 > 100 then count_1 = 0 end  -- sentinel check
    local cursor_1 = str_offset
    for _i_1 = 1, count_1 do
        if cursor_1 >= buffer:len() then break end
        if buffer:len() >= (cursor_1 + 1) then
            subtree:add(idType, buffer(cursor_1, 1))
            cursor_1 = cursor_1 + 1
        end
        if buffer:len() >= (cursor_1 + 4) then
            subtree:add_le(id, buffer(cursor_1, 4))
            cursor_1 = cursor_1 + 4
        end
        if buffer:len() > cursor_1 then
            local _name_len = buffer(cursor_1, 1):uint()
            if _name_len >= 2 and buffer:len() >= (cursor_1 + _name_len) then
                subtree:add(name, buffer(cursor_1 + 2, _name_len - 2))
                cursor_1 = cursor_1 + _name_len
            elseif _name_len == 0 or _name_len == 1 then
                cursor_1 = cursor_1 + math.max(1, _name_len)  -- empty string
            else
                cursor_1 = cursor_1 + 1  -- malformed, skip length byte
            end
        end
    end
    if buffer:len() >= (str_offset + 1) then
        length = buffer(str_offset, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 2 + length) then
            -- type = buffer(str_offset + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(artist, buffer(str_offset + 2, length))
            str_offset = str_offset + length + 2
        end
    end
end

return NMEA_2000_130571
