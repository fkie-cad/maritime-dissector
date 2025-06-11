-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_126993 = Proto("nmea-2000-126993", "Heartbeat (126993)")
local dataTransmitOffset = ProtoField.float("nmea-2000-126993.dataTransmitOffset", "Data transmit offset (s)")
local sequenceCounter = ProtoField.float("nmea-2000-126993.sequenceCounter", "Sequence Counter")
local controller1State = ProtoField.uint8("nmea-2000-126993.controller1State", "Controller 1 State", base.DEC, NULL, 0x3)
local controller2State = ProtoField.uint8("nmea-2000-126993.controller2State", "Controller 2 State", base.DEC, NULL, 0xc)
local equipmentStatus = ProtoField.uint8("nmea-2000-126993.equipmentStatus", "Equipment Status", base.DEC, NULL, 0x30)

NMEA_2000_126993.fields = {dataTransmitOffset,sequenceCounter,controller1State,controller2State,equipmentStatus}

function NMEA_2000_126993.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 126993 (Heartbeat)"
    local subtree = tree:add(NMEA_2000_126993, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(dataTransmitOffset, buffer(str_offset + 0, 2), buffer(str_offset + 0, 2):le_uint() * 0.01)
    subtree:add(sequenceCounter, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(controller1State, buffer(str_offset + 3, 1))
    subtree:add(controller2State, buffer(str_offset + 3, 1))
    subtree:add(equipmentStatus, buffer(str_offset + 3, 1))
end

return NMEA_2000_126993
