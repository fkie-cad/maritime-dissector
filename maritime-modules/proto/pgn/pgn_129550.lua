-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129550 = Proto("nmea-2000-129550", "GNSS Differential Correction Receiver Interface (129550)")
local channel = ProtoField.uint8("nmea-2000-129550.channel", "Channel")
local frequency = ProtoField.float("nmea-2000-129550.frequency", "Frequency (Hz)")
local serialInterfaceBitRate = ProtoField.uint8("nmea-2000-129550.serialInterfaceBitRate", "Serial Interface Bit Rate", base.DEC, NULL, 0x1f)
local serialInterfaceDetectionMode = ProtoField.uint8("nmea-2000-129550.serialInterfaceDetectionMode", "Serial Interface Detection Mode", base.DEC, NULL, 0xe0)
local differentialSource = ProtoField.uint8("nmea-2000-129550.differentialSource", "Differential Source", base.DEC, NULL, 0xf)
local differentialOperationMode = ProtoField.uint8("nmea-2000-129550.differentialOperationMode", "Differential Operation Mode", base.DEC, NULL, 0xf0)

NMEA_2000_129550.fields = {channel,frequency,serialInterfaceBitRate,serialInterfaceDetectionMode,differentialSource,differentialOperationMode}

function NMEA_2000_129550.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129550 (GNSS Differential Correction Receiver Interface)"
    local subtree = tree:add(NMEA_2000_129550, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(channel, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 4) then
        subtree:add(frequency, buffer(str_offset + 1, 4), buffer(str_offset + 1, 4):le_uint() * 10)
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        subtree:add(serialInterfaceBitRate, buffer(str_offset + 5, 1))
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        subtree:add(serialInterfaceDetectionMode, buffer(str_offset + 5, 1))
    end
    if buffer:len() >= (str_offset + 6 + 1) then
        subtree:add(differentialSource, buffer(str_offset + 6, 1))
    end
    if buffer:len() >= (str_offset + 6 + 1) then
        subtree:add(differentialOperationMode, buffer(str_offset + 6, 1))
    end
end

return NMEA_2000_129550
