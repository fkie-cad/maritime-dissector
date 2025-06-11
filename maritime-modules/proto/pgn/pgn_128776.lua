-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128776 = Proto("nmea-2000-128776", "Windlass Control Status (128776)")
local sid = ProtoField.float("nmea-2000-128776.sid", "SID")
local windlassId = ProtoField.float("nmea-2000-128776.windlassId", "Windlass ID")
local windlassDirectionControl = ProtoField.uint8("nmea-2000-128776.windlassDirectionControl", "Windlass Direction Control", base.DEC, NULL, 0x3)
local anchorDockingControl = ProtoField.uint8("nmea-2000-128776.anchorDockingControl", "Anchor Docking Control", base.DEC, NULL, 0xc)
local speedControlType = ProtoField.uint8("nmea-2000-128776.speedControlType", "Speed Control Type", base.DEC, NULL, 0x30)
local powerEnable = ProtoField.uint8("nmea-2000-128776.powerEnable", "Power Enable", base.DEC, NULL, 0x3)
local mechanicalLock = ProtoField.uint8("nmea-2000-128776.mechanicalLock", "Mechanical Lock", base.DEC, NULL, 0xc)
local deckAndAnchorWash = ProtoField.uint8("nmea-2000-128776.deckAndAnchorWash", "Deck and Anchor Wash", base.DEC, NULL, 0x30)
local anchorLight = ProtoField.uint8("nmea-2000-128776.anchorLight", "Anchor Light", base.DEC, NULL, 0xc0)
local commandTimeout = ProtoField.float("nmea-2000-128776.commandTimeout", "Command Timeout (s)")

NMEA_2000_128776.fields = {sid,windlassId,windlassDirectionControl,anchorDockingControl,speedControlType,powerEnable,mechanicalLock,deckAndAnchorWash,anchorLight,commandTimeout}

function NMEA_2000_128776.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128776 (Windlass Control Status)"
    local subtree = tree:add(NMEA_2000_128776, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(windlassId, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(windlassDirectionControl, buffer(str_offset + 2, 1))
    subtree:add(anchorDockingControl, buffer(str_offset + 2, 1))
    subtree:add(speedControlType, buffer(str_offset + 2, 1))
    subtree:add(powerEnable, buffer(str_offset + 4, 1))
    subtree:add(mechanicalLock, buffer(str_offset + 4, 1))
    subtree:add(deckAndAnchorWash, buffer(str_offset + 4, 1))
    subtree:add(anchorLight, buffer(str_offset + 4, 1))
    subtree:add(commandTimeout, buffer(str_offset + 5, 1), buffer(str_offset + 5, 1):le_uint() * 0.005)
end

return NMEA_2000_128776
