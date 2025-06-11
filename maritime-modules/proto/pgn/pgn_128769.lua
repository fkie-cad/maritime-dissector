-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128769 = Proto("nmea-2000-128769", "Elevator Deck Push Button (128769)")
local sid = ProtoField.float("nmea-2000-128769.sid", "SID")
local elevatorCallButtonId = ProtoField.float("nmea-2000-128769.elevatorCallButtonId", "Elevator Call Button ID")
local deckButtonId = ProtoField.float("nmea-2000-128769.deckButtonId", "Deck Button ID")
local elevatorCarUsage = ProtoField.float("nmea-2000-128769.elevatorCarUsage", "Elevator Car Usage")
local elevatorCarButtonSelection = ProtoField.float("nmea-2000-128769.elevatorCarButtonSelection", "Elevator Car Button Selection")

NMEA_2000_128769.fields = {sid,elevatorCallButtonId,deckButtonId,elevatorCarUsage,elevatorCarButtonSelection}

function NMEA_2000_128769.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128769 (Elevator Deck Push Button)"
    local subtree = tree:add(NMEA_2000_128769, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(elevatorCallButtonId, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(deckButtonId, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(elevatorCarUsage, buffer(str_offset + 3, 1), buffer(str_offset + 3, 1):le_uint() * 1)
    subtree:add(elevatorCarButtonSelection, buffer(str_offset + 4, 1), buffer(str_offset + 4, 1):le_uint() * 1)
end

return NMEA_2000_128769
