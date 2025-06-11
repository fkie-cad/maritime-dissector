-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129799 = Proto("nmea-2000-129799", "Radio Frequency/Mode/Power (129799)")
local rxFrequency = ProtoField.float("nmea-2000-129799.rxFrequency", "Rx Frequency (Hz)")
local txFrequency = ProtoField.float("nmea-2000-129799.txFrequency", "Tx Frequency (Hz)")
local radioChannel = ProtoField.string("nmea-2000-129799.radioChannel", "Radio Channel")
local txPower = ProtoField.float("nmea-2000-129799.txPower", "Tx Power (W)")
local mode = ProtoField.uint8("nmea-2000-129799.mode", "Mode", base.DEC, NULL, 0xff)
local channelBandwidth = ProtoField.float("nmea-2000-129799.channelBandwidth", "Channel Bandwidth (Hz)")

NMEA_2000_129799.fields = {rxFrequency,txFrequency,radioChannel,txPower,mode,channelBandwidth}

function NMEA_2000_129799.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129799 (Radio Frequency/Mode/Power)"
    local subtree = tree:add(NMEA_2000_129799, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(rxFrequency, buffer(str_offset + 0, 4), buffer(str_offset + 0, 4):le_uint() * 10)
    subtree:add(txFrequency, buffer(str_offset + 4, 4), buffer(str_offset + 4, 4):le_uint() * 10)
    subtree:add(radioChannel, buffer(str_offset + 8, 6))
    subtree:add(txPower, buffer(str_offset + 14, 2), buffer(str_offset + 14, 2):le_uint() * 1)
    subtree:add(mode, buffer(str_offset + 16, 1))
    subtree:add(channelBandwidth, buffer(str_offset + 17, 2), buffer(str_offset + 17, 2):le_uint() * 1)
end

return NMEA_2000_129799
