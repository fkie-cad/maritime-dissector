-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130845 = Proto("nmea-2000-130845", "Simnet: Key Value (130845)")
local manufacturerCode = ProtoField.uint32("nmea-2000-130845.manufacturerCode", "Manufacturer Code")
local industryCode = ProtoField.uint8("nmea-2000-130845.industryCode", "Industry Code", base.DEC, NULL, 0xe0)
local address = ProtoField.uint8("nmea-2000-130845.address", "Address")
local repeatIndicator = ProtoField.uint8("nmea-2000-130845.repeatIndicator", "Repeat Indicator", base.DEC, NULL, 0xff)
local displayGroup = ProtoField.uint8("nmea-2000-130845.displayGroup", "Display Group", base.DEC, NULL, 0xff)
local key = ProtoField.uint16("nmea-2000-130845.key", "Key")
local minlength = ProtoField.uint8("nmea-2000-130845.minlength", "MinLength")
local value = ProtoField.bytes("nmea-2000-130845.value", "Value")

NMEA_2000_130845.fields = {manufacturerCode,industryCode,address,repeatIndicator,displayGroup,key,minlength,value}

function NMEA_2000_130845.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130845 (Simnet: Key Value)"
    local subtree = tree:add(NMEA_2000_130845, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 2) then
        local _rng = buffer(str_offset, 2)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 11)
        subtree:add(manufacturerCode, _rng, _val)
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(industryCode, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(address, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(repeatIndicator, buffer(str_offset + 3, 1))
    end
    if buffer:len() >= (str_offset + 4 + 1) then
        subtree:add(displayGroup, buffer(str_offset + 4, 1))
    end
    subtree:add(key, buffer(str_offset + 6, 2))
    if buffer:len() >= (str_offset + 9 + 1) then
        subtree:add(minlength, buffer(str_offset + 9, 1))
    end
    if dynamic_length and dynamic_length > 0 then
        if buffer:len() >= (str_offset + 10 + dynamic_length) then
            subtree:add(value, buffer(str_offset + 10, dynamic_length))
            str_offset = str_offset + dynamic_length
        else
            local _rem = buffer:len() - (str_offset + 10)
            if _rem > 0 then
                subtree:add(value, buffer(str_offset + 10, _rem))
                str_offset = str_offset + _rem
            end
        end
    end
end

return NMEA_2000_130845
