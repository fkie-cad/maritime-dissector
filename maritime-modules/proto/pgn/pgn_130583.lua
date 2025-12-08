-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130583 = Proto("nmea-2000-130583", "Available Audio EQ presets (130583)")
local firstPreset = ProtoField.uint8("nmea-2000-130583.firstPreset", "First preset")
local presetCount = ProtoField.uint8("nmea-2000-130583.presetCount", "Preset count")
local totalPresetCount = ProtoField.uint8("nmea-2000-130583.totalPresetCount", "Total preset count")
local presetType = ProtoField.uint8("nmea-2000-130583.presetType", "Preset type", base.DEC, NULL, 0xff)
local presetName = ProtoField.string("nmea-2000-130583.presetName", "Preset name")

NMEA_2000_130583.fields = {firstPreset,presetCount,totalPresetCount,presetType,presetName}

function NMEA_2000_130583.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130583 (Available Audio EQ presets)"
    local subtree = tree:add(NMEA_2000_130583, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(firstPreset, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(presetCount, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(totalPresetCount, buffer(str_offset + 2, 1))
    end
    local count_1 = buffer(1, 1):uint()
    if count_1 > 100 then count_1 = 0 end  -- sentinel check
    local cursor_1 = str_offset
    for _i_1 = 1, count_1 do
        if cursor_1 >= buffer:len() then break end
        if buffer:len() >= (cursor_1 + 1) then
            subtree:add(presetType, buffer(cursor_1, 1))
            cursor_1 = cursor_1 + 1
        end
        if buffer:len() > cursor_1 then
            local _presetName_len = buffer(cursor_1, 1):uint()
            if _presetName_len >= 2 and buffer:len() >= (cursor_1 + _presetName_len) then
                subtree:add(presetName, buffer(cursor_1 + 2, _presetName_len - 2))
                cursor_1 = cursor_1 + _presetName_len
            elseif _presetName_len == 0 or _presetName_len == 1 then
                cursor_1 = cursor_1 + math.max(1, _presetName_len)  -- empty string
            else
                cursor_1 = cursor_1 + 1  -- malformed, skip length byte
            end
        end
    end
end

return NMEA_2000_130583
