-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130850 = Proto("nmea-2000-130850", "Simnet: Alarm (130850)")
local industryCode = ProtoField.uint8("nmea-2000-130850.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local address = ProtoField.float("nmea-2000-130850.address", "Address")
local proprietaryId = ProtoField.uint8("nmea-2000-130850.proprietaryId", "Proprietary ID", base.DEC, NULL, 0xff)
local messageId = ProtoField.float("nmea-2000-130850.messageId", "Message ID")
local f = ProtoField.float("nmea-2000-130850.f", "F")
local g = ProtoField.float("nmea-2000-130850.g", "G")

NMEA_2000_130850.fields = {industryCode,address,proprietaryId,messageId,f,g}

function NMEA_2000_130850.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130850 (Simnet: Alarm)"
    local subtree = tree:add(NMEA_2000_130850, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
    subtree:add(address, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(proprietaryId, buffer(str_offset + 4, 1))
    subtree:add(messageId, buffer(str_offset + 8, 2), buffer(str_offset + 8, 2):le_uint() * 1)
    subtree:add(f, buffer(str_offset + 10, 1), buffer(str_offset + 10, 1):le_uint() * 1)
    subtree:add(g, buffer(str_offset + 11, 1), buffer(str_offset + 11, 1):le_uint() * 1)
end

return NMEA_2000_130850
