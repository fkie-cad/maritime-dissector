-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130560 = Proto("nmea-2000-130560", "Payload Mass (130560)")
local sid = ProtoField.float("nmea-2000-130560.sid", "SID")
local measurementId = ProtoField.float("nmea-2000-130560.measurementId", "Measurement ID")
local payloadMass = ProtoField.float("nmea-2000-130560.payloadMass", "Payload Mass")

NMEA_2000_130560.fields = {sid,measurementId,payloadMass}

function NMEA_2000_130560.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130560 (Payload Mass)"
    local subtree = tree:add(NMEA_2000_130560, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(measurementId, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(payloadMass, buffer(str_offset + 3, 4), buffer(str_offset + 3, 4):le_uint() * 1)
end

return NMEA_2000_130560
