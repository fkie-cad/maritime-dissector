-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130820 = Proto("nmea-2000-130820", "Fusion: SiriusXM Presets (130820)")
local manufacturerCode = ProtoField.uint32("nmea-2000-130820.manufacturerCode", "Manufacturer Code")
local industryCode = ProtoField.uint8("nmea-2000-130820.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local messageId = ProtoField.uint32("nmea-2000-130820.messageId", "Message ID")
local sourceId = ProtoField.uint8("nmea-2000-130820.sourceId", "Source ID")
local count = ProtoField.uint8("nmea-2000-130820.count", "Count")
local values = ProtoField.bytes("nmea-2000-130820.values", "Values")

NMEA_2000_130820.fields = {manufacturerCode,industryCode,messageId,sourceId,count,values}

function NMEA_2000_130820.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130820 (Fusion: SiriusXM Presets)"
    local subtree = tree:add(NMEA_2000_130820, buffer(), subtree_title)
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
    if buffer:len() >= (str_offset + 2 + 2) then
        local _rng = buffer(str_offset + 2, 2)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 16)
        subtree:add(messageId, _rng, _val)
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        subtree:add(sourceId, buffer(str_offset + 4, 1))
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        subtree:add(count, buffer(str_offset + 5, 1))
    end
    local _rem = buffer:len() - str_offset
    if _rem > 0 then
        subtree:add(values, buffer(str_offset, _rem))
        str_offset = str_offset + _rem
    end
end

return NMEA_2000_130820
