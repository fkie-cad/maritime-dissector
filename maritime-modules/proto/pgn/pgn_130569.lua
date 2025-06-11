-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130569 = Proto("nmea-2000-130569", "Current Status and File (130569)")
local zone = ProtoField.uint8("nmea-2000-130569.zone", "Zone", base.DEC, NULL, 0xff)
local source = ProtoField.uint8("nmea-2000-130569.source", "Source", base.DEC, NULL, 0xff)
local number = ProtoField.float("nmea-2000-130569.number", "Number")
local id = ProtoField.float("nmea-2000-130569.id", "ID")
local playStatus = ProtoField.uint8("nmea-2000-130569.playStatus", "Play status", base.DEC, NULL, 0xff)
local elapsedTrackTime = ProtoField.float("nmea-2000-130569.elapsedTrackTime", "Elapsed Track Time (s)")
local trackTime = ProtoField.float("nmea-2000-130569.trackTime", "Track Time (s)")
local repeatStatus = ProtoField.uint8("nmea-2000-130569.repeatStatus", "Repeat Status", base.DEC, NULL, 0xf)
local shuffleStatus = ProtoField.uint8("nmea-2000-130569.shuffleStatus", "Shuffle Status", base.DEC, NULL, 0xf0)
local saveFavoriteNumber = ProtoField.float("nmea-2000-130569.saveFavoriteNumber", "Save Favorite Number")
local playFavoriteNumber = ProtoField.float("nmea-2000-130569.playFavoriteNumber", "Play Favorite Number")
local thumbsUpDown = ProtoField.uint8("nmea-2000-130569.thumbsUpDown", "Thumbs Up/Down", base.DEC, NULL, 0xff)
local signalStrength = ProtoField.float("nmea-2000-130569.signalStrength", "Signal Strength (%)")
local radioFrequency = ProtoField.float("nmea-2000-130569.radioFrequency", "Radio Frequency (Hz)")
local hdFrequencyMulticast = ProtoField.float("nmea-2000-130569.hdFrequencyMulticast", "HD Frequency Multicast")
local deleteFavoriteNumber = ProtoField.float("nmea-2000-130569.deleteFavoriteNumber", "Delete Favorite Number")
local totalNumberOfTracks = ProtoField.float("nmea-2000-130569.totalNumberOfTracks", "Total Number of Tracks")

NMEA_2000_130569.fields = {zone,source,number,id,playStatus,elapsedTrackTime,trackTime,repeatStatus,shuffleStatus,saveFavoriteNumber,playFavoriteNumber,thumbsUpDown,signalStrength,radioFrequency,hdFrequencyMulticast,deleteFavoriteNumber,totalNumberOfTracks}

function NMEA_2000_130569.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130569 (Current Status and File)"
    local subtree = tree:add(NMEA_2000_130569, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(zone, buffer(str_offset + 0, 1))
    subtree:add(source, buffer(str_offset + 1, 1))
    subtree:add(number, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(id, buffer(str_offset + 3, 4), buffer(str_offset + 3, 4):le_uint() * 1)
    subtree:add(playStatus, buffer(str_offset + 7, 1))
    subtree:add(elapsedTrackTime, buffer(str_offset + 8, 2), buffer(str_offset + 8, 2):le_uint() * 1)
    subtree:add(trackTime, buffer(str_offset + 10, 2), buffer(str_offset + 10, 2):le_uint() * 1)
    subtree:add(repeatStatus, buffer(str_offset + 12, 1))
    subtree:add(shuffleStatus, buffer(str_offset + 12, 1))
    subtree:add(saveFavoriteNumber, buffer(str_offset + 13, 1), buffer(str_offset + 13, 1):le_uint() * 1)
    subtree:add(playFavoriteNumber, buffer(str_offset + 14, 2), buffer(str_offset + 14, 2):le_uint() * 1)
    subtree:add(thumbsUpDown, buffer(str_offset + 16, 1))
    subtree:add(signalStrength, buffer(str_offset + 17, 1), buffer(str_offset + 17, 1):le_uint() * 1)
    subtree:add(radioFrequency, buffer(str_offset + 18, 4), buffer(str_offset + 18, 4):le_uint() * 10)
    subtree:add(hdFrequencyMulticast, buffer(str_offset + 22, 1), buffer(str_offset + 22, 1):le_uint() * 1)
    subtree:add(deleteFavoriteNumber, buffer(str_offset + 23, 1), buffer(str_offset + 23, 1):le_uint() * 1)
    subtree:add(totalNumberOfTracks, buffer(str_offset + 24, 2), buffer(str_offset + 24, 2):le_uint() * 1)
end

return NMEA_2000_130569
