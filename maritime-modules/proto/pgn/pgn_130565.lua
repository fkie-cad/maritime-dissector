-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130565 = Proto("nmea-2000-130565", "Lighting Color Sequence (130565)")
local sequenceIndex = ProtoField.uint8("nmea-2000-130565.sequenceIndex", "Sequence Index")
local colorCount = ProtoField.uint8("nmea-2000-130565.colorCount", "Color Count")
local colorIndex = ProtoField.uint8("nmea-2000-130565.colorIndex", "Color Index")
local redComponent = ProtoField.uint8("nmea-2000-130565.redComponent", "Red Component")
local greenComponent = ProtoField.uint8("nmea-2000-130565.greenComponent", "Green Component")
local blueComponent = ProtoField.uint8("nmea-2000-130565.blueComponent", "Blue Component")
local colorTemperature = ProtoField.uint16("nmea-2000-130565.colorTemperature", "Color Temperature")
local intensity = ProtoField.uint8("nmea-2000-130565.intensity", "Intensity")

NMEA_2000_130565.fields = {sequenceIndex,colorCount,colorIndex,redComponent,greenComponent,blueComponent,colorTemperature,intensity}

function NMEA_2000_130565.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130565 (Lighting Color Sequence)"
    local subtree = tree:add(NMEA_2000_130565, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sequenceIndex, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(colorCount, buffer(str_offset + 1, 1))
    end
    local count_1 = buffer(str_offset + 1, 1):uint()
    if count_1 > 100 then count_1 = 0 end  -- likely 'not available' sentinel
    local rep_offset_1 = str_offset + 2
    for _i_1 = 1, count_1 do
    if rep_offset_1 + 7 > buffer:len() then break end
    do
        local _start = rep_offset_1 + 0
        if buffer:len() >= (_start + 1) then
            local _rng = buffer(_start, 1)
            local _raw = _rng:uint()
            local _val = _raw
            subtree:add(colorIndex, _rng, _val)
        end
    end
    do
        local _start = rep_offset_1 + 1
        if buffer:len() >= (_start + 1) then
            local _rng = buffer(_start, 1)
            local _raw = _rng:uint()
            local _val = _raw
            subtree:add(redComponent, _rng, _val)
        end
    end
    do
        local _start = rep_offset_1 + 2
        if buffer:len() >= (_start + 1) then
            local _rng = buffer(_start, 1)
            local _raw = _rng:uint()
            local _val = _raw
            subtree:add(greenComponent, _rng, _val)
        end
    end
    do
        local _start = rep_offset_1 + 3
        if buffer:len() >= (_start + 1) then
            local _rng = buffer(_start, 1)
            local _raw = _rng:uint()
            local _val = _raw
            subtree:add(blueComponent, _rng, _val)
        end
    end
    do
        local _start = rep_offset_1 + 4
        if buffer:len() >= (_start + 2) then
            local _rng = buffer(_start, 2)
            local _raw = _rng:le_uint()
            local _val = _raw
            subtree:add(colorTemperature, _rng, _val)
        end
    end
    do
        local _start = rep_offset_1 + 6
        if buffer:len() >= (_start + 1) then
            local _rng = buffer(_start, 1)
            local _raw = _rng:uint()
            local _val = _raw
            subtree:add(intensity, _rng, _val)
        end
    end
    rep_offset_1 = rep_offset_1 + 7
    end
end

return NMEA_2000_130565
