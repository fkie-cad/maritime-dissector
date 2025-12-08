-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129808 = Proto("nmea-2000-129808", "DSC Call Information (129808)")
local dscFormatSymbol = ProtoField.uint8("nmea-2000-129808.dscFormatSymbol", "DSC Format Symbol", base.DEC, NULL, 0xff)
local dscCategorySymbol = ProtoField.uint8("nmea-2000-129808.dscCategorySymbol", "DSC Category Symbol", base.DEC, NULL, 0xff)
local dscMessageAddress = ProtoField.bytes("nmea-2000-129808.dscMessageAddress", "DSC Message Address")
local firstTelecommand = ProtoField.uint8("nmea-2000-129808.firstTelecommand", "1st Telecommand", base.DEC, NULL, 0xff)
local subsequentCommunicationModeOr2ndTelecommand = ProtoField.uint8("nmea-2000-129808.subsequentCommunicationModeOr2ndTelecommand", "Subsequent Communication Mode or 2nd Telecommand", base.DEC, NULL, 0xff)
local proposedRxFrequencyChannel = ProtoField.string("nmea-2000-129808.proposedRxFrequencyChannel", "Proposed Rx Frequency/Channel")
local proposedTxFrequencyChannel = ProtoField.string("nmea-2000-129808.proposedTxFrequencyChannel", "Proposed Tx Frequency/Channel")
local telephoneNumber = ProtoField.string("nmea-2000-129808.telephoneNumber", "Telephone Number")
local latitudeOfVesselReported = ProtoField.float("nmea-2000-129808.latitudeOfVesselReported", "Latitude of Vessel Reported (deg)")
local longitudeOfVesselReported = ProtoField.float("nmea-2000-129808.longitudeOfVesselReported", "Longitude of Vessel Reported (deg)")
local timeOfPosition = ProtoField.float("nmea-2000-129808.timeOfPosition", "Time of Position (s)")
local mmsiOfShipInDistress = ProtoField.bytes("nmea-2000-129808.mmsiOfShipInDistress", "MMSI of Ship In Distress")
local dscEosSymbol = ProtoField.uint8("nmea-2000-129808.dscEosSymbol", "DSC EOS Symbol")
local expansionEnabled = ProtoField.uint32("nmea-2000-129808.expansionEnabled", "Expansion Enabled", base.DEC)
local callingRxFrequencyChannel = ProtoField.string("nmea-2000-129808.callingRxFrequencyChannel", "Calling Rx Frequency/Channel")
local callingTxFrequencyChannel = ProtoField.string("nmea-2000-129808.callingTxFrequencyChannel", "Calling Tx Frequency/Channel")
local timeOfReceipt = ProtoField.float("nmea-2000-129808.timeOfReceipt", "Time of Receipt (s)")
local dateOfReceipt = ProtoField.uint16("nmea-2000-129808.dateOfReceipt", "Date of Receipt (d)")
local dscEquipmentAssignedMessageId = ProtoField.uint16("nmea-2000-129808.dscEquipmentAssignedMessageId", "DSC Equipment Assigned Message ID")
local dscExpansionFieldSymbol = ProtoField.uint8("nmea-2000-129808.dscExpansionFieldSymbol", "DSC Expansion Field Symbol", base.DEC)
local dscExpansionFieldData = ProtoField.string("nmea-2000-129808.dscExpansionFieldData", "DSC Expansion Field Data")

NMEA_2000_129808.fields = {dscFormatSymbol,dscCategorySymbol,dscMessageAddress,firstTelecommand,subsequentCommunicationModeOr2ndTelecommand,proposedRxFrequencyChannel,proposedTxFrequencyChannel,telephoneNumber,latitudeOfVesselReported,longitudeOfVesselReported,timeOfPosition,mmsiOfShipInDistress,dscEosSymbol,expansionEnabled,callingRxFrequencyChannel,callingTxFrequencyChannel,timeOfReceipt,dateOfReceipt,dscEquipmentAssignedMessageId,dscExpansionFieldSymbol,dscExpansionFieldData}

function NMEA_2000_129808.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129808 (DSC Call Information)"
    local subtree = tree:add(NMEA_2000_129808, buffer(), subtree_title)
    local str_offset = 0
    local bitfield_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(dscFormatSymbol, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(dscCategorySymbol, buffer(str_offset + 1, 1))
    end
    subtree:add(dscMessageAddress, buffer(str_offset + 2, 5))
    if buffer:len() >= (str_offset + 7 + 1) then
        subtree:add(firstTelecommand, buffer(str_offset + 7, 1))
    end
    if buffer:len() >= (str_offset + 8 + 1) then
        subtree:add(subsequentCommunicationModeOr2ndTelecommand, buffer(str_offset + 8, 1))
    end
    if buffer:len() >= (str_offset + 9 + 6) then
        local _proposedRxFrequencyChannel_raw = buffer(str_offset + 9, 6):string()
        local _proposedRxFrequencyChannel_clean = _proposedRxFrequencyChannel_raw:gsub("[%s@%z\xff]+$", "")
        subtree:add(proposedRxFrequencyChannel, buffer(str_offset + 9, 6), _proposedRxFrequencyChannel_clean)
    end
    if buffer:len() >= (str_offset + 15 + 6) then
        local _proposedTxFrequencyChannel_raw = buffer(str_offset + 15, 6):string()
        local _proposedTxFrequencyChannel_clean = _proposedTxFrequencyChannel_raw:gsub("[%s@%z\xff]+$", "")
        subtree:add(proposedTxFrequencyChannel, buffer(str_offset + 15, 6), _proposedTxFrequencyChannel_clean)
    end
    if buffer:len() >= (str_offset + 21 + 1) then
        length = buffer(str_offset + 21, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 21 + 2 + length) then
            -- type = buffer(str_offset + 21 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(telephoneNumber, buffer(str_offset + 21 + 2, length))
            str_offset = str_offset + 21 + length + 2
        end
    end
    if buffer:len() >= (str_offset + 4) then
        subtree:add(latitudeOfVesselReported, buffer(str_offset, 4), buffer(str_offset, 4):le_int() * 1e-07)
        str_offset = str_offset + 4
    end
    if buffer:len() >= (str_offset + 4) then
        subtree:add(longitudeOfVesselReported, buffer(str_offset, 4), buffer(str_offset, 4):le_int() * 1e-07)
        str_offset = str_offset + 4
    end
    if buffer:len() >= (str_offset + 4) then
        subtree:add(timeOfPosition, buffer(str_offset, 4), buffer(str_offset, 4):le_uint() * 0.0001)
        str_offset = str_offset + 4
    end
    subtree:add(mmsiOfShipInDistress, buffer(str_offset, 5))
    str_offset = str_offset + 5
    if buffer:len() >= (str_offset + 1) then
        subtree:add(dscEosSymbol, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    do
        local _bit_len = 2
        local _bit_byte = math.floor(bitfield_offset / 8)
        local _bit_start = bitfield_offset % 8
        local _bytes = math.floor((_bit_start + _bit_len + 7) / 8)
        if buffer:len() >= (str_offset + _bit_byte + _bytes) then
            local _rng = buffer(str_offset + _bit_byte, _bytes)
            local _raw
            if _bytes <= 4 then
                _raw = _rng:le_uint()
            else
                _raw = _rng:le_uint64():tonumber()
            end
            local _val = math.floor(_raw / (2 ^ _bit_start)) % (2 ^ _bit_len)
            if false and _bit_len > 0 then
                local _sign_bit = 2 ^ (_bit_len - 1)
                if _val >= _sign_bit then
                    _val = _val - 2 ^ _bit_len
                end
            end
            subtree:add(expansionEnabled, _rng, _val)
            bitfield_offset = bitfield_offset + _bit_len
            str_offset = str_offset + math.floor(bitfield_offset / 8)
            bitfield_offset = bitfield_offset % 8
        end
    end
    str_offset = str_offset + 1  -- skip RESERVED
    if buffer:len() >= (str_offset + 6) then
        local _callingRxFrequencyChannel_raw = buffer(str_offset, 6):string()
        local _callingRxFrequencyChannel_clean = _callingRxFrequencyChannel_raw:gsub("[%s@%z\xff]+$", "")
        subtree:add(callingRxFrequencyChannel, buffer(str_offset, 6), _callingRxFrequencyChannel_clean)
        str_offset = str_offset + 6
    end
    if buffer:len() >= (str_offset + 6) then
        local _callingTxFrequencyChannel_raw = buffer(str_offset, 6):string()
        local _callingTxFrequencyChannel_clean = _callingTxFrequencyChannel_raw:gsub("[%s@%z\xff]+$", "")
        subtree:add(callingTxFrequencyChannel, buffer(str_offset, 6), _callingTxFrequencyChannel_clean)
        str_offset = str_offset + 6
    end
    if buffer:len() >= (str_offset + 4) then
        subtree:add(timeOfReceipt, buffer(str_offset, 4), buffer(str_offset, 4):le_uint() * 0.0001)
        str_offset = str_offset + 4
    end
    if buffer:len() >= (str_offset + 2) then
        subtree:add_le(dateOfReceipt, buffer(str_offset, 2))
        str_offset = str_offset + 2
    end
    if buffer:len() >= (str_offset + 2) then
        subtree:add_le(dscEquipmentAssignedMessageId, buffer(str_offset, 2))
        str_offset = str_offset + 2
    end
    local cursor_1 = str_offset
    local _iter_1 = 0
    while cursor_1 < buffer:len() and _iter_1 < 1000 do
        _iter_1 = _iter_1 + 1
        local _prev_cursor = cursor_1
        if buffer:len() >= (cursor_1 + 1) then
            subtree:add(dscExpansionFieldSymbol, buffer(cursor_1, 1))
            cursor_1 = cursor_1 + 1
        end
        if buffer:len() > cursor_1 then
            local _dscExpansionFieldData_len = buffer(cursor_1, 1):uint()
            if _dscExpansionFieldData_len >= 2 and buffer:len() >= (cursor_1 + _dscExpansionFieldData_len) then
                subtree:add(dscExpansionFieldData, buffer(cursor_1 + 2, _dscExpansionFieldData_len - 2))
                cursor_1 = cursor_1 + _dscExpansionFieldData_len
            elseif _dscExpansionFieldData_len == 0 or _dscExpansionFieldData_len == 1 then
                cursor_1 = cursor_1 + math.max(1, _dscExpansionFieldData_len)  -- empty string
            else
                cursor_1 = cursor_1 + 1  -- malformed, skip length byte
            end
        end
        if cursor_1 == _prev_cursor then break end  -- no progress
    end
end

return NMEA_2000_129808
