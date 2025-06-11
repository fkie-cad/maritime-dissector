-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_126998 = Proto("nmea-2000-126998", "Configuration Information (126998)")
local installationDescription1 = ProtoField.string("nmea-2000-126998.installationDescription1", "Installation Description #1")
local installationDescription2 = ProtoField.string("nmea-2000-126998.installationDescription2", "Installation Description #2")
local manufacturerInformation = ProtoField.string("nmea-2000-126998.manufacturerInformation", "Manufacturer Information")

NMEA_2000_126998.fields = {installationDescription1,installationDescription2,manufacturerInformation}

function NMEA_2000_126998.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 126998 (Configuration Information)"
    local subtree = tree:add(NMEA_2000_126998, buffer(), subtree_title)
    local str_offset = 0

    length = buffer(str_offset + 0, 1):uint() - 2
    -- type = buffer(str_offset + 0 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(installationDescription1, buffer(str_offset + 0 + 2, length))
    str_offset = str_offset + length + 2
    length = buffer(str_offset + 0, 1):uint() - 2
    -- type = buffer(str_offset + 0 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(installationDescription2, buffer(str_offset + 0 + 2, length))
    str_offset = str_offset + length + 2
    length = buffer(str_offset + 0, 1):uint() - 2
    -- type = buffer(str_offset + 0 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(manufacturerInformation, buffer(str_offset + 0 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_126998
