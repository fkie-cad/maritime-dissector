-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_126988 = Proto("nmea-2000-126988", "Alert Value (126988)")
local alertType = ProtoField.uint8("nmea-2000-126988.alertType", "Alert Type", base.DEC, NULL, 0xf)
local alertCategory = ProtoField.uint8("nmea-2000-126988.alertCategory", "Alert Category", base.DEC, NULL, 0xf0)
local alertSystem = ProtoField.uint8("nmea-2000-126988.alertSystem", "Alert System")
local alertSubSystem = ProtoField.uint8("nmea-2000-126988.alertSubSystem", "Alert Sub-System")
local alertId = ProtoField.uint16("nmea-2000-126988.alertId", "Alert ID")
local dataSourceNetworkIdName = ProtoField.uint64("nmea-2000-126988.dataSourceNetworkIdName", "Data Source Network ID NAME")
local dataSourceInstance = ProtoField.uint8("nmea-2000-126988.dataSourceInstance", "Data Source Instance")
local dataSourceIndexSource = ProtoField.uint8("nmea-2000-126988.dataSourceIndexSource", "Data Source Index-Source")
local alertOccurrenceNumber = ProtoField.uint8("nmea-2000-126988.alertOccurrenceNumber", "Alert Occurrence Number")
local numberOfParameters = ProtoField.uint8("nmea-2000-126988.numberOfParameters", "Number of Parameters")
local valueParameterNumber = ProtoField.uint8("nmea-2000-126988.valueParameterNumber", "Value Parameter Number")
local valueDataFormat = ProtoField.uint8("nmea-2000-126988.valueDataFormat", "Value Data Format")
local valueData = ProtoField.uint64("nmea-2000-126988.valueData", "Value Data")

NMEA_2000_126988.fields = {alertType,alertCategory,alertSystem,alertSubSystem,alertId,dataSourceNetworkIdName,dataSourceInstance,dataSourceIndexSource,alertOccurrenceNumber,numberOfParameters,valueParameterNumber,valueDataFormat,valueData}

function NMEA_2000_126988.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 126988 (Alert Value)"
    local subtree = tree:add(NMEA_2000_126988, buffer(), subtree_title)
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
        subtree:add(numberOfParameters, buffer(str_offset + 16, 1))
    end
    local count_1 = buffer(str_offset + 16, 1):uint()
    if count_1 > 100 then count_1 = 0 end  -- likely 'not available' sentinel
    local rep_offset_1 = str_offset + 17
    for _i_1 = 1, count_1 do
    if rep_offset_1 + 10 > buffer:len() then break end
    do
        local _start = rep_offset_1 + 0
        if buffer:len() >= (_start + 1) then
            local _rng = buffer(_start, 1)
            local _raw = _rng:uint()
            local _val = _raw
            subtree:add(valueParameterNumber, _rng, _val)
        end
    end
    do
        local _start = rep_offset_1 + 1
        if buffer:len() >= (_start + 1) then
            local _rng = buffer(_start, 1)
            local _raw = _rng:uint()
            local _val = _raw
            subtree:add(valueDataFormat, _rng, _val)
        end
    end
    do
        local _start = rep_offset_1 + 2
        if buffer:len() >= (_start + 8) then
            local _rng = buffer(_start, 8)
            local _raw = _rng:le_uint64():tonumber()
            local _val = _raw
            subtree:add(valueData, _rng, _val)
        end
    end
    rep_offset_1 = rep_offset_1 + 10
    end
end

return NMEA_2000_126988
