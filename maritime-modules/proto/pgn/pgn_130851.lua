-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130851 = Proto("nmea-2000-130851", "Simnet: Event Reply: AP command (130851)")
local industryCode = ProtoField.uint8("nmea-2000-130851.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local proprietaryId = ProtoField.uint8("nmea-2000-130851.proprietaryId", "Proprietary ID", base.DEC, NULL, 0xff)
local b = ProtoField.float("nmea-2000-130851.b", "B")
local address = ProtoField.float("nmea-2000-130851.address", "Address")
local event = ProtoField.uint8("nmea-2000-130851.event", "Event", base.DEC, NULL, 0xff)
local c = ProtoField.float("nmea-2000-130851.c", "C")
local direction = ProtoField.uint8("nmea-2000-130851.direction", "Direction", base.DEC, NULL, 0xff)
local angle = ProtoField.float("nmea-2000-130851.angle", "Angle (rad)")
local g = ProtoField.float("nmea-2000-130851.g", "G")

NMEA_2000_130851.fields = {industryCode,proprietaryId,b,address,event,c,direction,angle,g}

function NMEA_2000_130851.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130851 (Simnet: Event Reply: AP command)"
    local subtree = tree:add(NMEA_2000_130851, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
    subtree:add(proprietaryId, buffer(str_offset + 2, 1))
    subtree:add(b, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_uint() * 1)
    subtree:add(address, buffer(str_offset + 5, 1), buffer(str_offset + 5, 1):le_uint() * 1)
    subtree:add(event, buffer(str_offset + 6, 1))
    subtree:add(c, buffer(str_offset + 7, 1), buffer(str_offset + 7, 1):le_uint() * 1)
    subtree:add(direction, buffer(str_offset + 8, 1))
    subtree:add(angle, buffer(str_offset + 9, 2), buffer(str_offset + 9, 2):le_uint() * 0.0001)
    subtree:add(g, buffer(str_offset + 11, 1), buffer(str_offset + 11, 1):le_uint() * 1)
end

return NMEA_2000_130851
