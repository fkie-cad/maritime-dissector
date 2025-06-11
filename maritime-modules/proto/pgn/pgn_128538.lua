-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128538 = Proto("nmea-2000-128538", "Elevator Car Status (128538)")
local sid = ProtoField.float("nmea-2000-128538.sid", "SID")
local elevatorCarId = ProtoField.float("nmea-2000-128538.elevatorCarId", "Elevator Car ID")
local elevatorCarUsage = ProtoField.float("nmea-2000-128538.elevatorCarUsage", "Elevator Car Usage")
local currentDeck = ProtoField.float("nmea-2000-128538.currentDeck", "Current Deck")
local destinationDeck = ProtoField.float("nmea-2000-128538.destinationDeck", "Destination Deck")
local totalNumberOfDecks = ProtoField.float("nmea-2000-128538.totalNumberOfDecks", "Total Number of Decks")
local weightOfLoadCell1 = ProtoField.float("nmea-2000-128538.weightOfLoadCell1", "Weight of Load Cell 1")
local weightOfLoadCell2 = ProtoField.float("nmea-2000-128538.weightOfLoadCell2", "Weight of Load Cell 2")
local weightOfLoadCell3 = ProtoField.float("nmea-2000-128538.weightOfLoadCell3", "Weight of Load Cell 3")
local weightOfLoadCell4 = ProtoField.float("nmea-2000-128538.weightOfLoadCell4", "Weight of Load Cell 4")
local speedOfElevatorCar = ProtoField.float("nmea-2000-128538.speedOfElevatorCar", "Speed of Elevator Car (m/s)")

NMEA_2000_128538.fields = {sid,elevatorCarId,elevatorCarUsage,currentDeck,destinationDeck,totalNumberOfDecks,weightOfLoadCell1,weightOfLoadCell2,weightOfLoadCell3,weightOfLoadCell4,speedOfElevatorCar}

function NMEA_2000_128538.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128538 (Elevator Car Status)"
    local subtree = tree:add(NMEA_2000_128538, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(elevatorCarId, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(elevatorCarUsage, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(currentDeck, buffer(str_offset + 8, 1), buffer(str_offset + 8, 1):le_uint() * 1)
    subtree:add(destinationDeck, buffer(str_offset + 9, 1), buffer(str_offset + 9, 1):le_uint() * 1)
    subtree:add(totalNumberOfDecks, buffer(str_offset + 10, 1), buffer(str_offset + 10, 1):le_uint() * 1)
    subtree:add(weightOfLoadCell1, buffer(str_offset + 11, 2), buffer(str_offset + 11, 2):le_uint() * 1)
    subtree:add(weightOfLoadCell2, buffer(str_offset + 13, 2), buffer(str_offset + 13, 2):le_uint() * 1)
    subtree:add(weightOfLoadCell3, buffer(str_offset + 15, 2), buffer(str_offset + 15, 2):le_uint() * 1)
    subtree:add(weightOfLoadCell4, buffer(str_offset + 17, 2), buffer(str_offset + 17, 2):le_uint() * 1)
    subtree:add(speedOfElevatorCar, buffer(str_offset + 19, 2), buffer(str_offset + 19, 2):le_int() * 0.01)
end

return NMEA_2000_128538
