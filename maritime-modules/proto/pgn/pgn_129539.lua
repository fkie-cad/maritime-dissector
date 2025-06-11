-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129539 = Proto("nmea-2000-129539", "GNSS DOPs (129539)")
local sid = ProtoField.float("nmea-2000-129539.sid", "SID")
local desiredMode = ProtoField.uint8("nmea-2000-129539.desiredMode", "Desired Mode", base.DEC, NULL, 0x7)
local actualMode = ProtoField.uint8("nmea-2000-129539.actualMode", "Actual Mode", base.DEC, NULL, 0x38)
local hdop = ProtoField.float("nmea-2000-129539.hdop", "HDOP")
local vdop = ProtoField.float("nmea-2000-129539.vdop", "VDOP")
local tdop = ProtoField.float("nmea-2000-129539.tdop", "TDOP")

NMEA_2000_129539.fields = {sid,desiredMode,actualMode,hdop,vdop,tdop}

function NMEA_2000_129539.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129539 (GNSS DOPs)"
    local subtree = tree:add(NMEA_2000_129539, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(desiredMode, buffer(str_offset + 1, 1))
    subtree:add(actualMode, buffer(str_offset + 1, 1))
    subtree:add(hdop, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_int() * 0.01)
    subtree:add(vdop, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_int() * 0.01)
    subtree:add(tdop, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_int() * 0.01)
end

return NMEA_2000_129539
