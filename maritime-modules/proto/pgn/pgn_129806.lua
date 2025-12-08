-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129806 = Proto("nmea-2000-129806", "AIS Channel Management (129806)")
local messageId = ProtoField.uint8("nmea-2000-129806.messageId", "Message ID", base.DEC, NULL, 0x3f)
local repeatIndicator = ProtoField.uint8("nmea-2000-129806.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local sourceId = ProtoField.uint32("nmea-2000-129806.sourceId", "Source ID")
local aisTransceiverInformation = ProtoField.uint8("nmea-2000-129806.aisTransceiverInformation", "AIS Transceiver information", base.DEC, NULL, 0x3e)
local channelA = ProtoField.uint16("nmea-2000-129806.channelA", "Channel A")
local channelB = ProtoField.uint16("nmea-2000-129806.channelB", "Channel B")
local power = ProtoField.uint8("nmea-2000-129806.power", "Power", base.DEC, NULL, 0x8)
local txRxMode = ProtoField.uint8("nmea-2000-129806.txRxMode", "Tx/Rx Mode", base.DEC, NULL, 0xf0)
local northEastLongitudeCorner1 = ProtoField.float("nmea-2000-129806.northEastLongitudeCorner1", "North East Longitude Corner 1 (deg)")
local northEastLatitudeCorner1 = ProtoField.float("nmea-2000-129806.northEastLatitudeCorner1", "North East Latitude Corner 1 (deg)")
local southWestLongitudeCorner2 = ProtoField.float("nmea-2000-129806.southWestLongitudeCorner2", "South West Longitude Corner 2 (deg)")
local southWestLatitudeCorner2 = ProtoField.float("nmea-2000-129806.southWestLatitudeCorner2", "South West Latitude Corner 2 (deg)")
local addressedOrBroadcastMessageIndicator = ProtoField.uint8("nmea-2000-129806.addressedOrBroadcastMessageIndicator", "Addressed or Broadcast Message Indicator", base.DEC, NULL, 0x2)
local channelABandwidth = ProtoField.uint8("nmea-2000-129806.channelABandwidth", "Channel A Bandwidth", base.DEC, NULL, 0x4)
local channelBBandwidth = ProtoField.uint8("nmea-2000-129806.channelBBandwidth", "Channel B Bandwidth", base.DEC, NULL, 0x8)
local transitionalZoneSize = ProtoField.uint8("nmea-2000-129806.transitionalZoneSize", "Transitional Zone Size", base.DEC, NULL, 0xe0)

NMEA_2000_129806.fields = {messageId,repeatIndicator,sourceId,aisTransceiverInformation,channelA,channelB,power,txRxMode,northEastLongitudeCorner1,northEastLatitudeCorner1,southWestLongitudeCorner2,southWestLatitudeCorner2,addressedOrBroadcastMessageIndicator,channelABandwidth,channelBBandwidth,transitionalZoneSize}

function NMEA_2000_129806.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129806 (AIS Channel Management)"
    local subtree = tree:add(NMEA_2000_129806, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(messageId, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(repeatIndicator, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 4) then
        local sourceId_val = buffer(str_offset + 1, 4):le_uint()
        local _ti = subtree:add(sourceId, buffer(str_offset + 1, 4), sourceId_val)
        _ti:append_text(string.format(" (%09d)", sourceId_val))
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        subtree:add(aisTransceiverInformation, buffer(str_offset + 5, 1))
    end
    if buffer:len() >= (str_offset + 6 + 2) then
        subtree:add_le(channelA, buffer(str_offset + 6, 2))
    end
    if buffer:len() >= (str_offset + 8 + 2) then
        subtree:add_le(channelB, buffer(str_offset + 8, 2))
    end
    if buffer:len() >= (str_offset + 10 + 1) then
        subtree:add(power, buffer(str_offset + 10, 1))
    end
    if buffer:len() >= (str_offset + 10 + 1) then
        subtree:add(txRxMode, buffer(str_offset + 10, 1))
    end
    if buffer:len() >= (str_offset + 11 + 4) then
        subtree:add(northEastLongitudeCorner1, buffer(str_offset + 11, 4), buffer(str_offset + 11, 4):le_int() * 1e-07)
    end
    if buffer:len() >= (str_offset + 15 + 4) then
        subtree:add(northEastLatitudeCorner1, buffer(str_offset + 15, 4), buffer(str_offset + 15, 4):le_int() * 1e-07)
    end
    if buffer:len() >= (str_offset + 19 + 4) then
        subtree:add(southWestLongitudeCorner2, buffer(str_offset + 19, 4), buffer(str_offset + 19, 4):le_int() * 1e-07)
    end
    if buffer:len() >= (str_offset + 23 + 4) then
        subtree:add(southWestLatitudeCorner2, buffer(str_offset + 23, 4), buffer(str_offset + 23, 4):le_int() * 1e-07)
    end
    if buffer:len() >= (str_offset + 27 + 1) then
        subtree:add(addressedOrBroadcastMessageIndicator, buffer(str_offset + 27, 1))
    end
    if buffer:len() >= (str_offset + 27 + 1) then
        subtree:add(channelABandwidth, buffer(str_offset + 27, 1))
    end
    if buffer:len() >= (str_offset + 27 + 1) then
        subtree:add(channelBBandwidth, buffer(str_offset + 27, 1))
    end
    if buffer:len() >= (str_offset + 27 + 1) then
        subtree:add(transitionalZoneSize, buffer(str_offset + 27, 1))
    end
end

return NMEA_2000_129806
