-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_126996 = Proto("nmea-2000-126996", "Product Information (126996)")
local nmea2000Version = ProtoField.float("nmea-2000-126996.nmea2000Version", "NMEA 2000 Version")
local productCode = ProtoField.uint16("nmea-2000-126996.productCode", "Product Code")
local modelId = ProtoField.string("nmea-2000-126996.modelId", "Model ID")
local softwareVersionCode = ProtoField.string("nmea-2000-126996.softwareVersionCode", "Software Version Code")
local modelVersion = ProtoField.string("nmea-2000-126996.modelVersion", "Model Version")
local modelSerialCode = ProtoField.string("nmea-2000-126996.modelSerialCode", "Model Serial Code")
local certificationLevel = ProtoField.uint8("nmea-2000-126996.certificationLevel", "Certification Level", base.DEC, NULL, 0xff)
local loadEquivalency = ProtoField.uint8("nmea-2000-126996.loadEquivalency", "Load Equivalency")

NMEA_2000_126996.fields = {nmea2000Version,productCode,modelId,softwareVersionCode,modelVersion,modelSerialCode,certificationLevel,loadEquivalency}

function NMEA_2000_126996.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 126996 (Product Information)"
    local subtree = tree:add(NMEA_2000_126996, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 2) then
        subtree:add(nmea2000Version, buffer(str_offset, 2), buffer(str_offset, 2):le_uint() * 0.001)
    end
    if buffer:len() >= (str_offset + 2 + 2) then
        subtree:add_le(productCode, buffer(str_offset + 2, 2))
    end
    if buffer:len() >= (str_offset + 4 + 32) then
        local _modelId_raw = buffer(str_offset + 4, 32):string()
        local _modelId_clean = _modelId_raw:gsub("[%s@%z\xff]+$", "")
        subtree:add(modelId, buffer(str_offset + 4, 32), _modelId_clean)
    end
    if buffer:len() >= (str_offset + 36 + 32) then
        local _softwareVersionCode_raw = buffer(str_offset + 36, 32):string()
        local _softwareVersionCode_clean = _softwareVersionCode_raw:gsub("[%s@%z\xff]+$", "")
        subtree:add(softwareVersionCode, buffer(str_offset + 36, 32), _softwareVersionCode_clean)
    end
    if buffer:len() >= (str_offset + 68 + 32) then
        local _modelVersion_raw = buffer(str_offset + 68, 32):string()
        local _modelVersion_clean = _modelVersion_raw:gsub("[%s@%z\xff]+$", "")
        subtree:add(modelVersion, buffer(str_offset + 68, 32), _modelVersion_clean)
    end
    if buffer:len() >= (str_offset + 100 + 32) then
        local _modelSerialCode_raw = buffer(str_offset + 100, 32):string()
        local _modelSerialCode_clean = _modelSerialCode_raw:gsub("[%s@%z\xff]+$", "")
        subtree:add(modelSerialCode, buffer(str_offset + 100, 32), _modelSerialCode_clean)
    end
    if buffer:len() >= (str_offset + 132 + 1) then
        subtree:add(certificationLevel, buffer(str_offset + 132, 1))
    end
    if buffer:len() >= (str_offset + 133 + 1) then
        subtree:add(loadEquivalency, buffer(str_offset + 133, 1))
    end
end

return NMEA_2000_126996
