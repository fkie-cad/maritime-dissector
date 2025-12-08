-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_126986 = Proto("nmea-2000-126986", "Alert Configuration (126986)")
local alertType = ProtoField.uint8("nmea-2000-126986.alertType", "Alert Type", base.DEC, NULL, 0xf)
local alertCategory = ProtoField.uint8("nmea-2000-126986.alertCategory", "Alert Category", base.DEC, NULL, 0xf0)
local alertSystem = ProtoField.uint8("nmea-2000-126986.alertSystem", "Alert System")
local alertSubSystem = ProtoField.uint8("nmea-2000-126986.alertSubSystem", "Alert Sub-System")
local alertId = ProtoField.uint16("nmea-2000-126986.alertId", "Alert ID")
local dataSourceNetworkIdName = ProtoField.uint64("nmea-2000-126986.dataSourceNetworkIdName", "Data Source Network ID NAME")
local dataSourceInstance = ProtoField.uint8("nmea-2000-126986.dataSourceInstance", "Data Source Instance")
local dataSourceIndexSource = ProtoField.uint8("nmea-2000-126986.dataSourceIndexSource", "Data Source Index-Source")
local alertOccurrenceNumber = ProtoField.uint8("nmea-2000-126986.alertOccurrenceNumber", "Alert Occurrence Number")
local alertControl = ProtoField.uint32("nmea-2000-126986.alertControl", "Alert Control")
local userDefinedAlertAssignment = ProtoField.uint32("nmea-2000-126986.userDefinedAlertAssignment", "User Defined Alert Assignment")
local reactivationPeriod = ProtoField.uint8("nmea-2000-126986.reactivationPeriod", "Reactivation Period")
local temporarySilencePeriod = ProtoField.uint8("nmea-2000-126986.temporarySilencePeriod", "Temporary Silence Period")
local escalationPeriod = ProtoField.uint8("nmea-2000-126986.escalationPeriod", "Escalation Period")

NMEA_2000_126986.fields = {alertType,alertCategory,alertSystem,alertSubSystem,alertId,dataSourceNetworkIdName,dataSourceInstance,dataSourceIndexSource,alertOccurrenceNumber,alertControl,userDefinedAlertAssignment,reactivationPeriod,temporarySilencePeriod,escalationPeriod}

function NMEA_2000_126986.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 126986 (Alert Configuration)"
    local subtree = tree:add(NMEA_2000_126986, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(alertType, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(alertCategory, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(alertSystem, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(alertSubSystem, buffer(str_offset + 2, 1))
    end
    if buffer:len() >= (str_offset + 3 + 2) then
        subtree:add_le(alertId, buffer(str_offset + 3, 2))
    end
    if buffer:len() >= (str_offset + 5 + 8) then
        subtree:add_le(dataSourceNetworkIdName, buffer(str_offset + 5, 8))
    end
    if buffer:len() >= (str_offset + 13 + 1) then
        subtree:add(dataSourceInstance, buffer(str_offset + 13, 1))
    end
    if buffer:len() >= (str_offset + 14 + 1) then
        subtree:add(dataSourceIndexSource, buffer(str_offset + 14, 1))
    end
    if buffer:len() >= (str_offset + 15 + 1) then
        subtree:add(alertOccurrenceNumber, buffer(str_offset + 15, 1))
    end
    if buffer:len() >= (str_offset + 16 + 1) then
        local _rng = buffer(str_offset + 16, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 0)) % (2 ^ 2)
        subtree:add(alertControl, _rng, _val)
    end
    if buffer:len() >= (str_offset + 16 + 1) then
        local _rng = buffer(str_offset + 16, 1)
        local _raw = _rng:le_uint()
        local _val = math.floor(_raw / (2 ^ 2)) % (2 ^ 2)
        subtree:add(userDefinedAlertAssignment, _rng, _val)
    end
    if buffer:len() >= (str_offset + 17 + 1) then
        subtree:add(reactivationPeriod, buffer(str_offset + 17, 1))
    end
    if buffer:len() >= (str_offset + 18 + 1) then
        subtree:add(temporarySilencePeriod, buffer(str_offset + 18, 1))
    end
    if buffer:len() >= (str_offset + 19 + 1) then
        subtree:add(escalationPeriod, buffer(str_offset + 19, 1))
    end
end

return NMEA_2000_126986
