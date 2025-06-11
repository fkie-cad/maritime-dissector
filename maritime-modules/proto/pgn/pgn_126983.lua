-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_126983 = Proto("nmea-2000-126983", "Alert (126983)")
local alertType = ProtoField.uint8("nmea-2000-126983.alertType", "Alert Type", base.DEC, NULL, 0xf)
local alertCategory = ProtoField.uint8("nmea-2000-126983.alertCategory", "Alert Category", base.DEC, NULL, 0xf0)
local alertSystem = ProtoField.float("nmea-2000-126983.alertSystem", "Alert System")
local alertSubSystem = ProtoField.float("nmea-2000-126983.alertSubSystem", "Alert Sub-System")
local alertId = ProtoField.float("nmea-2000-126983.alertId", "Alert ID")
local dataSourceNetworkIdName = ProtoField.float("nmea-2000-126983.dataSourceNetworkIdName", "Data Source Network ID NAME")
local dataSourceInstance = ProtoField.float("nmea-2000-126983.dataSourceInstance", "Data Source Instance")
local dataSourceIndexSource = ProtoField.float("nmea-2000-126983.dataSourceIndexSource", "Data Source Index-Source")
local alertOccurrenceNumber = ProtoField.float("nmea-2000-126983.alertOccurrenceNumber", "Alert Occurrence Number")
local temporarySilenceStatus = ProtoField.uint8("nmea-2000-126983.temporarySilenceStatus", "Temporary Silence Status", base.DEC, NULL, 0x1)
local acknowledgeStatus = ProtoField.uint8("nmea-2000-126983.acknowledgeStatus", "Acknowledge Status", base.DEC, NULL, 0x2)
local escalationStatus = ProtoField.uint8("nmea-2000-126983.escalationStatus", "Escalation Status", base.DEC, NULL, 0x4)
local temporarySilenceSupport = ProtoField.uint8("nmea-2000-126983.temporarySilenceSupport", "Temporary Silence Support", base.DEC, NULL, 0x8)
local acknowledgeSupport = ProtoField.uint8("nmea-2000-126983.acknowledgeSupport", "Acknowledge Support", base.DEC, NULL, 0x10)
local escalationSupport = ProtoField.uint8("nmea-2000-126983.escalationSupport", "Escalation Support", base.DEC, NULL, 0x20)
local acknowledgeSourceNetworkIdName = ProtoField.float("nmea-2000-126983.acknowledgeSourceNetworkIdName", "Acknowledge Source Network ID NAME")
local triggerCondition = ProtoField.uint8("nmea-2000-126983.triggerCondition", "Trigger Condition", base.DEC, NULL, 0xf)
local thresholdStatus = ProtoField.uint8("nmea-2000-126983.thresholdStatus", "Threshold Status", base.DEC, NULL, 0xf0)
local alertPriority = ProtoField.float("nmea-2000-126983.alertPriority", "Alert Priority")
local alertState = ProtoField.uint8("nmea-2000-126983.alertState", "Alert State", base.DEC, NULL, 0xff)

NMEA_2000_126983.fields = {alertType,alertCategory,alertSystem,alertSubSystem,alertId,dataSourceNetworkIdName,dataSourceInstance,dataSourceIndexSource,alertOccurrenceNumber,temporarySilenceStatus,acknowledgeStatus,escalationStatus,temporarySilenceSupport,acknowledgeSupport,escalationSupport,acknowledgeSourceNetworkIdName,triggerCondition,thresholdStatus,alertPriority,alertState}

function NMEA_2000_126983.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 126983 (Alert)"
    local subtree = tree:add(NMEA_2000_126983, buffer(), subtree_title)
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
    subtree:add(temporarySilenceStatus, buffer(str_offset + 16, 1))
    subtree:add(acknowledgeStatus, buffer(str_offset + 16, 1))
    subtree:add(escalationStatus, buffer(str_offset + 16, 1))
    subtree:add(temporarySilenceSupport, buffer(str_offset + 16, 1))
    subtree:add(acknowledgeSupport, buffer(str_offset + 16, 1))
    subtree:add(escalationSupport, buffer(str_offset + 16, 1))
    subtree:add(acknowledgeSourceNetworkIdName, buffer(str_offset + 17, 8), buffer(str_offset + 17, 8):le_uint() * 1)
    subtree:add(triggerCondition, buffer(str_offset + 25, 1))
    subtree:add(thresholdStatus, buffer(str_offset + 25, 1))
    subtree:add(alertPriority, buffer(str_offset + 26, 1), buffer(str_offset + 26, 1):le_uint() * 1)
    subtree:add(alertState, buffer(str_offset + 27, 1))
end

return NMEA_2000_126983
