-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_126986 = Proto("nmea-2000-126986", "Alert Configuration (126986)")
local alertType = ProtoField.uint8("nmea-2000-126986.alertType", "Alert Type", base.DEC, NULL, 0xf)
local alertCategory = ProtoField.uint8("nmea-2000-126986.alertCategory", "Alert Category", base.DEC, NULL, 0xf0)
local alertSystem = ProtoField.float("nmea-2000-126986.alertSystem", "Alert System")
local alertSubSystem = ProtoField.float("nmea-2000-126986.alertSubSystem", "Alert Sub-System")
local alertId = ProtoField.float("nmea-2000-126986.alertId", "Alert ID")
local dataSourceNetworkIdName = ProtoField.float("nmea-2000-126986.dataSourceNetworkIdName", "Data Source Network ID NAME")
local dataSourceInstance = ProtoField.float("nmea-2000-126986.dataSourceInstance", "Data Source Instance")
local dataSourceIndexSource = ProtoField.float("nmea-2000-126986.dataSourceIndexSource", "Data Source Index-Source")
local alertOccurrenceNumber = ProtoField.float("nmea-2000-126986.alertOccurrenceNumber", "Alert Occurrence Number")
local reactivationPeriod = ProtoField.float("nmea-2000-126986.reactivationPeriod", "Reactivation Period")
local temporarySilencePeriod = ProtoField.float("nmea-2000-126986.temporarySilencePeriod", "Temporary Silence Period")
local escalationPeriod = ProtoField.float("nmea-2000-126986.escalationPeriod", "Escalation Period")

NMEA_2000_126986.fields = {alertType,alertCategory,alertSystem,alertSubSystem,alertId,dataSourceNetworkIdName,dataSourceInstance,dataSourceIndexSource,alertOccurrenceNumber,reactivationPeriod,temporarySilencePeriod,escalationPeriod}

function NMEA_2000_126986.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 126986 (Alert Configuration)"
    local subtree = tree:add(NMEA_2000_126986, buffer(), subtree_title)
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
    subtree:add(reactivationPeriod, buffer(str_offset + 17, 1), buffer(str_offset + 17, 1):le_uint() * 1)
    subtree:add(temporarySilencePeriod, buffer(str_offset + 18, 1), buffer(str_offset + 18, 1):le_uint() * 1)
    subtree:add(escalationPeriod, buffer(str_offset + 19, 1), buffer(str_offset + 19, 1):le_uint() * 1)
end

return NMEA_2000_126986
