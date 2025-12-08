-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130851 = Proto("nmea-2000-130851", "Simnet: Event Reply: AP command (130851)")
local manufacturerCode = ProtoField.uint32("nmea-2000-130851.manufacturerCode", "Manufacturer Code")
local industryCode = ProtoField.uint8("nmea-2000-130851.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local proprietaryId = ProtoField.uint8("nmea-2000-130851.proprietaryId", "Proprietary ID", base.DEC, NULL, 0xff)
local b = ProtoField.uint16("nmea-2000-130851.b", "B")
local address = ProtoField.uint8("nmea-2000-130851.address", "Address")
local event = ProtoField.uint8("nmea-2000-130851.event", "Event", base.DEC, NULL, 0xff)
local c = ProtoField.uint8("nmea-2000-130851.c", "C")
local direction = ProtoField.uint8("nmea-2000-130851.direction", "Direction", base.DEC, NULL, 0xff)
local angle = ProtoField.float("nmea-2000-130851.angle", "Angle (rad)")
local g = ProtoField.uint8("nmea-2000-130851.g", "G")

NMEA_2000_130851.fields = {manufacturerCode,industryCode,proprietaryId,b,address,event,c,direction,angle,g}

function NMEA_2000_130851.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130851 (Simnet: Event Reply: AP command)"
    local subtree = tree:add(NMEA_2000_130851, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 2) then
        local _rng = buffer(str_offset, 2)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 11)
        subtree:add(manufacturerCode, _rng, _val)
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(industryCode, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(proprietaryId, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 3 + 2) then
        subtree:add_le(b, buffer(str_offset + 3, 2))
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        subtree:add(address, buffer(str_offset + 5, 1))
    end
    if buffer:len() >= (str_offset + 6 + 1) then
        subtree:add(event, buffer(str_offset + 6, 1))
    end
    if buffer:len() >= (str_offset + 7 + 1) then
        subtree:add(c, buffer(str_offset + 7, 1))
    end
    if buffer:len() >= (str_offset + 8 + 1) then
        subtree:add(direction, buffer(str_offset + 8, 1))
    end
    if buffer:len() >= (str_offset + 9 + 2) then
        subtree:add(angle, buffer(str_offset + 9, 2), buffer(str_offset + 9, 2):le_uint() * 0.0001)
    end
    if buffer:len() >= (str_offset + 11 + 1) then
        subtree:add(g, buffer(str_offset + 11, 1))
    end
end

return NMEA_2000_130851
