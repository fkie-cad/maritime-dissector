-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127750 = Proto("nmea-2000-127750", "Converter Status (127750)")
local connectionNumber = ProtoField.float("nmea-2000-127750.connectionNumber", "Connection Number")
local operatingState = ProtoField.uint8("nmea-2000-127750.operatingState", "Operating State", base.DEC, NULL, 0xff)
local temperatureState = ProtoField.uint8("nmea-2000-127750.temperatureState", "Temperature State", base.DEC, NULL, 0x3)
local overloadState = ProtoField.uint8("nmea-2000-127750.overloadState", "Overload State", base.DEC, NULL, 0xc)
local lowDcVoltageState = ProtoField.uint8("nmea-2000-127750.lowDcVoltageState", "Low DC Voltage State", base.DEC, NULL, 0x30)
local rippleState = ProtoField.uint8("nmea-2000-127750.rippleState", "Ripple State", base.DEC, NULL, 0xc0)

NMEA_2000_127750.fields = {connectionNumber,operatingState,temperatureState,overloadState,lowDcVoltageState,rippleState}

function NMEA_2000_127750.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127750 (Converter Status)"
    local subtree = tree:add(NMEA_2000_127750, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(connectionNumber, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(operatingState, buffer(str_offset + 2, 1))
    subtree:add(temperatureState, buffer(str_offset + 3, 1))
    subtree:add(overloadState, buffer(str_offset + 3, 1))
    subtree:add(lowDcVoltageState, buffer(str_offset + 3, 1))
    subtree:add(rippleState, buffer(str_offset + 3, 1))
end

return NMEA_2000_127750
