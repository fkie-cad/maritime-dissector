-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129798 = Proto("nmea-2000-129798", "AIS SAR Aircraft Position Report (129798)")
local messageId = ProtoField.uint8("nmea-2000-129798.messageId", "Message ID", base.DEC, NULL, 0x3f)
local repeatIndicator = ProtoField.uint8("nmea-2000-129798.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local userId = ProtoField.uint32("nmea-2000-129798.userId", "User ID")
local longitude = ProtoField.float("nmea-2000-129798.longitude", "Longitude (deg)")
local latitude = ProtoField.float("nmea-2000-129798.latitude", "Latitude (deg)")
local positionAccuracy = ProtoField.uint8("nmea-2000-129798.positionAccuracy", "Position Accuracy", base.DEC, NULL, 0x1)
local raim = ProtoField.uint8("nmea-2000-129798.raim", "RAIM", base.DEC, NULL, 0x2)
local timeStamp = ProtoField.uint8("nmea-2000-129798.timeStamp", "Time Stamp", base.DEC, NULL, 0xfc)
local cog = ProtoField.float("nmea-2000-129798.cog", "COG (rad)")
local sog = ProtoField.float("nmea-2000-129798.sog", "SOG (m/s)")
local communicationState = ProtoField.uint32("nmea-2000-129798.communicationState", "Communication State", base.HEX)
local aisTransceiverInformation = ProtoField.uint8("nmea-2000-129798.aisTransceiverInformation", "AIS Transceiver information", base.DEC, NULL, 0xf8)
local altitude = ProtoField.float("nmea-2000-129798.altitude", "Altitude (m)")
local reservedForRegionalApplications = ProtoField.bytes("nmea-2000-129798.reservedForRegionalApplications", "Reserved for Regional Applications")
local dte = ProtoField.uint8("nmea-2000-129798.dte", "DTE", base.DEC, NULL, 0x1)

NMEA_2000_129798.fields = {messageId,repeatIndicator,userId,longitude,latitude,positionAccuracy,raim,timeStamp,cog,sog,communicationState,aisTransceiverInformation,altitude,reservedForRegionalApplications,dte}

function NMEA_2000_129798.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129798 (AIS SAR Aircraft Position Report)"
    local subtree = tree:add(NMEA_2000_129798, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(messageId, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(repeatIndicator, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 4) then
        local userId_val = buffer(str_offset + 1, 4):le_uint()
        local _ti = subtree:add(userId, buffer(str_offset + 1, 4), userId_val)
        _ti:append_text(string.format(" (%09d)", userId_val))
    end
    if buffer:len() >= (str_offset + 5 + 4) then
        subtree:add(longitude, buffer(str_offset + 5, 4), buffer(str_offset + 5, 4):le_int() * 1e-07)
    end
    if buffer:len() >= (str_offset + 9 + 4) then
        subtree:add(latitude, buffer(str_offset + 9, 4), buffer(str_offset + 9, 4):le_int() * 1e-07)
    end
    if buffer:len() >= (str_offset + 13 + 1) then
        subtree:add(positionAccuracy, buffer(str_offset + 13, 1))
    end
    if buffer:len() >= (str_offset + 13 + 1) then
        subtree:add(raim, buffer(str_offset + 13, 1))
    end
    if buffer:len() >= (str_offset + 13 + 1) then
        subtree:add(timeStamp, buffer(str_offset + 13, 1))
    end
    if buffer:len() >= (str_offset + 14 + 2) then
        subtree:add(cog, buffer(str_offset + 14, 2), buffer(str_offset + 14, 2):le_uint() * 0.0001)
    end
    if buffer:len() >= (str_offset + 16 + 2) then
        subtree:add(sog, buffer(str_offset + 16, 2), buffer(str_offset + 16, 2):le_uint() * 0.1)
    end
    do
        local _rng = buffer(str_offset + 18, 3)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 19)
        subtree:add(communicationState, _rng, _val)
    end
    if buffer:len() >= (str_offset + 20 + 1) then
        subtree:add(aisTransceiverInformation, buffer(str_offset + 20, 1))
    end
    if buffer:len() >= (str_offset + 21 + 4) then
        subtree:add(altitude, buffer(str_offset + 21, 4), buffer(str_offset + 21, 4):le_int() * 0.01)
    end
    if buffer:len() >= (str_offset + 25 + 1) then
        subtree:add(reservedForRegionalApplications, buffer(str_offset + 25, 1))
    end
    if buffer:len() >= (str_offset + 26 + 1) then
        subtree:add(dte, buffer(str_offset + 26, 1))
    end
end

return NMEA_2000_129798
