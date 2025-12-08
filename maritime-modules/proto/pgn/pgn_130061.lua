-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130061 = Proto("nmea-2000-130061", "Channel Source Configuration (130061)")
local dataSourceChannelId = ProtoField.uint8("nmea-2000-130061.dataSourceChannelId", "Data Source Channel ID")
local sourceSelectionStatus = ProtoField.uint32("nmea-2000-130061.sourceSelectionStatus", "Source Selection Status")
local nameSelectionCriteriaMask = ProtoField.uint32("nmea-2000-130061.nameSelectionCriteriaMask", "NAME Selection Criteria Mask", base.HEX)
local sourceName = ProtoField.uint64("nmea-2000-130061.sourceName", "Source NAME")
local pgn = ProtoField.uint24("nmea-2000-130061.pgn", "PGN")
local dataSourceInstanceFieldNumber = ProtoField.uint8("nmea-2000-130061.dataSourceInstanceFieldNumber", "Data Source Instance Field Number")
local dataSourceInstanceValue = ProtoField.uint8("nmea-2000-130061.dataSourceInstanceValue", "Data Source Instance Value")
local secondaryEnumerationFieldNumber = ProtoField.uint8("nmea-2000-130061.secondaryEnumerationFieldNumber", "Secondary Enumeration Field Number")
local secondaryEnumerationFieldValue = ProtoField.uint8("nmea-2000-130061.secondaryEnumerationFieldValue", "Secondary Enumeration Field Value")
local parameterFieldNumber = ProtoField.uint8("nmea-2000-130061.parameterFieldNumber", "Parameter Field Number")

NMEA_2000_130061.fields = {dataSourceChannelId,sourceSelectionStatus,nameSelectionCriteriaMask,sourceName,pgn,dataSourceInstanceFieldNumber,dataSourceInstanceValue,secondaryEnumerationFieldNumber,secondaryEnumerationFieldValue,parameterFieldNumber}

function NMEA_2000_130061.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130061 (Channel Source Configuration)"
    local subtree = tree:add(NMEA_2000_130061, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(dataSourceChannelId, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        local _rng = buffer(str_offset + 1, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 2)
        subtree:add(sourceSelectionStatus, _rng, _val)
    end
    do
        local _rng = buffer(str_offset + 1, 2)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 4)) % (2 ^ 12)
        subtree:add(nameSelectionCriteriaMask, _rng, _val)
    end
    if buffer:len() >= (str_offset + 3 + 8) then
        subtree:add_le(sourceName, buffer(str_offset + 3, 8))
    end
    if buffer:len() >= (str_offset + 11 + 3) then
        subtree:add_le(pgn, buffer(str_offset + 11, 3))
    end
    if buffer:len() >= (str_offset + 14 + 1) then
        subtree:add(dataSourceInstanceFieldNumber, buffer(str_offset + 14, 1))
    end
    if buffer:len() >= (str_offset + 15 + 1) then
        subtree:add(dataSourceInstanceValue, buffer(str_offset + 15, 1))
    end
    if buffer:len() >= (str_offset + 16 + 1) then
        subtree:add(secondaryEnumerationFieldNumber, buffer(str_offset + 16, 1))
    end
    if buffer:len() >= (str_offset + 17 + 1) then
        subtree:add(secondaryEnumerationFieldValue, buffer(str_offset + 17, 1))
    end
    if buffer:len() >= (str_offset + 18 + 1) then
        subtree:add(parameterFieldNumber, buffer(str_offset + 18, 1))
    end
end

return NMEA_2000_130061
