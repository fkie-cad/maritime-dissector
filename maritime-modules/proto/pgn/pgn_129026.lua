-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129026 = Proto("nmea-2000-129026", "COG & SOG, Rapid Update (129026)")
local sid = ProtoField.uint8("nmea-2000-129026.sid", "SID")
local cogReference = ProtoField.uint8("nmea-2000-129026.cogReference", "COG Reference", base.DEC, NULL, 0x3)
local cog = ProtoField.float("nmea-2000-129026.cog", "COG (rad)")
local sog = ProtoField.float("nmea-2000-129026.sog", "SOG (m/s)")

NMEA_2000_129026.fields = {sid,cogReference,cog,sog}

function NMEA_2000_129026.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129026 (COG & SOG, Rapid Update)"
    local subtree = tree:add(NMEA_2000_129026, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sid, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(cogReference, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add(cog, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 0.0001)
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add(sog, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 0.01)
    end
end

return NMEA_2000_129026
