-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_65009 = Proto("nmea-2000-65009", "Utility Phase B AC Reactive Power (65009)")
local reactivePower = ProtoField.float("nmea-2000-65009.reactivePower", "Reactive Power (VAR)")
local powerFactor = ProtoField.float("nmea-2000-65009.powerFactor", "Power factor (Cos Phi)")
local powerFactorLagging = ProtoField.uint8("nmea-2000-65009.powerFactorLagging", "Power Factor Lagging", base.DEC, NULL, 0x3)

NMEA_2000_65009.fields = {reactivePower,powerFactor,powerFactorLagging}

function NMEA_2000_65009.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 65009 (Utility Phase B AC Reactive Power)"
    local subtree = tree:add(NMEA_2000_65009, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(reactivePower, buffer(str_offset + 0, 2), buffer(str_offset + 0, 2):le_uint() * 1)
    subtree:add(powerFactor, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 6.10352e-05)
    subtree:add(powerFactorLagging, buffer(str_offset + 4, 1))
end

return NMEA_2000_65009
