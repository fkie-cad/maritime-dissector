-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129540 = Proto("nmea-2000-129540", "GNSS Sats in View (129540)")
local sid = ProtoField.uint8("nmea-2000-129540.sid", "SID")
local rangeResidualMode = ProtoField.uint8("nmea-2000-129540.rangeResidualMode", "Range Residual Mode", base.DEC, NULL, 0x3)
local satsInView = ProtoField.uint8("nmea-2000-129540.satsInView", "Sats in View")
local prn = ProtoField.uint8("nmea-2000-129540.prn", "PRN")
local elevation = ProtoField.float("nmea-2000-129540.elevation", "Elevation (rad)")
local azimuth = ProtoField.float("nmea-2000-129540.azimuth", "Azimuth (rad)")
local snr = ProtoField.float("nmea-2000-129540.snr", "SNR (dB)")
local rangeResiduals = ProtoField.float("nmea-2000-129540.rangeResiduals", "Range residuals (m)")
local status = ProtoField.uint8("nmea-2000-129540.status", "Status", base.DEC, NULL, 0xf)

NMEA_2000_129540.fields = {sid,rangeResidualMode,satsInView,prn,elevation,azimuth,snr,rangeResiduals,status}

function NMEA_2000_129540.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129540 (GNSS Sats in View)"
    local subtree = tree:add(NMEA_2000_129540, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sid, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(rangeResidualMode, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(satsInView, buffer(str_offset + 2, 1))
    end
    local count_1 = buffer(str_offset + 2, 1):uint()
    if count_1 > 100 then count_1 = 0 end  -- likely 'not available' sentinel
    local rep_offset_1 = str_offset + 3
    for _i_1 = 1, count_1 do
    if rep_offset_1 + 12 > buffer:len() then break end
    do
        local _start = rep_offset_1 + 0
        if buffer:len() >= (_start + 1) then
            local _rng = buffer(_start, 1)
            local _raw = _rng:uint()
            local _val = _raw
            subtree:add(prn, _rng, _val)
        end
    end
    do
        local _start = rep_offset_1 + 1
        if buffer:len() >= (_start + 2) then
            local _rng = buffer(_start, 2)
            local _raw = _rng:le_uint()
            local _val = _raw
            if _val >= 2 ^ (16 - 1) then
                _val = _val - 2 ^ 16
            end
            subtree:add(elevation, _rng, _val * 0.0001)
        end
    end
    do
        local _start = rep_offset_1 + 3
        if buffer:len() >= (_start + 2) then
            local _rng = buffer(_start, 2)
            local _raw = _rng:le_uint()
            local _val = _raw
            subtree:add(azimuth, _rng, _val * 0.0001)
        end
    end
    do
        local _start = rep_offset_1 + 5
        if buffer:len() >= (_start + 2) then
            local _rng = buffer(_start, 2)
            local _raw = _rng:le_uint()
            local _val = _raw
            if _val >= 2 ^ (16 - 1) then
                _val = _val - 2 ^ 16
            end
            subtree:add(snr, _rng, _val * 0.01)
        end
    end
    do
        local _start = rep_offset_1 + 7
        if buffer:len() >= (_start + 4) then
            local _rng = buffer(_start, 4)
            local _raw = _rng:le_uint()
            local _val = _raw
            if _val >= 2 ^ (32 - 1) then
                _val = _val - 2 ^ 32
            end
            subtree:add(rangeResiduals, _rng, _val * 1e-05)
        end
    end
    do
        local _start = rep_offset_1 + 11
        if buffer:len() >= (_start + 1) then
            local _rng = buffer(_start, 1)
            local _raw = _rng:le_uint()
            local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 4)
            subtree:add(status, _rng, _val)
        end
    end
    rep_offset_1 = rep_offset_1 + 12
    end
end

return NMEA_2000_129540
