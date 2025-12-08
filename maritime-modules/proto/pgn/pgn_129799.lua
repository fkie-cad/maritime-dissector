-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129799 = Proto("nmea-2000-129799", "Radio Frequency/Mode/Power (129799)")
local rxFrequency = ProtoField.float("nmea-2000-129799.rxFrequency", "Rx Frequency (Hz)")
local txFrequency = ProtoField.float("nmea-2000-129799.txFrequency", "Tx Frequency (Hz)")
local radioChannel = ProtoField.string("nmea-2000-129799.radioChannel", "Radio Channel")
local txPower = ProtoField.uint16("nmea-2000-129799.txPower", "Tx Power (W)")
local mode = ProtoField.uint8("nmea-2000-129799.mode", "Mode", base.DEC, NULL, 0xff)
local channelBandwidth = ProtoField.uint16("nmea-2000-129799.channelBandwidth", "Channel Bandwidth (Hz)")

NMEA_2000_129799.fields = {rxFrequency,txFrequency,radioChannel,txPower,mode,channelBandwidth}

function NMEA_2000_129799.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129799 (Radio Frequency/Mode/Power)"
    local subtree = tree:add(NMEA_2000_129799, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 4) then
        subtree:add(rxFrequency, buffer(str_offset, 4), buffer(str_offset, 4):le_uint() * 10)
    end
    if buffer:len() >= (str_offset + 4 + 4) then
        subtree:add(txFrequency, buffer(str_offset + 4, 4), buffer(str_offset + 4, 4):le_uint() * 10)
    end
    if buffer:len() >= (str_offset + 8 + 6) then
        local _radioChannel_raw = buffer(str_offset + 8, 6):string()
        local _radioChannel_clean = _radioChannel_raw:gsub("[%s@%z\xff]+$", "")
        subtree:add(radioChannel, buffer(str_offset + 8, 6), _radioChannel_clean)
    end
    if buffer:len() >= (str_offset + 14 + 2) then
        subtree:add_le(txPower, buffer(str_offset + 14, 2))
    end
    if buffer:len() >= (str_offset + 16 + 1) then
        subtree:add(mode, buffer(str_offset + 16, 1))
    end
    if buffer:len() >= (str_offset + 17 + 2) then
        subtree:add_le(channelBandwidth, buffer(str_offset + 17, 2))
    end
end

return NMEA_2000_129799
