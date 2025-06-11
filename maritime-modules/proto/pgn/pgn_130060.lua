-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130060 = Proto("nmea-2000-130060", "Label (130060)")
local hardwareChannelId = ProtoField.float("nmea-2000-130060.hardwareChannelId", "Hardware Channel ID")
local pgn = ProtoField.float("nmea-2000-130060.pgn", "PGN")
local dataSourceInstanceFieldNumber = ProtoField.float("nmea-2000-130060.dataSourceInstanceFieldNumber", "Data Source Instance Field Number")
local dataSourceInstanceValue = ProtoField.float("nmea-2000-130060.dataSourceInstanceValue", "Data Source Instance Value")
local secondaryEnumerationFieldNumber = ProtoField.float("nmea-2000-130060.secondaryEnumerationFieldNumber", "Secondary Enumeration Field Number")
local secondaryEnumerationFieldValue = ProtoField.float("nmea-2000-130060.secondaryEnumerationFieldValue", "Secondary Enumeration Field Value")
local parameterFieldNumber = ProtoField.float("nmea-2000-130060.parameterFieldNumber", "Parameter Field Number")
local label = ProtoField.string("nmea-2000-130060.label", "Label")

NMEA_2000_130060.fields = {hardwareChannelId,pgn,dataSourceInstanceFieldNumber,dataSourceInstanceValue,secondaryEnumerationFieldNumber,secondaryEnumerationFieldValue,parameterFieldNumber,label}

function NMEA_2000_130060.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130060 (Label)"
    local subtree = tree:add(NMEA_2000_130060, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(hardwareChannelId, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(pgn, buffer(str_offset + 1, 3), buffer(str_offset + 1, 3):le_uint() * 1)
    subtree:add(dataSourceInstanceFieldNumber, buffer(str_offset + 4, 1), buffer(str_offset + 4, 1):le_uint() * 1)
    subtree:add(dataSourceInstanceValue, buffer(str_offset + 5, 1), buffer(str_offset + 5, 1):le_uint() * 1)
    subtree:add(secondaryEnumerationFieldNumber, buffer(str_offset + 6, 1), buffer(str_offset + 6, 1):le_uint() * 1)
    subtree:add(secondaryEnumerationFieldValue, buffer(str_offset + 7, 1), buffer(str_offset + 7, 1):le_uint() * 1)
    subtree:add(parameterFieldNumber, buffer(str_offset + 8, 1), buffer(str_offset + 8, 1):le_uint() * 1)
    length = buffer(str_offset + 9, 1):uint() - 2
    -- type = buffer(str_offset + 9 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(label, buffer(str_offset + 9 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_130060
