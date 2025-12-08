-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127258 = Proto("nmea-2000-127258", "Magnetic Variation (127258)")
local sid = ProtoField.uint8("nmea-2000-127258.sid", "SID")
local source = ProtoField.uint8("nmea-2000-127258.source", "Source", base.DEC, NULL, 0xf)
local ageOfService = ProtoField.uint16("nmea-2000-127258.ageOfService", "Age of service (d)")
local variation = ProtoField.float("nmea-2000-127258.variation", "Variation (rad)")

NMEA_2000_127258.fields = {sid,source,ageOfService,variation}

function NMEA_2000_127258.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127258 (Magnetic Variation)"
    local subtree = tree:add(NMEA_2000_127258, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sid, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(source, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add_le(ageOfService, buffer(str_offset + 2, 2))
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add(variation, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_int() * 0.0001)
    end
end

return NMEA_2000_127258
