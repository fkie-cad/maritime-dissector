-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127751 = Proto("nmea-2000-127751", "DC Voltage/Current (127751)")
local sid = ProtoField.bytes("nmea-2000-127751.sid", "SID")
local connectionNumber = ProtoField.uint8("nmea-2000-127751.connectionNumber", "Connection Number")
local dcVoltage = ProtoField.float("nmea-2000-127751.dcVoltage", "DC Voltage (V)")
local dcCurrent = ProtoField.float("nmea-2000-127751.dcCurrent", "DC Current (A)")

NMEA_2000_127751.fields = {sid,connectionNumber,dcVoltage,dcCurrent}

function NMEA_2000_127751.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127751 (DC Voltage/Current)"
    local subtree = tree:add(NMEA_2000_127751, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sid, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(connectionNumber, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add(dcVoltage, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 0.1)
    end
    if buffer:len() >= (str_offset + 4 + 3) then
        subtree:add(dcCurrent, buffer(str_offset + 4, 3), buffer(str_offset + 4, 3):le_int() * 0.01)
    end
end

return NMEA_2000_127751
