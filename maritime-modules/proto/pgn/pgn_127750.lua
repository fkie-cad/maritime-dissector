-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127750 = Proto("nmea-2000-127750", "Converter Status (127750)")
local sid = ProtoField.bytes("nmea-2000-127750.sid", "SID")
local connectionNumber = ProtoField.uint8("nmea-2000-127750.connectionNumber", "Connection Number")
local operatingState = ProtoField.uint8("nmea-2000-127750.operatingState", "Operating State", base.DEC, NULL, 0xff)
local temperatureState = ProtoField.uint8("nmea-2000-127750.temperatureState", "Temperature State", base.DEC, NULL, 0x3)
local overloadState = ProtoField.uint8("nmea-2000-127750.overloadState", "Overload State", base.DEC, NULL, 0xc)
local lowDcVoltageState = ProtoField.uint8("nmea-2000-127750.lowDcVoltageState", "Low DC Voltage State", base.DEC, NULL, 0x30)
local rippleState = ProtoField.uint8("nmea-2000-127750.rippleState", "Ripple State", base.DEC, NULL, 0xc0)

NMEA_2000_127750.fields = {sid,connectionNumber,operatingState,temperatureState,overloadState,lowDcVoltageState,rippleState}

function NMEA_2000_127750.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127750 (Converter Status)"
    local subtree = tree:add(NMEA_2000_127750, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sid, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(connectionNumber, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(operatingState, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(temperatureState, buffer(str_offset + 3, 1))
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(overloadState, buffer(str_offset + 3, 1))
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(lowDcVoltageState, buffer(str_offset + 3, 1))
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(rippleState, buffer(str_offset + 3, 1))
    end
end

return NMEA_2000_127750
