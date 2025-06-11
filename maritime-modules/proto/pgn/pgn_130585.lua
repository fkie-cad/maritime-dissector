-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130585 = Proto("nmea-2000-130585", "Bluetooth source status (130585)")
local sourceNumber = ProtoField.float("nmea-2000-130585.sourceNumber", "Source number")
local status = ProtoField.uint8("nmea-2000-130585.status", "Status", base.DEC, NULL, 0xf)
local forgetDevice = ProtoField.uint8("nmea-2000-130585.forgetDevice", "Forget device", base.DEC, NULL, 0x30)
local discovering = ProtoField.uint8("nmea-2000-130585.discovering", "Discovering", base.DEC, NULL, 0xc0)

NMEA_2000_130585.fields = {sourceNumber,status,forgetDevice,discovering}

function NMEA_2000_130585.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130585 (Bluetooth source status)"
    local subtree = tree:add(NMEA_2000_130585, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sourceNumber, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(status, buffer(str_offset + 1, 1))
    subtree:add(forgetDevice, buffer(str_offset + 1, 1))
    subtree:add(discovering, buffer(str_offset + 1, 1))
end

return NMEA_2000_130585
