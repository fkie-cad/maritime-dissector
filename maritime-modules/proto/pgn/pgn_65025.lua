-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_65025 = Proto("nmea-2000-65025", "Generator Phase A AC Reactive Power (65025)")
local reactivePower = ProtoField.int32("nmea-2000-65025.reactivePower", "Reactive Power (VAR)")
local powerFactor = ProtoField.float("nmea-2000-65025.powerFactor", "Power factor (Cos Phi)")
local powerFactorLagging = ProtoField.uint8("nmea-2000-65025.powerFactorLagging", "Power Factor Lagging", base.DEC, NULL, 0x3)

NMEA_2000_65025.fields = {reactivePower,powerFactor,powerFactorLagging}

function NMEA_2000_65025.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 65025 (Generator Phase A AC Reactive Power)"
    local subtree = tree:add(NMEA_2000_65025, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 4) then
        subtree:add_le(reactivePower, buffer(str_offset, 4))
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add(powerFactor, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 6.10352e-05)
    end
    if buffer:len() >= (str_offset + 6 + 1) then
        subtree:add(powerFactorLagging, buffer(str_offset + 6, 1))
    end
end

return NMEA_2000_65025
