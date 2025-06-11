-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_65240 = Proto("nmea-2000-65240", "ISO Commanded Address (65240)")
local deviceClass = ProtoField.uint8("nmea-2000-65240.deviceClass", "Device Class", base.DEC, NULL, 0xfe)
local industryCode = ProtoField.uint8("nmea-2000-65240.industryCode", "Industry Code", base.DEC, NULL, 0x70)
local newSourceAddress = ProtoField.float("nmea-2000-65240.newSourceAddress", "New Source Address")

NMEA_2000_65240.fields = {deviceClass,industryCode,newSourceAddress}

function NMEA_2000_65240.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 65240 (ISO Commanded Address)"
    local subtree = tree:add(NMEA_2000_65240, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(deviceClass, buffer(str_offset + 6, 1))
    subtree:add(industryCode, buffer(str_offset + 7, 1))
    subtree:add(newSourceAddress, buffer(str_offset + 8, 1), buffer(str_offset + 8, 1):le_uint() * 1)
end

return NMEA_2000_65240
