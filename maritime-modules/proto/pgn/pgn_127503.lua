-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127503 = Proto("nmea-2000-127503", "AC Input Status (127503)")
local instance = ProtoField.uint8("nmea-2000-127503.instance", "Instance")
local numberOfLines = ProtoField.uint8("nmea-2000-127503.numberOfLines", "Number of Lines")
local line = ProtoField.uint8("nmea-2000-127503.line", "Line", base.DEC, NULL, 0x3)
local acceptability = ProtoField.uint8("nmea-2000-127503.acceptability", "Acceptability", base.DEC, NULL, 0xc)
local voltage = ProtoField.float("nmea-2000-127503.voltage", "Voltage (V)")
local current = ProtoField.float("nmea-2000-127503.current", "Current (A)")
local frequency = ProtoField.float("nmea-2000-127503.frequency", "Frequency (Hz)")
local breakerSize = ProtoField.float("nmea-2000-127503.breakerSize", "Breaker Size (A)")
local realPower = ProtoField.uint32("nmea-2000-127503.realPower", "Real Power (W)")
local reactivePower = ProtoField.uint32("nmea-2000-127503.reactivePower", "Reactive Power (VAR)")
local powerFactor = ProtoField.float("nmea-2000-127503.powerFactor", "Power factor (Cos Phi)")

NMEA_2000_127503.fields = {instance,numberOfLines,line,acceptability,voltage,current,frequency,breakerSize,realPower,reactivePower,powerFactor}

function NMEA_2000_127503.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127503 (AC Input Status)"
    local subtree = tree:add(NMEA_2000_127503, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(instance, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(numberOfLines, buffer(str_offset + 1, 1))
    end
    local count_1 = buffer(str_offset + 1, 1):uint()
    if count_1 > 100 then count_1 = 0 end  -- likely 'not available' sentinel
    local rep_offset_1 = str_offset + 2
    for _i_1 = 1, count_1 do
    if rep_offset_1 + 18 > buffer:len() then break end
    do
        local _start = rep_offset_1 + 0
        if buffer:len() >= (_start + 1) then
            local _rng = buffer(_start, 1)
            local _raw = _rng:le_uint()
            local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 2)
            subtree:add(line, _rng, _val)
        end
    end
    do
        local _start = rep_offset_1 + 0
        if buffer:len() >= (_start + 1) then
            local _rng = buffer(_start, 1)
            local _raw = _rng:le_uint()
            local _val = math.floor(_raw / (2 ^ 2)) % (2 ^ 2)
            subtree:add(acceptability, _rng, _val)
        end
    end
    do
        local _start = rep_offset_1 + 1
        if buffer:len() >= (_start + 2) then
            local _rng = buffer(_start, 2)
            local _raw = _rng:le_uint()
            local _val = _raw
            subtree:add(voltage, _rng, _val * 0.01)
        end
    end
    do
        local _start = rep_offset_1 + 3
        if buffer:len() >= (_start + 2) then
            local _rng = buffer(_start, 2)
            local _raw = _rng:le_uint()
            local _val = _raw
            subtree:add(current, _rng, _val * 0.1)
        end
    end
    do
        local _start = rep_offset_1 + 5
        if buffer:len() >= (_start + 2) then
            local _rng = buffer(_start, 2)
            local _raw = _rng:le_uint()
            local _val = _raw
            subtree:add(frequency, _rng, _val * 0.01)
        end
    end
    do
        local _start = rep_offset_1 + 7
        if buffer:len() >= (_start + 2) then
            local _rng = buffer(_start, 2)
            local _raw = _rng:le_uint()
            local _val = _raw
            subtree:add(breakerSize, _rng, _val * 0.1)
        end
    end
    do
        local _start = rep_offset_1 + 9
        if buffer:len() >= (_start + 4) then
            local _rng = buffer(_start, 4)
            local _raw = _rng:le_uint()
            local _val = _raw
            subtree:add(realPower, _rng, _val)
        end
    end
    do
        local _start = rep_offset_1 + 13
        if buffer:len() >= (_start + 4) then
            local _rng = buffer(_start, 4)
            local _raw = _rng:le_uint()
            local _val = _raw
            subtree:add(reactivePower, _rng, _val)
        end
    end
    do
        local _start = rep_offset_1 + 17
        if buffer:len() >= (_start + 1) then
            local _rng = buffer(_start, 1)
            local _raw = _rng:uint()
            local _val = _raw
            if _val >= 2 ^ (8 - 1) then
                _val = _val - 2 ^ 8
            end
            subtree:add(powerFactor, _rng, _val * 0.01)
        end
    end
    rep_offset_1 = rep_offset_1 + 18
    end
end

return NMEA_2000_127503
