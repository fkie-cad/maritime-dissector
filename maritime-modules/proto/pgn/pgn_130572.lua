-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130572 = Proto("nmea-2000-130572", "Library Data Search (130572)")
local source = ProtoField.uint8("nmea-2000-130572.source", "Source", base.DEC, NULL, 0xff)
local number = ProtoField.uint8("nmea-2000-130572.number", "Number")
local groupId = ProtoField.uint32("nmea-2000-130572.groupId", "Group ID")
local groupType1 = ProtoField.uint8("nmea-2000-130572.groupType1", "Group type 1", base.DEC, NULL, 0xff)
local groupName1 = ProtoField.string("nmea-2000-130572.groupName1", "Group name 1")
local groupType2 = ProtoField.uint8("nmea-2000-130572.groupType2", "Group type 2", base.DEC)
local groupName2 = ProtoField.string("nmea-2000-130572.groupName2", "Group name 2")
local groupType3 = ProtoField.uint8("nmea-2000-130572.groupType3", "Group type 3", base.DEC)
local groupName3 = ProtoField.string("nmea-2000-130572.groupName3", "Group name 3")

NMEA_2000_130572.fields = {source,number,groupId,groupType1,groupName1,groupType2,groupName2,groupType3,groupName3}

function NMEA_2000_130572.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130572 (Library Data Search)"
    local subtree = tree:add(NMEA_2000_130572, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(source, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(number, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 4) then
        subtree:add_le(groupId, buffer(str_offset + 2, 4))
    end
    if buffer:len() >= (str_offset + 6 + 1) then
        subtree:add(groupType1, buffer(str_offset + 6, 1))
    end
    if buffer:len() >= (str_offset + 7 + 1) then
        length = buffer(str_offset + 7, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 7 + 2 + length) then
            -- type = buffer(str_offset + 7 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(groupName1, buffer(str_offset + 7 + 2, length))
            str_offset = str_offset + 7 + length + 2
        end
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(groupType2, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 1) then
        length = buffer(str_offset, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 2 + length) then
            -- type = buffer(str_offset + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(groupName2, buffer(str_offset + 2, length))
            str_offset = str_offset + length + 2
        end
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(groupType3, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 1) then
        length = buffer(str_offset, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 2 + length) then
            -- type = buffer(str_offset + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(groupName3, buffer(str_offset + 2, length))
            str_offset = str_offset + length + 2
        end
    end
end

return NMEA_2000_130572
