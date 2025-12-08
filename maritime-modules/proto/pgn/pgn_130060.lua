-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130060 = Proto("nmea-2000-130060", "Label (130060)")
local hardwareChannelId = ProtoField.uint8("nmea-2000-130060.hardwareChannelId", "Hardware Channel ID")
local pgn = ProtoField.uint24("nmea-2000-130060.pgn", "PGN")
local dataSourceInstanceFieldNumber = ProtoField.uint8("nmea-2000-130060.dataSourceInstanceFieldNumber", "Data Source Instance Field Number")
local dataSourceInstanceValue = ProtoField.uint8("nmea-2000-130060.dataSourceInstanceValue", "Data Source Instance Value")
local secondaryEnumerationFieldNumber = ProtoField.uint8("nmea-2000-130060.secondaryEnumerationFieldNumber", "Secondary Enumeration Field Number")
local secondaryEnumerationFieldValue = ProtoField.uint8("nmea-2000-130060.secondaryEnumerationFieldValue", "Secondary Enumeration Field Value")
local parameterFieldNumber = ProtoField.uint8("nmea-2000-130060.parameterFieldNumber", "Parameter Field Number")
local label = ProtoField.string("nmea-2000-130060.label", "Label")

NMEA_2000_130060.fields = {hardwareChannelId,pgn,dataSourceInstanceFieldNumber,dataSourceInstanceValue,secondaryEnumerationFieldNumber,secondaryEnumerationFieldValue,parameterFieldNumber,label}

function NMEA_2000_130060.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130060 (Label)"
    local subtree = tree:add(NMEA_2000_130060, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(hardwareChannelId, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 3) then
        subtree:add_le(pgn, buffer(str_offset + 1, 3))
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        subtree:add(dataSourceInstanceFieldNumber, buffer(str_offset + 4, 1))
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        subtree:add(dataSourceInstanceValue, buffer(str_offset + 5, 1))
    end
    if buffer:len() >= (str_offset + 6 + 1) then
        subtree:add(secondaryEnumerationFieldNumber, buffer(str_offset + 6, 1))
    end
    if buffer:len() >= (str_offset + 7 + 1) then
        subtree:add(secondaryEnumerationFieldValue, buffer(str_offset + 7, 1))
    end
    if buffer:len() >= (str_offset + 8 + 1) then
        subtree:add(parameterFieldNumber, buffer(str_offset + 8, 1))
    end
    if buffer:len() >= (str_offset + 9 + 1) then
        length = buffer(str_offset + 9, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 9 + 2 + length) then
            -- type = buffer(str_offset + 9 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(label, buffer(str_offset + 9 + 2, length))
            str_offset = str_offset + 9 + length + 2
        end
    end
end

return NMEA_2000_130060
