-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_126996 = Proto("nmea-2000-126996", "Product Information (126996)")
local nmea2000Version = ProtoField.float("nmea-2000-126996.nmea2000Version", "NMEA 2000 Version")
local productCode = ProtoField.float("nmea-2000-126996.productCode", "Product Code")
local modelId = ProtoField.string("nmea-2000-126996.modelId", "Model ID")
local softwareVersionCode = ProtoField.string("nmea-2000-126996.softwareVersionCode", "Software Version Code")
local modelVersion = ProtoField.string("nmea-2000-126996.modelVersion", "Model Version")
local modelSerialCode = ProtoField.string("nmea-2000-126996.modelSerialCode", "Model Serial Code")
local certificationLevel = ProtoField.uint8("nmea-2000-126996.certificationLevel", "Certification Level", base.DEC, NULL, 0xff)
local loadEquivalency = ProtoField.float("nmea-2000-126996.loadEquivalency", "Load Equivalency")

NMEA_2000_126996.fields = {nmea2000Version,productCode,modelId,softwareVersionCode,modelVersion,modelSerialCode,certificationLevel,loadEquivalency}

function NMEA_2000_126996.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 126996 (Product Information)"
    local subtree = tree:add(NMEA_2000_126996, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(nmea2000Version, buffer(str_offset + 0, 2), buffer(str_offset + 0, 2):le_uint() * 0.001)
    subtree:add(productCode, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_uint() * 1)
    subtree:add(modelId, buffer(str_offset + 4, 32))
    subtree:add(softwareVersionCode, buffer(str_offset + 36, 32))
    subtree:add(modelVersion, buffer(str_offset + 68, 32))
    subtree:add(modelSerialCode, buffer(str_offset + 100, 32))
    subtree:add(certificationLevel, buffer(str_offset + 132, 1))
    subtree:add(loadEquivalency, buffer(str_offset + 133, 1), buffer(str_offset + 133, 1):le_uint() * 1)
end

return NMEA_2000_126996
