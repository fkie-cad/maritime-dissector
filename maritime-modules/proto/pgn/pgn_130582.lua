-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130582 = Proto("nmea-2000-130582", "Zone Volume (130582)")
local zoneId = ProtoField.uint8("nmea-2000-130582.zoneId", "Zone ID", base.DEC, NULL, 0xff)
local volume = ProtoField.float("nmea-2000-130582.volume", "Volume (%)")
local volumeChange = ProtoField.uint8("nmea-2000-130582.volumeChange", "Volume change", base.DEC, NULL, 0x3)
local mute = ProtoField.uint8("nmea-2000-130582.mute", "Mute", base.DEC, NULL, 0xc)
local channel = ProtoField.uint8("nmea-2000-130582.channel", "Channel", base.DEC, NULL, 0xff)

NMEA_2000_130582.fields = {zoneId,volume,volumeChange,mute,channel}

function NMEA_2000_130582.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130582 (Zone Volume)"
    local subtree = tree:add(NMEA_2000_130582, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(zoneId, buffer(str_offset + 0, 1))
    subtree:add(volume, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(volumeChange, buffer(str_offset + 2, 1))
    subtree:add(mute, buffer(str_offset + 2, 1))
    subtree:add(channel, buffer(str_offset + 3, 1))
end

return NMEA_2000_130582
