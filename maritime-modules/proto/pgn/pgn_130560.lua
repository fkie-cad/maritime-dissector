-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130560 = Proto("nmea-2000-130560", "Payload Mass (130560)")
local sid = ProtoField.uint8("nmea-2000-130560.sid", "SID")
local measurementStatus = ProtoField.uint32("nmea-2000-130560.measurementStatus", "Measurement Status")
local measurementId = ProtoField.uint8("nmea-2000-130560.measurementId", "Measurement ID")
local payloadMass = ProtoField.uint32("nmea-2000-130560.payloadMass", "Payload Mass")

NMEA_2000_130560.fields = {sid,measurementStatus,measurementId,payloadMass}

function NMEA_2000_130560.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130560 (Payload Mass)"
    local subtree = tree:add(NMEA_2000_130560, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sid, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        local _rng = buffer(str_offset + 1, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 3)
        subtree:add(measurementStatus, _rng, _val)
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(measurementId, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 3 + 4) then
        subtree:add_le(payloadMass, buffer(str_offset + 3, 4))
    end
end

return NMEA_2000_130560
