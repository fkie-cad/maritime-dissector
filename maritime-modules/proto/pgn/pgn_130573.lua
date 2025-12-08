-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130573 = Proto("nmea-2000-130573", "Supported Source Data (130573)")
local idOffset = ProtoField.uint16("nmea-2000-130573.idOffset", "ID offset")
local idCount = ProtoField.uint16("nmea-2000-130573.idCount", "ID count")
local totalIdCount = ProtoField.uint16("nmea-2000-130573.totalIdCount", "Total ID count")
local id = ProtoField.uint8("nmea-2000-130573.id", "ID")
local source = ProtoField.uint8("nmea-2000-130573.source", "Source", base.DEC, NULL, 0xff)
local number = ProtoField.uint8("nmea-2000-130573.number", "Number")
local name = ProtoField.string("nmea-2000-130573.name", "Name")
local playSupport = ProtoField.uint32("nmea-2000-130573.playSupport", "Play support", base.HEX)
local browseSupport = ProtoField.uint16("nmea-2000-130573.browseSupport", "Browse support", base.HEX)
local thumbsSupport = ProtoField.uint32("nmea-2000-130573.thumbsSupport", "Thumbs support", base.DEC)
local connected = ProtoField.uint32("nmea-2000-130573.connected", "Connected", base.DEC)
local repeatSupport = ProtoField.uint32("nmea-2000-130573.repeatSupport", "Repeat support", base.HEX)
local shuffleSupport = ProtoField.uint32("nmea-2000-130573.shuffleSupport", "Shuffle support", base.HEX)

NMEA_2000_130573.fields = {idOffset,idCount,totalIdCount,id,source,number,name,playSupport,browseSupport,thumbsSupport,connected,repeatSupport,shuffleSupport}

function NMEA_2000_130573.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130573 (Supported Source Data)"
    local subtree = tree:add(NMEA_2000_130573, buffer(), subtree_title)
    local str_offset = 0
    local bitfield_offset = 0

    if buffer:len() >= (str_offset + 2) then
        subtree:add_le(idOffset, buffer(str_offset, 2))
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add_le(idCount, buffer(str_offset + 2, 2))
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add_le(totalIdCount, buffer(str_offset + 4, 2))
    end
    local count_1 = buffer(2, 2):le_uint()
    if count_1 > 100 then count_1 = 0 end  -- sentinel check
    local cursor_1 = str_offset
    for _i_1 = 1, count_1 do
        if cursor_1 >= buffer:len() then break end
        if buffer:len() >= (cursor_1 + 1) then
            subtree:add(id, buffer(cursor_1, 1))
            cursor_1 = cursor_1 + 1
        end
        if buffer:len() >= (cursor_1 + 1) then
            subtree:add(source, buffer(cursor_1, 1))
            cursor_1 = cursor_1 + 1
        end
        if buffer:len() >= (cursor_1 + 1) then
            subtree:add(number, buffer(cursor_1, 1))
            cursor_1 = cursor_1 + 1
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
        if buffer:len() >= (cursor_1 + 4) then
            subtree:add_le(playSupport, buffer(cursor_1, 4))
            cursor_1 = cursor_1 + 4
        end
        if buffer:len() >= (cursor_1 + 2) then
            subtree:add_le(browseSupport, buffer(cursor_1, 2))
            cursor_1 = cursor_1 + 2
        end
        if buffer:len() >= (cursor_1 + 1) then
            subtree:add(thumbsSupport, buffer(cursor_1, 1))
            cursor_1 = cursor_1 + 1
        end
        if buffer:len() >= (cursor_1 + 1) then
            subtree:add(connected, buffer(cursor_1, 1))
            cursor_1 = cursor_1 + 1
        end
        if buffer:len() >= (cursor_1 + 1) then
            subtree:add(repeatSupport, buffer(cursor_1, 1))
            cursor_1 = cursor_1 + 1
        end
        if buffer:len() >= (cursor_1 + 1) then
            subtree:add(shuffleSupport, buffer(cursor_1, 1))
            cursor_1 = cursor_1 + 1
        end
    end
end

return NMEA_2000_130573
