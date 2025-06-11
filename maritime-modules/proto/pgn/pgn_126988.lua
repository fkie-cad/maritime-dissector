-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_126988 = Proto("nmea-2000-126988", "Alert Value (126988)")
local alertType = ProtoField.uint8("nmea-2000-126988.alertType", "Alert Type", base.DEC, NULL, 0xf)
local alertCategory = ProtoField.uint8("nmea-2000-126988.alertCategory", "Alert Category", base.DEC, NULL, 0xf0)
local alertSystem = ProtoField.float("nmea-2000-126988.alertSystem", "Alert System")
local alertSubSystem = ProtoField.float("nmea-2000-126988.alertSubSystem", "Alert Sub-System")
local alertId = ProtoField.float("nmea-2000-126988.alertId", "Alert ID")
local dataSourceNetworkIdName = ProtoField.float("nmea-2000-126988.dataSourceNetworkIdName", "Data Source Network ID NAME")
local dataSourceInstance = ProtoField.float("nmea-2000-126988.dataSourceInstance", "Data Source Instance")
local dataSourceIndexSource = ProtoField.float("nmea-2000-126988.dataSourceIndexSource", "Data Source Index-Source")
local alertOccurrenceNumber = ProtoField.float("nmea-2000-126988.alertOccurrenceNumber", "Alert Occurrence Number")
local numberOfParameters = ProtoField.float("nmea-2000-126988.numberOfParameters", "Number of Parameters")
local valueParameterNumber = ProtoField.float("nmea-2000-126988.valueParameterNumber", "Value Parameter Number")
local valueDataFormat = ProtoField.float("nmea-2000-126988.valueDataFormat", "Value Data Format")
local valueData = ProtoField.float("nmea-2000-126988.valueData", "Value Data")

NMEA_2000_126988.fields = {alertType,alertCategory,alertSystem,alertSubSystem,alertId,dataSourceNetworkIdName,dataSourceInstance,dataSourceIndexSource,alertOccurrenceNumber,numberOfParameters,valueParameterNumber,valueDataFormat,valueData}

function NMEA_2000_126988.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 126988 (Alert Value)"
    local subtree = tree:add(NMEA_2000_126988, buffer(), subtree_title)
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
    subtree:add(numberOfParameters, buffer(str_offset + 16, 1), buffer(str_offset + 16, 1):le_uint() * 1)
    subtree:add(valueParameterNumber, buffer(str_offset + 17, 1), buffer(str_offset + 17, 1):le_uint() * 1)
    subtree:add(valueDataFormat, buffer(str_offset + 18, 1), buffer(str_offset + 18, 1):le_uint() * 1)
    subtree:add(valueData, buffer(str_offset + 19, 8), buffer(str_offset + 19, 8):le_uint() * 1)
end

return NMEA_2000_126988
