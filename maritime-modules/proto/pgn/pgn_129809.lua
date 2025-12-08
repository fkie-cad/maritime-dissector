-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129809 = Proto("nmea-2000-129809", "AIS Class B static data (msg 24 Part A) (129809)")
local messageId = ProtoField.uint8("nmea-2000-129809.messageId", "Message ID", base.DEC, NULL, 0x3f)
local repeatIndicator = ProtoField.uint8("nmea-2000-129809.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xc0)
local userId = ProtoField.uint32("nmea-2000-129809.userId", "User ID")
local name = ProtoField.string("nmea-2000-129809.name", "Name")
local aisTransceiverInformation = ProtoField.uint8("nmea-2000-129809.aisTransceiverInformation", "AIS Transceiver information", base.DEC, NULL, 0x1f)
local sequenceId = ProtoField.uint8("nmea-2000-129809.sequenceId", "Sequence ID")

NMEA_2000_129809.fields = {messageId,repeatIndicator,userId,name,aisTransceiverInformation,sequenceId}

function NMEA_2000_129809.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129809 (AIS Class B static data (msg 24 Part A))"
    local subtree = tree:add(NMEA_2000_129809, buffer(), subtree_title)
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
    if buffer:len() >= (str_offset + 5 + 20) then
        local _name_raw = buffer(str_offset + 5, 20):string()
        local _name_clean = _name_raw:gsub("[%s@%z\xff]+$", "")
        subtree:add(name, buffer(str_offset + 5, 20), _name_clean)
    end
    if buffer:len() >= (str_offset + 25 + 1) then
        subtree:add(aisTransceiverInformation, buffer(str_offset + 25, 1))
    end
    if buffer:len() >= (str_offset + 26 + 1) then
        subtree:add(sequenceId, buffer(str_offset + 26, 1))
    end
end

return NMEA_2000_129809
