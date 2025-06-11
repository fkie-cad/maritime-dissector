-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130586 = Proto("nmea-2000-130586", "Zone Configuration (130586)")
local zoneId = ProtoField.uint8("nmea-2000-130586.zoneId", "Zone ID", base.DEC, NULL, 0xff)
local volumeLimit = ProtoField.float("nmea-2000-130586.volumeLimit", "Volume limit (%)")
local fade = ProtoField.float("nmea-2000-130586.fade", "Fade (%)")
local balance = ProtoField.float("nmea-2000-130586.balance", "Balance (%)")
local subVolume = ProtoField.float("nmea-2000-130586.subVolume", "Sub volume (%)")
local eqTreble = ProtoField.float("nmea-2000-130586.eqTreble", "EQ - Treble (%)")
local eqMidRange = ProtoField.float("nmea-2000-130586.eqMidRange", "EQ - Mid range (%)")
local eqBass = ProtoField.float("nmea-2000-130586.eqBass", "EQ - Bass (%)")
local presetType = ProtoField.uint8("nmea-2000-130586.presetType", "Preset type", base.DEC, NULL, 0xff)
local audioFilter = ProtoField.uint8("nmea-2000-130586.audioFilter", "Audio filter", base.DEC, NULL, 0xff)
local highPassFilterFrequency = ProtoField.float("nmea-2000-130586.highPassFilterFrequency", "High pass filter frequency (Hz)")
local lowPassFilterFrequency = ProtoField.float("nmea-2000-130586.lowPassFilterFrequency", "Low pass filter frequency (Hz)")
local channel = ProtoField.uint8("nmea-2000-130586.channel", "Channel", base.DEC, NULL, 0xff)

NMEA_2000_130586.fields = {zoneId,volumeLimit,fade,balance,subVolume,eqTreble,eqMidRange,eqBass,presetType,audioFilter,highPassFilterFrequency,lowPassFilterFrequency,channel}

function NMEA_2000_130586.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130586 (Zone Configuration)"
    local subtree = tree:add(NMEA_2000_130586, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(zoneId, buffer(str_offset + 0, 1))
    subtree:add(volumeLimit, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(fade, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_int() * 1)
    subtree:add(balance, buffer(str_offset + 3, 1), buffer(str_offset + 3, 1):le_int() * 1)
    subtree:add(subVolume, buffer(str_offset + 4, 1), buffer(str_offset + 4, 1):le_uint() * 1)
    subtree:add(eqTreble, buffer(str_offset + 5, 1), buffer(str_offset + 5, 1):le_int() * 1)
    subtree:add(eqMidRange, buffer(str_offset + 6, 1), buffer(str_offset + 6, 1):le_int() * 1)
    subtree:add(eqBass, buffer(str_offset + 7, 1), buffer(str_offset + 7, 1):le_int() * 1)
    subtree:add(presetType, buffer(str_offset + 8, 1))
    subtree:add(audioFilter, buffer(str_offset + 9, 1))
    subtree:add(highPassFilterFrequency, buffer(str_offset + 10, 2), buffer(str_offset + 10, 2):le_uint() * 1)
    subtree:add(lowPassFilterFrequency, buffer(str_offset + 12, 2), buffer(str_offset + 12, 2):le_uint() * 1)
    subtree:add(channel, buffer(str_offset + 14, 1))
end

return NMEA_2000_130586
