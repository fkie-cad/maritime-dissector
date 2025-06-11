-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129551 = Proto("nmea-2000-129551", "GNSS Differential Correction Receiver Signal (129551)")
local sid = ProtoField.float("nmea-2000-129551.sid", "SID")
local channel = ProtoField.float("nmea-2000-129551.channel", "Channel")
local signalStrength = ProtoField.float("nmea-2000-129551.signalStrength", "Signal Strength (dB)")
local signalSnr = ProtoField.float("nmea-2000-129551.signalSnr", "Signal SNR (dB)")
local frequency = ProtoField.float("nmea-2000-129551.frequency", "Frequency (Hz)")
local stationType = ProtoField.uint8("nmea-2000-129551.stationType", "Station Type", base.DEC, NULL, 0xf)
local differentialSignalBitRate = ProtoField.uint8("nmea-2000-129551.differentialSignalBitRate", "Differential Signal Bit Rate", base.DEC, NULL, 0x1f)
local differentialSignalDetectionMode = ProtoField.uint8("nmea-2000-129551.differentialSignalDetectionMode", "Differential Signal Detection Mode", base.DEC, NULL, 0xe0)
local usedAsCorrectionSource = ProtoField.uint8("nmea-2000-129551.usedAsCorrectionSource", "Used as Correction Source", base.DEC, NULL, 0x3)
local differentialSource = ProtoField.uint8("nmea-2000-129551.differentialSource", "Differential Source", base.DEC, NULL, 0xf0)
local timeSinceLastSatDifferentialSync = ProtoField.float("nmea-2000-129551.timeSinceLastSatDifferentialSync", "Time since Last Sat Differential Sync (s)")
local satelliteServiceIdNo = ProtoField.float("nmea-2000-129551.satelliteServiceIdNo", "Satellite Service ID No.")

NMEA_2000_129551.fields = {sid,channel,signalStrength,signalSnr,frequency,stationType,differentialSignalBitRate,differentialSignalDetectionMode,usedAsCorrectionSource,differentialSource,timeSinceLastSatDifferentialSync,satelliteServiceIdNo}

function NMEA_2000_129551.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129551 (GNSS Differential Correction Receiver Signal)"
    local subtree = tree:add(NMEA_2000_129551, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(channel, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(signalStrength, buffer(str_offset + 2, 4), buffer(str_offset + 2, 4):le_int() * 0.01)
    subtree:add(signalSnr, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_int() * 0.01)
    subtree:add(frequency, buffer(str_offset + 8, 4), buffer(str_offset + 8, 4):le_uint() * 10)
    subtree:add(stationType, buffer(str_offset + 12, 1))
    subtree:add(differentialSignalBitRate, buffer(str_offset + 14, 1))
    subtree:add(differentialSignalDetectionMode, buffer(str_offset + 14, 1))
    subtree:add(usedAsCorrectionSource, buffer(str_offset + 15, 1))
    subtree:add(differentialSource, buffer(str_offset + 15, 1))
    subtree:add(timeSinceLastSatDifferentialSync, buffer(str_offset + 16, 2), buffer(str_offset + 16, 2):le_uint() * 0.01)
    subtree:add(satelliteServiceIdNo, buffer(str_offset + 18, 2), buffer(str_offset + 18, 2):le_uint() * 1)
end

return NMEA_2000_129551
