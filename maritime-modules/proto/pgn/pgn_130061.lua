-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130061 = Proto("nmea-2000-130061", "Channel Source Configuration (130061)")
local dataSourceChannelId = ProtoField.float("nmea-2000-130061.dataSourceChannelId", "Data Source Channel ID")
local sourceName = ProtoField.float("nmea-2000-130061.sourceName", "Source NAME")
local pgn = ProtoField.float("nmea-2000-130061.pgn", "PGN")
local dataSourceInstanceFieldNumber = ProtoField.float("nmea-2000-130061.dataSourceInstanceFieldNumber", "Data Source Instance Field Number")
local dataSourceInstanceValue = ProtoField.float("nmea-2000-130061.dataSourceInstanceValue", "Data Source Instance Value")
local secondaryEnumerationFieldNumber = ProtoField.float("nmea-2000-130061.secondaryEnumerationFieldNumber", "Secondary Enumeration Field Number")
local secondaryEnumerationFieldValue = ProtoField.float("nmea-2000-130061.secondaryEnumerationFieldValue", "Secondary Enumeration Field Value")
local parameterFieldNumber = ProtoField.float("nmea-2000-130061.parameterFieldNumber", "Parameter Field Number")

NMEA_2000_130061.fields = {dataSourceChannelId,sourceName,pgn,dataSourceInstanceFieldNumber,dataSourceInstanceValue,secondaryEnumerationFieldNumber,secondaryEnumerationFieldValue,parameterFieldNumber}

function NMEA_2000_130061.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130061 (Channel Source Configuration)"
    local subtree = tree:add(NMEA_2000_130061, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(dataSourceChannelId, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(sourceName, buffer(str_offset + 3, 8), buffer(str_offset + 3, 8):le_uint() * 1)
    subtree:add(pgn, buffer(str_offset + 11, 3), buffer(str_offset + 11, 3):le_uint() * 1)
    subtree:add(dataSourceInstanceFieldNumber, buffer(str_offset + 14, 1), buffer(str_offset + 14, 1):le_uint() * 1)
    subtree:add(dataSourceInstanceValue, buffer(str_offset + 15, 1), buffer(str_offset + 15, 1):le_uint() * 1)
    subtree:add(secondaryEnumerationFieldNumber, buffer(str_offset + 16, 1), buffer(str_offset + 16, 1):le_uint() * 1)
    subtree:add(secondaryEnumerationFieldValue, buffer(str_offset + 17, 1), buffer(str_offset + 17, 1):le_uint() * 1)
    subtree:add(parameterFieldNumber, buffer(str_offset + 18, 1), buffer(str_offset + 18, 1):le_uint() * 1)
end

return NMEA_2000_130061
