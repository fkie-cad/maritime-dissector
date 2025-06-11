-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127258 = Proto("nmea-2000-127258", "Magnetic Variation (127258)")
local sid = ProtoField.float("nmea-2000-127258.sid", "SID")
local source = ProtoField.uint8("nmea-2000-127258.source", "Source", base.DEC, NULL, 0xf)
local ageOfService = ProtoField.float("nmea-2000-127258.ageOfService", "Age of service (d)")
local variation = ProtoField.float("nmea-2000-127258.variation", "Variation (rad)")

NMEA_2000_127258.fields = {sid,source,ageOfService,variation}

function NMEA_2000_127258.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127258 (Magnetic Variation)"
    local subtree = tree:add(NMEA_2000_127258, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(source, buffer(str_offset + 1, 1))
    subtree:add(ageOfService, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 1)
    subtree:add(variation, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_int() * 0.0001)
end

return NMEA_2000_127258
