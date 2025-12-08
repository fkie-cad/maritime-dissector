-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128776 = Proto("nmea-2000-128776", "Windlass Control Status (128776)")
local sid = ProtoField.uint8("nmea-2000-128776.sid", "SID")
local windlassId = ProtoField.uint8("nmea-2000-128776.windlassId", "Windlass ID")
local windlassDirectionControl = ProtoField.uint8("nmea-2000-128776.windlassDirectionControl", "Windlass Direction Control", base.DEC, NULL, 0x3)
local anchorDockingControl = ProtoField.uint8("nmea-2000-128776.anchorDockingControl", "Anchor Docking Control", base.DEC, NULL, 0xc)
local speedControlType = ProtoField.uint8("nmea-2000-128776.speedControlType", "Speed Control Type", base.DEC, NULL, 0x30)
local speedControl = ProtoField.bytes("nmea-2000-128776.speedControl", "Speed Control")
local powerEnable = ProtoField.uint8("nmea-2000-128776.powerEnable", "Power Enable", base.DEC, NULL, 0x3)
local mechanicalLock = ProtoField.uint8("nmea-2000-128776.mechanicalLock", "Mechanical Lock", base.DEC, NULL, 0xc)
local deckAndAnchorWash = ProtoField.uint8("nmea-2000-128776.deckAndAnchorWash", "Deck and Anchor Wash", base.DEC, NULL, 0x30)
local anchorLight = ProtoField.uint8("nmea-2000-128776.anchorLight", "Anchor Light", base.DEC, NULL, 0xc0)
local commandTimeout = ProtoField.float("nmea-2000-128776.commandTimeout", "Command Timeout (s)")
local windlassControlEvents = ProtoField.uint32("nmea-2000-128776.windlassControlEvents", "Windlass Control Events", base.HEX)

NMEA_2000_128776.fields = {sid,windlassId,windlassDirectionControl,anchorDockingControl,speedControlType,speedControl,powerEnable,mechanicalLock,deckAndAnchorWash,anchorLight,commandTimeout,windlassControlEvents}

function NMEA_2000_128776.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128776 (Windlass Control Status)"
    local subtree = tree:add(NMEA_2000_128776, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sid, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(windlassId, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(windlassDirectionControl, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(anchorDockingControl, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(speedControlType, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(speedControl, buffer(str_offset + 3, 1))
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        subtree:add(powerEnable, buffer(str_offset + 4, 1))
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        subtree:add(mechanicalLock, buffer(str_offset + 4, 1))
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        subtree:add(deckAndAnchorWash, buffer(str_offset + 4, 1))
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        subtree:add(anchorLight, buffer(str_offset + 4, 1))
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        subtree:add(commandTimeout, buffer(str_offset + 5, 1), buffer(str_offset + 5, 1):le_uint() * 0.005)
    end
    if buffer:len() >= (str_offset + 6 + 1) then
        local _rng = buffer(str_offset + 6, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 4)
        subtree:add(windlassControlEvents, _rng, _val)
    end
end

return NMEA_2000_128776
