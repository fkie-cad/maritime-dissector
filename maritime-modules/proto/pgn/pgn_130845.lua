-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130845 = Proto("nmea-2000-130845", "Simnet: Key Value (130845)")
local industryCode = ProtoField.uint8("nmea-2000-130845.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local address = ProtoField.float("nmea-2000-130845.address", "Address")
local repeatIndicator = ProtoField.uint8("nmea-2000-130845.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xff)
local displayGroup = ProtoField.uint8("nmea-2000-130845.displayGroup", "Display Group", base.DEC, NULL, 0xff)
local minlength = ProtoField.float("nmea-2000-130845.minlength", "MinLength")

NMEA_2000_130845.fields = {industryCode,address,repeatIndicator,displayGroup,minlength}

function NMEA_2000_130845.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130845 (Simnet: Key Value)"
    local subtree = tree:add(NMEA_2000_130845, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(industryCode, buffer(str_offset + 1, 1))
    subtree:add(address, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(repeatIndicator, buffer(str_offset + 3, 1))
    subtree:add(displayGroup, buffer(str_offset + 4, 1))
    subtree:add(minlength, buffer(str_offset + 9, 1), buffer(str_offset + 9, 1):le_uint() * 1)
end

return NMEA_2000_130845
