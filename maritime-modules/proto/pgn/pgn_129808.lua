-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129808 = Proto("nmea-2000-129808", "DSC Call Information (129808)")
local dscFormatSymbol = ProtoField.uint8("nmea-2000-129808.dscFormatSymbol", "DSC Format Symbol", base.DEC, NULL, 0xff)
local dscCategorySymbol = ProtoField.uint8("nmea-2000-129808.dscCategorySymbol", "DSC Category Symbol", base.DEC, NULL, 0xff)
local firsttTelecommand = ProtoField.uint8("nmea-2000-129808.firsttTelecommand", "1st Telecommand", base.DEC, NULL, 0xff)
local subsequentCommunicationModeOr2ndTelecommand = ProtoField.uint8("nmea-2000-129808.subsequentCommunicationModeOr2ndTelecommand", "Subsequent Communication Mode or 2nd Telecommand", base.DEC, NULL, 0xff)
local proposedRxFrequencyChannel = ProtoField.string("nmea-2000-129808.proposedRxFrequencyChannel", "Proposed Rx Frequency/Channel")
local proposedTxFrequencyChannel = ProtoField.string("nmea-2000-129808.proposedTxFrequencyChannel", "Proposed Tx Frequency/Channel")
local telephoneNumber = ProtoField.string("nmea-2000-129808.telephoneNumber", "Telephone Number")
local dscExpansionFieldData = ProtoField.string("nmea-2000-129808.dscExpansionFieldData", "DSC Expansion Field Data")

NMEA_2000_129808.fields = {dscFormatSymbol,dscCategorySymbol,firsttTelecommand,subsequentCommunicationModeOr2ndTelecommand,proposedRxFrequencyChannel,proposedTxFrequencyChannel,telephoneNumber,dscExpansionFieldData}

function NMEA_2000_129808.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129808 (DSC Call Information)"
    local subtree = tree:add(NMEA_2000_129808, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(dscFormatSymbol, buffer(str_offset + 0, 1))
    subtree:add(dscCategorySymbol, buffer(str_offset + 1, 1))
    subtree:add(firsttTelecommand, buffer(str_offset + 7, 1))
    subtree:add(subsequentCommunicationModeOr2ndTelecommand, buffer(str_offset + 8, 1))
    subtree:add(proposedRxFrequencyChannel, buffer(str_offset + 9, 6))
    subtree:add(proposedTxFrequencyChannel, buffer(str_offset + 15, 6))
    length = buffer(str_offset + 21, 1):uint() - 2
    -- type = buffer(str_offset + 21 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(telephoneNumber, buffer(str_offset + 21 + 2, length))
    str_offset = str_offset + length + 2
    length = buffer(str_offset + 0, 1):uint() - 2
    -- type = buffer(str_offset + 0 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(dscExpansionFieldData, buffer(str_offset + 0 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_129808
