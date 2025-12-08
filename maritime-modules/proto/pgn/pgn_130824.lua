-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130824 = Proto("nmea-2000-130824", "Maretron: Annunciator (130824)")
local manufacturerCode = ProtoField.uint32("nmea-2000-130824.manufacturerCode", "Manufacturer Code")
local industryCode = ProtoField.uint8("nmea-2000-130824.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local field4 = ProtoField.uint8("nmea-2000-130824.field4", "Field 4")
local field5 = ProtoField.uint8("nmea-2000-130824.field5", "Field 5")
local field6 = ProtoField.uint16("nmea-2000-130824.field6", "Field 6")
local field7 = ProtoField.uint8("nmea-2000-130824.field7", "Field 7")
local field8 = ProtoField.uint16("nmea-2000-130824.field8", "Field 8")

NMEA_2000_130824.fields = {manufacturerCode,industryCode,field4,field5,field6,field7,field8}

function NMEA_2000_130824.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130824 (Maretron: Annunciator)"
    local subtree = tree:add(NMEA_2000_130824, buffer(), subtree_title)
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
        subtree:add(field4, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(field5, buffer(str_offset + 3, 1))
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add_le(field6, buffer(str_offset + 4, 2))
    end
    if buffer:len() >= (str_offset + 6 + 1) then
        subtree:add(field7, buffer(str_offset + 6, 1))
    end
    if buffer:len() >= (str_offset + 7 + 2) then
        subtree:add_le(field8, buffer(str_offset + 7, 2))
    end
end

return NMEA_2000_130824
