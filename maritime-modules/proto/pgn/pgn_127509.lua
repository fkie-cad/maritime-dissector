-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127509 = Proto("nmea-2000-127509", "Inverter Status (127509)")
local instance = ProtoField.uint8("nmea-2000-127509.instance", "Instance")
local acInstance = ProtoField.uint8("nmea-2000-127509.acInstance", "AC Instance")
local dcInstance = ProtoField.uint8("nmea-2000-127509.dcInstance", "DC Instance")
local operatingState = ProtoField.uint8("nmea-2000-127509.operatingState", "Operating State", base.DEC, NULL, 0xf)
local inverterEnable = ProtoField.uint8("nmea-2000-127509.inverterEnable", "Inverter Enable", base.DEC, NULL, 0x30)

NMEA_2000_127509.fields = {instance,acInstance,dcInstance,operatingState,inverterEnable}

function NMEA_2000_127509.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127509 (Inverter Status)"
    local subtree = tree:add(NMEA_2000_127509, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(instance, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(acInstance, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(dcInstance, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(operatingState, buffer(str_offset + 3, 1))
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(inverterEnable, buffer(str_offset + 3, 1))
    end
end

return NMEA_2000_127509
