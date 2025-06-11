-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130572 = Proto("nmea-2000-130572", "Library Data Search (130572)")
local source = ProtoField.uint8("nmea-2000-130572.source", "Source", base.DEC, NULL, 0xff)
local number = ProtoField.float("nmea-2000-130572.number", "Number")
local groupId = ProtoField.float("nmea-2000-130572.groupId", "Group ID")
local groupType1 = ProtoField.uint8("nmea-2000-130572.groupType1", "Group type 1", base.DEC, NULL, 0xff)
local groupName1 = ProtoField.string("nmea-2000-130572.groupName1", "Group name 1")
local groupName2 = ProtoField.string("nmea-2000-130572.groupName2", "Group name 2")
local groupName3 = ProtoField.string("nmea-2000-130572.groupName3", "Group name 3")

NMEA_2000_130572.fields = {source,number,groupId,groupType1,groupName1,groupName2,groupName3}

function NMEA_2000_130572.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130572 (Library Data Search)"
    local subtree = tree:add(NMEA_2000_130572, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(source, buffer(str_offset + 0, 1))
    subtree:add(number, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(groupId, buffer(str_offset + 2, 4), buffer(str_offset + 2, 4):le_uint() * 1)
    subtree:add(groupType1, buffer(str_offset + 6, 1))
    length = buffer(str_offset + 7, 1):uint() - 2
    -- type = buffer(str_offset + 7 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(groupName1, buffer(str_offset + 7 + 2, length))
    str_offset = str_offset + length + 2
    length = buffer(str_offset + 0, 1):uint() - 2
    -- type = buffer(str_offset + 0 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(groupName2, buffer(str_offset + 0 + 2, length))
    str_offset = str_offset + length + 2
    length = buffer(str_offset + 0, 1):uint() - 2
    -- type = buffer(str_offset + 0 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(groupName3, buffer(str_offset + 0 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_130572
