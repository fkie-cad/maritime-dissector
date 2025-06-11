-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130565 = Proto("nmea-2000-130565", "Lighting Color Sequence (130565)")
local sequenceIndex = ProtoField.float("nmea-2000-130565.sequenceIndex", "Sequence Index")
local colorCount = ProtoField.float("nmea-2000-130565.colorCount", "Color Count")
local colorIndex = ProtoField.float("nmea-2000-130565.colorIndex", "Color Index")
local redComponent = ProtoField.float("nmea-2000-130565.redComponent", "Red Component")
local greenComponent = ProtoField.float("nmea-2000-130565.greenComponent", "Green Component")
local blueComponent = ProtoField.float("nmea-2000-130565.blueComponent", "Blue Component")
local colorTemperature = ProtoField.float("nmea-2000-130565.colorTemperature", "Color Temperature")
local intensity = ProtoField.float("nmea-2000-130565.intensity", "Intensity")

NMEA_2000_130565.fields = {sequenceIndex,colorCount,colorIndex,redComponent,greenComponent,blueComponent,colorTemperature,intensity}

function NMEA_2000_130565.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130565 (Lighting Color Sequence)"
    local subtree = tree:add(NMEA_2000_130565, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sequenceIndex, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(colorCount, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(colorIndex, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(redComponent, buffer(str_offset + 3, 1), buffer(str_offset + 3, 1):le_uint() * 1)
    subtree:add(greenComponent, buffer(str_offset + 4, 1), buffer(str_offset + 4, 1):le_uint() * 1)
    subtree:add(blueComponent, buffer(str_offset + 5, 1), buffer(str_offset + 5, 1):le_uint() * 1)
    subtree:add(colorTemperature, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 1)
    subtree:add(intensity, buffer(str_offset + 8, 1), buffer(str_offset + 8, 1):le_uint() * 1)
end

return NMEA_2000_130565
