-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_126984 = Proto("nmea-2000-126984", "Alert Response (126984)")
local alertType = ProtoField.uint8("nmea-2000-126984.alertType", "Alert Type", base.DEC, NULL, 0xf)
local alertCategory = ProtoField.uint8("nmea-2000-126984.alertCategory", "Alert Category", base.DEC, NULL, 0xf0)
local alertSystem = ProtoField.float("nmea-2000-126984.alertSystem", "Alert System")
local alertSubSystem = ProtoField.float("nmea-2000-126984.alertSubSystem", "Alert Sub-System")
local alertId = ProtoField.float("nmea-2000-126984.alertId", "Alert ID")
local dataSourceNetworkIdName = ProtoField.float("nmea-2000-126984.dataSourceNetworkIdName", "Data Source Network ID NAME")
local dataSourceInstance = ProtoField.float("nmea-2000-126984.dataSourceInstance", "Data Source Instance")
local dataSourceIndexSource = ProtoField.float("nmea-2000-126984.dataSourceIndexSource", "Data Source Index-Source")
local alertOccurrenceNumber = ProtoField.float("nmea-2000-126984.alertOccurrenceNumber", "Alert Occurrence Number")
local acknowledgeSourceNetworkIdName = ProtoField.float("nmea-2000-126984.acknowledgeSourceNetworkIdName", "Acknowledge Source Network ID NAME")
local responseCommand = ProtoField.uint8("nmea-2000-126984.responseCommand", "Response Command", base.DEC, NULL, 0x3)

NMEA_2000_126984.fields = {alertType,alertCategory,alertSystem,alertSubSystem,alertId,dataSourceNetworkIdName,dataSourceInstance,dataSourceIndexSource,alertOccurrenceNumber,acknowledgeSourceNetworkIdName,responseCommand}

function NMEA_2000_126984.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 126984 (Alert Response)"
    local subtree = tree:add(NMEA_2000_126984, buffer(), subtree_title)
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
    subtree:add(acknowledgeSourceNetworkIdName, buffer(str_offset + 16, 8), buffer(str_offset + 16, 8):le_uint() * 1)
    subtree:add(responseCommand, buffer(str_offset + 24, 1))
end

return NMEA_2000_126984
