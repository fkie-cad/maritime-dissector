-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_126985 = Proto("nmea-2000-126985", "Alert Text (126985)")
local alertType = ProtoField.uint8("nmea-2000-126985.alertType", "Alert Type", base.DEC, NULL, 0xf)
local alertCategory = ProtoField.uint8("nmea-2000-126985.alertCategory", "Alert Category", base.DEC, NULL, 0xf0)
local alertSystem = ProtoField.float("nmea-2000-126985.alertSystem", "Alert System")
local alertSubSystem = ProtoField.float("nmea-2000-126985.alertSubSystem", "Alert Sub-System")
local alertId = ProtoField.float("nmea-2000-126985.alertId", "Alert ID")
local dataSourceNetworkIdName = ProtoField.float("nmea-2000-126985.dataSourceNetworkIdName", "Data Source Network ID NAME")
local dataSourceInstance = ProtoField.float("nmea-2000-126985.dataSourceInstance", "Data Source Instance")
local dataSourceIndexSource = ProtoField.float("nmea-2000-126985.dataSourceIndexSource", "Data Source Index-Source")
local alertOccurrenceNumber = ProtoField.float("nmea-2000-126985.alertOccurrenceNumber", "Alert Occurrence Number")
local languageId = ProtoField.uint8("nmea-2000-126985.languageId", "Language ID", base.DEC, NULL, 0xff)
local alertTextDescription = ProtoField.string("nmea-2000-126985.alertTextDescription", "Alert Text Description")
local alertLocationTextDescription = ProtoField.string("nmea-2000-126985.alertLocationTextDescription", "Alert Location Text Description")

NMEA_2000_126985.fields = {alertType,alertCategory,alertSystem,alertSubSystem,alertId,dataSourceNetworkIdName,dataSourceInstance,dataSourceIndexSource,alertOccurrenceNumber,languageId,alertTextDescription,alertLocationTextDescription}

function NMEA_2000_126985.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 126985 (Alert Text)"
    local subtree = tree:add(NMEA_2000_126985, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(alertType, buffer(str_offset + 0, 1))
    subtree:add(alertCategory, buffer(str_offset + 0, 1))
    subtree:add(alertSystem, buffer(str_offset + 1, 1), buffer(str_offset + 1, 1):le_uint() * 1)
    subtree:add(alertSubSystem, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(alertId, buffer(str_offset + 3, 2), buffer(str_offset + 3, 2):le_uint() * 1)
    subtree:add(dataSourceNetworkIdName, buffer(str_offset + 5, 8), buffer(str_offset + 5, 8):le_uint() * 1)
    subtree:add(dataSourceInstance, buffer(str_offset + 13, 1), buffer(str_offset + 13, 1):le_uint() * 1)
    subtree:add(dataSourceIndexSource, buffer(str_offset + 14, 1), buffer(str_offset + 14, 1):le_uint() * 1)
    subtree:add(alertOccurrenceNumber, buffer(str_offset + 15, 1), buffer(str_offset + 15, 1):le_uint() * 1)
    subtree:add(languageId, buffer(str_offset + 16, 1))
    length = buffer(str_offset + 17, 1):uint() - 2
    -- type = buffer(str_offset + 17 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(alertTextDescription, buffer(str_offset + 17 + 2, length))
    str_offset = str_offset + length + 2
    length = buffer(str_offset + 0, 1):uint() - 2
    -- type = buffer(str_offset + 0 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(alertLocationTextDescription, buffer(str_offset + 0 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_126985
