-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130825 = Proto("nmea-2000-130825", "Navico: Unknown 2 (130825)")
local manufacturerCode = ProtoField.uint32("nmea-2000-130825.manufacturerCode", "Manufacturer Code")
local industryCode = ProtoField.uint8("nmea-2000-130825.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local data = ProtoField.bytes("nmea-2000-130825.data", "Data")

NMEA_2000_130825.fields = {manufacturerCode,industryCode,data}

function NMEA_2000_130825.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130825 (Navico: Unknown 2)"
    local subtree = tree:add(NMEA_2000_130825, buffer(), subtree_title)
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
    if buffer:len() >= (str_offset + 2 + 10) then
        subtree:add(data, buffer(str_offset + 2, 10))
    end
end

return NMEA_2000_130825
