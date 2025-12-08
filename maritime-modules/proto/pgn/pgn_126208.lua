-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_126208 = Proto("nmea-2000-126208", "NMEA - Write Fields reply group function (126208)")
local functionCode = ProtoField.uint8("nmea-2000-126208.functionCode", "Function Code", base.DEC, NULL, 0xff)
local pgn = ProtoField.uint24("nmea-2000-126208.pgn", "PGN")
local manufacturerCode = ProtoField.uint32("nmea-2000-126208.manufacturerCode", "Manufacturer Code")
local industryCode = ProtoField.uint8("nmea-2000-126208.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local uniqueId = ProtoField.uint8("nmea-2000-126208.uniqueId", "Unique ID")
local numberOfSelectionPairs = ProtoField.uint8("nmea-2000-126208.numberOfSelectionPairs", "Number of Selection Pairs")
local numberOfParameters = ProtoField.uint8("nmea-2000-126208.numberOfParameters", "Number of Parameters")
local selectionParameter = ProtoField.uint8("nmea-2000-126208.selectionParameter", "Selection Parameter")
local selectionValue = ProtoField.bytes("nmea-2000-126208.selectionValue", "Selection Value")
local value = ProtoField.bytes("nmea-2000-126208.value", "Value")

NMEA_2000_126208.fields = {functionCode,pgn,manufacturerCode,industryCode,uniqueId,numberOfSelectionPairs,numberOfParameters,selectionParameter,selectionValue,value}

function NMEA_2000_126208.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 126208 (NMEA - Write Fields reply group function)"
    local subtree = tree:add(NMEA_2000_126208, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(functionCode, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 3) then
        subtree:add_le(pgn, buffer(str_offset + 1, 3))
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        local _rng = buffer(str_offset + 4, 2)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 11)
        subtree:add(manufacturerCode, _rng, _val)
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        subtree:add(industryCode, buffer(str_offset + 5, 1))
    end
    if buffer:len() >= (str_offset + 6 + 1) then
        subtree:add(uniqueId, buffer(str_offset + 6, 1))
    end
    if buffer:len() >= (str_offset + 7 + 1) then
        subtree:add(numberOfSelectionPairs, buffer(str_offset + 7, 1))
    end
    if buffer:len() >= (str_offset + 8 + 1) then
        subtree:add(numberOfParameters, buffer(str_offset + 8, 1))
    end
    if buffer:len() >= (str_offset + 9 + 1) then
        subtree:add(selectionParameter, buffer(str_offset + 9, 1))
    end
    local _vlen = dynamic_length
    if _vlen and _vlen > 0 then
        subtree:add(selectionValue, buffer(str_offset, _vlen))
        str_offset = str_offset + _vlen
    else
        local _rem = buffer:len() - (str_offset)
        if _rem > 0 then
            subtree:add(selectionValue, buffer(str_offset, _rem))
            str_offset = str_offset + _rem
        end
    end
    local _vlen = dynamic_length
    if _vlen and _vlen > 0 then
        subtree:add(value, buffer(str_offset, _vlen))
        str_offset = str_offset + _vlen
    else
        local _rem = buffer:len() - (str_offset)
        if _rem > 0 then
            subtree:add(value, buffer(str_offset, _rem))
            str_offset = str_offset + _rem
        end
    end
end

return NMEA_2000_126208
