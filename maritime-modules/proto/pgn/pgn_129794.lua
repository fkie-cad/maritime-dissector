-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129794 = Proto("nmea-2000-129794", "AIS Class A Static and Voyage Related Data (129794)")
local messageId = ProtoField.uint8("nmea-2000-129794.messageId", "Message ID", base.DEC, NULL, 0x3f)
local repeatIndicator = ProtoField.uint8("nmea-2000-129794.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local userId = ProtoField.uint32("nmea-2000-129794.userId", "User ID")
local imoNumber = ProtoField.uint32("nmea-2000-129794.imoNumber", "IMO number")
local callsign = ProtoField.string("nmea-2000-129794.callsign", "Callsign")
local name = ProtoField.string("nmea-2000-129794.name", "Name")
local typeOfShip = ProtoField.uint8("nmea-2000-129794.typeOfShip", "Type of ship", base.DEC, NULL, 0xff)
local length = ProtoField.float("nmea-2000-129794.length", "Length (m)")
local beam = ProtoField.float("nmea-2000-129794.beam", "Beam (m)")
local positionReferenceFromStarboard = ProtoField.float("nmea-2000-129794.positionReferenceFromStarboard", "Position reference from Starboard (m)")
local positionReferenceFromBow = ProtoField.float("nmea-2000-129794.positionReferenceFromBow", "Position reference from Bow (m)")
local etaDate = ProtoField.uint16("nmea-2000-129794.etaDate", "ETA Date (d)")
local etaTime = ProtoField.float("nmea-2000-129794.etaTime", "ETA Time (s)")
local draft = ProtoField.float("nmea-2000-129794.draft", "Draft (m)")
local destination = ProtoField.string("nmea-2000-129794.destination", "Destination")
local aisVersionIndicator = ProtoField.uint8("nmea-2000-129794.aisVersionIndicator", "AIS version indicator", base.DEC, NULL, 0x3)
local gnssType = ProtoField.uint8("nmea-2000-129794.gnssType", "GNSS type", base.DEC, NULL, 0x3c)
local dte = ProtoField.uint8("nmea-2000-129794.dte", "DTE", base.DEC, NULL, 0x40)
local aisTransceiverInformation = ProtoField.uint8("nmea-2000-129794.aisTransceiverInformation", "AIS Transceiver information", base.DEC, NULL, 0x1f)

NMEA_2000_129794.fields = {messageId,repeatIndicator,userId,imoNumber,callsign,name,typeOfShip,length,beam,positionReferenceFromStarboard,positionReferenceFromBow,etaDate,etaTime,draft,destination,aisVersionIndicator,gnssType,dte,aisTransceiverInformation}

function NMEA_2000_129794.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129794 (AIS Class A Static and Voyage Related Data)"
    local subtree = tree:add(NMEA_2000_129794, buffer(), subtree_title)
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
        subtree:add_le(imoNumber, buffer(str_offset + 5, 4))
    end
    if buffer:len() >= (str_offset + 9 + 7) then
        local _callsign_raw = buffer(str_offset + 9, 7):string()
        local _callsign_clean = _callsign_raw:gsub("[%s@%z\xff]+$", "")
        subtree:add(callsign, buffer(str_offset + 9, 7), _callsign_clean)
    end
    if buffer:len() >= (str_offset + 16 + 20) then
        local _name_raw = buffer(str_offset + 16, 20):string()
        local _name_clean = _name_raw:gsub("[%s@%z\xff]+$", "")
        subtree:add(name, buffer(str_offset + 16, 20), _name_clean)
    end
    if buffer:len() >= (str_offset + 36 + 1) then
        subtree:add(typeOfShip, buffer(str_offset + 36, 1))
    end
    if buffer:len() >= (str_offset + 37 + 2) then
        subtree:add(length, buffer(str_offset + 37, 2), buffer(str_offset + 37, 2):le_uint() * 0.1)
    end
    if buffer:len() >= (str_offset + 39 + 2) then
        subtree:add(beam, buffer(str_offset + 39, 2), buffer(str_offset + 39, 2):le_uint() * 0.1)
    end
    if buffer:len() >= (str_offset + 41 + 2) then
        subtree:add(positionReferenceFromStarboard, buffer(str_offset + 41, 2), buffer(str_offset + 41, 2):le_uint() * 0.1)
    end
    if buffer:len() >= (str_offset + 43 + 2) then
        subtree:add(positionReferenceFromBow, buffer(str_offset + 43, 2), buffer(str_offset + 43, 2):le_uint() * 0.1)
    end
    if buffer:len() >= (str_offset + 45 + 2) then
        subtree:add_le(etaDate, buffer(str_offset + 45, 2))
    end
    if buffer:len() >= (str_offset + 47 + 4) then
        subtree:add(etaTime, buffer(str_offset + 47, 4), buffer(str_offset + 47, 4):le_uint() * 0.0001)
    end
    if buffer:len() >= (str_offset + 51 + 2) then
        subtree:add(draft, buffer(str_offset + 51, 2), buffer(str_offset + 51, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 53 + 20) then
        local _destination_raw = buffer(str_offset + 53, 20):string()
        local _destination_clean = _destination_raw:gsub("[%s@%z\xff]+$", "")
        subtree:add(destination, buffer(str_offset + 53, 20), _destination_clean)
    end
    if buffer:len() >= (str_offset + 73 + 1) then
        subtree:add(aisVersionIndicator, buffer(str_offset + 73, 1))
    end
    if buffer:len() >= (str_offset + 73 + 1) then
        subtree:add(gnssType, buffer(str_offset + 73, 1))
    end
    if buffer:len() >= (str_offset + 73 + 1) then
        subtree:add(dte, buffer(str_offset + 73, 1))
    end
    if buffer:len() >= (str_offset + 74 + 1) then
        subtree:add(aisTransceiverInformation, buffer(str_offset + 74, 1))
    end
end

return NMEA_2000_129794
