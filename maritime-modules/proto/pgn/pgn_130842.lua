-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130842 = Proto("nmea-2000-130842", "Simnet: AIS Class B static data (msg 24 Part B) (130842)")
local manufacturerCode = ProtoField.uint32("nmea-2000-130842.manufacturerCode", "Manufacturer Code")
local industryCode = ProtoField.uint8("nmea-2000-130842.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local messageId = ProtoField.uint32("nmea-2000-130842.messageId", "Message ID")
local repeatIndicator = ProtoField.uint8("nmea-2000-130842.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local d = ProtoField.uint8("nmea-2000-130842.d", "D")
local e = ProtoField.uint8("nmea-2000-130842.e", "E")
local userId = ProtoField.uint32("nmea-2000-130842.userId", "User ID")
local typeOfShip = ProtoField.uint8("nmea-2000-130842.typeOfShip", "Type of ship", base.DEC, NULL, 0xff)
local vendorId = ProtoField.string("nmea-2000-130842.vendorId", "Vendor ID")
local callsign = ProtoField.string("nmea-2000-130842.callsign", "Callsign")
local length = ProtoField.float("nmea-2000-130842.length", "Length (m)")
local beam = ProtoField.float("nmea-2000-130842.beam", "Beam (m)")
local positionReferenceFromStarboard = ProtoField.float("nmea-2000-130842.positionReferenceFromStarboard", "Position reference from Starboard (m)")
local positionReferenceFromBow = ProtoField.float("nmea-2000-130842.positionReferenceFromBow", "Position reference from Bow (m)")
local mothershipUserId = ProtoField.uint32("nmea-2000-130842.mothershipUserId", "Mothership User ID")

NMEA_2000_130842.fields = {manufacturerCode,industryCode,messageId,repeatIndicator,d,e,userId,typeOfShip,vendorId,callsign,length,beam,positionReferenceFromStarboard,positionReferenceFromBow,mothershipUserId}

function NMEA_2000_130842.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130842 (Simnet: AIS Class B static data (msg 24 Part B))"
    local subtree = tree:add(NMEA_2000_130842, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 2) then
        local _rng = buffer(str_offset, 2)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 11)
        subtree:add(manufacturerCode, _rng, _val)
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(industryCode, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        local _rng = buffer(str_offset + 2, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 6)
        subtree:add(messageId, _rng, _val)
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(repeatIndicator, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(d, buffer(str_offset + 3, 1))
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        subtree:add(e, buffer(str_offset + 4, 1))
    end
    if buffer:len() >= (str_offset + 5 + 4) then
        local userId_val = buffer(str_offset + 5, 4):le_uint()
        local _ti = subtree:add(userId, buffer(str_offset + 5, 4), userId_val)
        _ti:append_text(string.format(" (%09d)", userId_val))
    end
    if buffer:len() >= (str_offset + 9 + 1) then
        subtree:add(typeOfShip, buffer(str_offset + 9, 1))
    end
    if buffer:len() >= (str_offset + 10 + 7) then
        local _vendorId_raw = buffer(str_offset + 10, 7):string()
        local _vendorId_clean = _vendorId_raw:gsub("[%s@%z\xff]+$", "")
        subtree:add(vendorId, buffer(str_offset + 10, 7), _vendorId_clean)
    end
    if buffer:len() >= (str_offset + 17 + 7) then
        local _callsign_raw = buffer(str_offset + 17, 7):string()
        local _callsign_clean = _callsign_raw:gsub("[%s@%z\xff]+$", "")
        subtree:add(callsign, buffer(str_offset + 17, 7), _callsign_clean)
    end
    if buffer:len() >= (str_offset + 24 + 2) then
        subtree:add(length, buffer(str_offset + 24, 2), buffer(str_offset + 24, 2):le_uint() * 0.1)
    end
    if buffer:len() >= (str_offset + 26 + 2) then
        subtree:add(beam, buffer(str_offset + 26, 2), buffer(str_offset + 26, 2):le_uint() * 0.1)
    end
    if buffer:len() >= (str_offset + 28 + 2) then
        subtree:add(positionReferenceFromStarboard, buffer(str_offset + 28, 2), buffer(str_offset + 28, 2):le_uint() * 0.1)
    end
    if buffer:len() >= (str_offset + 30 + 2) then
        subtree:add(positionReferenceFromBow, buffer(str_offset + 30, 2), buffer(str_offset + 30, 2):le_uint() * 0.1)
    end
    if buffer:len() >= (str_offset + 32 + 4) then
        local mothershipUserId_val = buffer(str_offset + 32, 4):le_uint()
        local _ti = subtree:add(mothershipUserId, buffer(str_offset + 32, 4), mothershipUserId_val)
        _ti:append_text(string.format(" (%09d)", mothershipUserId_val))
    end
end

return NMEA_2000_130842
