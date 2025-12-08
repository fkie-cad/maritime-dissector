-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129807 = Proto("nmea-2000-129807", "AIS Class B Group Assignment (129807)")
local messageId = ProtoField.uint8("nmea-2000-129807.messageId", "Message ID", base.DEC, NULL, 0x3f)
local repeatIndicator = ProtoField.uint8("nmea-2000-129807.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local sourceId = ProtoField.uint32("nmea-2000-129807.sourceId", "Source ID")
local txRxMode = ProtoField.uint8("nmea-2000-129807.txRxMode", "Tx/Rx Mode", base.DEC, NULL, 0x3c)
local northEastLongitudeCorner1 = ProtoField.float("nmea-2000-129807.northEastLongitudeCorner1", "North East Longitude Corner 1 (deg)")
local northEastLatitudeCorner1 = ProtoField.float("nmea-2000-129807.northEastLatitudeCorner1", "North East Latitude Corner 1 (deg)")
local southWestLongitudeCorner2 = ProtoField.float("nmea-2000-129807.southWestLongitudeCorner2", "South West Longitude Corner 2 (deg)")
local southWestLatitudeCorner2 = ProtoField.float("nmea-2000-129807.southWestLatitudeCorner2", "South West Latitude Corner 2 (deg)")
local stationType = ProtoField.uint8("nmea-2000-129807.stationType", "Station Type", base.DEC, NULL, 0xf)
local shipAndCargoFilter = ProtoField.uint8("nmea-2000-129807.shipAndCargoFilter", "Ship and Cargo Filter", base.DEC, NULL, 0xff)
local reportingInterval = ProtoField.uint8("nmea-2000-129807.reportingInterval", "Reporting Interval", base.DEC, NULL, 0xf)
local quietTime = ProtoField.float("nmea-2000-129807.quietTime", "Quiet Time (s)")

NMEA_2000_129807.fields = {messageId,repeatIndicator,sourceId,txRxMode,northEastLongitudeCorner1,northEastLatitudeCorner1,southWestLongitudeCorner2,southWestLatitudeCorner2,stationType,shipAndCargoFilter,reportingInterval,quietTime}

function NMEA_2000_129807.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129807 (AIS Class B Group Assignment)"
    local subtree = tree:add(NMEA_2000_129807, buffer(), subtree_title)
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
        subtree:add(txRxMode, buffer(str_offset + 5, 1))
    end
    if buffer:len() >= (str_offset + 6 + 4) then
        subtree:add(northEastLongitudeCorner1, buffer(str_offset + 6, 4), buffer(str_offset + 6, 4):le_int() * 1e-07)
    end
    if buffer:len() >= (str_offset + 10 + 4) then
        subtree:add(northEastLatitudeCorner1, buffer(str_offset + 10, 4), buffer(str_offset + 10, 4):le_int() * 1e-07)
    end
    if buffer:len() >= (str_offset + 14 + 4) then
        subtree:add(southWestLongitudeCorner2, buffer(str_offset + 14, 4), buffer(str_offset + 14, 4):le_int() * 1e-07)
    end
    if buffer:len() >= (str_offset + 18 + 4) then
        subtree:add(southWestLatitudeCorner2, buffer(str_offset + 18, 4), buffer(str_offset + 18, 4):le_int() * 1e-07)
    end
    if buffer:len() >= (str_offset + 22 + 1) then
        subtree:add(stationType, buffer(str_offset + 22, 1))
    end
    if buffer:len() >= (str_offset + 23 + 1) then
        subtree:add(shipAndCargoFilter, buffer(str_offset + 23, 1))
    end
    if buffer:len() >= (str_offset + 27 + 1) then
        subtree:add(reportingInterval, buffer(str_offset + 27, 1))
    end
    if buffer:len() >= (str_offset + 27 + 1) then
        local _rng = buffer(str_offset + 27, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 4)) % (2 ^ 4)
        subtree:add(quietTime, _rng, _val * 60)
    end
end

return NMEA_2000_129807
