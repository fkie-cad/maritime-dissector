-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130561 = Proto("nmea-2000-130561", "Lighting Zone (130561)")
local zoneIndex = ProtoField.uint8("nmea-2000-130561.zoneIndex", "Zone Index")
local zoneName = ProtoField.string("nmea-2000-130561.zoneName", "Zone Name")
local redComponent = ProtoField.uint8("nmea-2000-130561.redComponent", "Red Component")
local greenComponent = ProtoField.uint8("nmea-2000-130561.greenComponent", "Green Component")
local blueComponent = ProtoField.uint8("nmea-2000-130561.blueComponent", "Blue Component")
local colorTemperature = ProtoField.uint16("nmea-2000-130561.colorTemperature", "Color Temperature")
local intensity = ProtoField.uint8("nmea-2000-130561.intensity", "Intensity")
local programId = ProtoField.uint8("nmea-2000-130561.programId", "Program ID")
local programColorSequenceIndex = ProtoField.uint8("nmea-2000-130561.programColorSequenceIndex", "Program Color Sequence Index")
local programIntensity = ProtoField.uint8("nmea-2000-130561.programIntensity", "Program Intensity")
local programRate = ProtoField.uint8("nmea-2000-130561.programRate", "Program Rate")
local programColorSequence = ProtoField.uint8("nmea-2000-130561.programColorSequence", "Program Color Sequence")
local zoneEnabled = ProtoField.uint32("nmea-2000-130561.zoneEnabled", "Zone Enabled", base.DEC)

NMEA_2000_130561.fields = {zoneIndex,zoneName,redComponent,greenComponent,blueComponent,colorTemperature,intensity,programId,programColorSequenceIndex,programIntensity,programRate,programColorSequence,zoneEnabled}

function NMEA_2000_130561.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130561 (Lighting Zone)"
    local subtree = tree:add(NMEA_2000_130561, buffer(), subtree_title)
    local str_offset = 0
    local bitfield_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(zoneIndex, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        length = buffer(str_offset + 1, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 1 + 2 + length) then
            -- type = buffer(str_offset + 1 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(zoneName, buffer(str_offset + 1 + 2, length))
            str_offset = str_offset + 1 + length + 2
        end
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(redComponent, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(greenComponent, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(blueComponent, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 2) then
        subtree:add_le(colorTemperature, buffer(str_offset, 2))
        str_offset = str_offset + 2
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(intensity, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(programId, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(programColorSequenceIndex, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(programIntensity, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(programRate, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(programColorSequence, buffer(str_offset, 1))
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
            subtree:add(zoneEnabled, _rng, _val)
            bitfield_offset = bitfield_offset + _bit_len
            str_offset = str_offset + math.floor(bitfield_offset / 8)
            bitfield_offset = bitfield_offset % 8
        end
    end
    str_offset = str_offset + 1  -- skip RESERVED
end

return NMEA_2000_130561
