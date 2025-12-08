-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128259 = Proto("nmea-2000-128259", "Speed (128259)")
local sid = ProtoField.uint8("nmea-2000-128259.sid", "SID")
local speedWaterReferenced = ProtoField.float("nmea-2000-128259.speedWaterReferenced", "Speed Water Referenced (m/s)")
local speedGroundReferenced = ProtoField.float("nmea-2000-128259.speedGroundReferenced", "Speed Ground Referenced (m/s)")
local speedWaterReferencedType = ProtoField.uint8("nmea-2000-128259.speedWaterReferencedType", "Speed Water Referenced Type", base.DEC, NULL, 0xff)
local speedDirection = ProtoField.uint32("nmea-2000-128259.speedDirection", "Speed Direction")

NMEA_2000_128259.fields = {sid,speedWaterReferenced,speedGroundReferenced,speedWaterReferencedType,speedDirection}

function NMEA_2000_128259.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128259 (Speed)"
    local subtree = tree:add(NMEA_2000_128259, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sid, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 2) then
        subtree:add(speedWaterReferenced, buffer(str_offset + 1, 2), buffer(str_offset + 1, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 3 + 2) then
        subtree:add(speedGroundReferenced, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        subtree:add(speedWaterReferencedType, buffer(str_offset + 5, 1))
    end
    if buffer:len() >= (str_offset + 6 + 1) then
        local _rng = buffer(str_offset + 6, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 4)
        subtree:add(speedDirection, _rng, _val)
    end
end

return NMEA_2000_128259
