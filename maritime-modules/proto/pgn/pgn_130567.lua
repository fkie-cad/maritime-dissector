-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130567 = Proto("nmea-2000-130567", "Watermaker Input Setting and Status (130567)")
local watermakerOperatingState = ProtoField.uint8("nmea-2000-130567.watermakerOperatingState", "Watermaker Operating State", base.DEC, NULL, 0x3f)
local productionStartStop = ProtoField.uint8("nmea-2000-130567.productionStartStop", "Production Start/Stop", base.DEC, NULL, 0xc0)
local rinseStartStop = ProtoField.uint8("nmea-2000-130567.rinseStartStop", "Rinse Start/Stop", base.DEC, NULL, 0x3)
local lowPressurePumpStatus = ProtoField.uint8("nmea-2000-130567.lowPressurePumpStatus", "Low Pressure Pump Status", base.DEC, NULL, 0xc)
local highPressurePumpStatus = ProtoField.uint8("nmea-2000-130567.highPressurePumpStatus", "High Pressure Pump Status", base.DEC, NULL, 0x30)
local emergencyStop = ProtoField.uint8("nmea-2000-130567.emergencyStop", "Emergency Stop", base.DEC, NULL, 0xc0)
local productSolenoidValveStatus = ProtoField.uint8("nmea-2000-130567.productSolenoidValveStatus", "Product Solenoid Valve Status", base.DEC, NULL, 0x3)
local flushModeStatus = ProtoField.uint8("nmea-2000-130567.flushModeStatus", "Flush Mode Status", base.DEC, NULL, 0xc)
local salinityStatus = ProtoField.uint8("nmea-2000-130567.salinityStatus", "Salinity Status", base.DEC, NULL, 0x30)
local sensorStatus = ProtoField.uint8("nmea-2000-130567.sensorStatus", "Sensor Status", base.DEC, NULL, 0xc0)
local oilChangeIndicatorStatus = ProtoField.uint8("nmea-2000-130567.oilChangeIndicatorStatus", "Oil Change Indicator Status", base.DEC, NULL, 0x3)
local filterStatus = ProtoField.uint8("nmea-2000-130567.filterStatus", "Filter Status", base.DEC, NULL, 0xc)
local systemStatus = ProtoField.uint8("nmea-2000-130567.systemStatus", "System Status", base.DEC, NULL, 0x30)
local salinity = ProtoField.float("nmea-2000-130567.salinity", "Salinity (ppm)")
local productWaterTemperature = ProtoField.float("nmea-2000-130567.productWaterTemperature", "Product Water Temperature (K)")
local preFilterPressure = ProtoField.float("nmea-2000-130567.preFilterPressure", "Pre-filter Pressure (Pa)")
local postFilterPressure = ProtoField.float("nmea-2000-130567.postFilterPressure", "Post-filter Pressure (Pa)")
local feedPressure = ProtoField.float("nmea-2000-130567.feedPressure", "Feed Pressure (Pa)")
local systemHighPressure = ProtoField.float("nmea-2000-130567.systemHighPressure", "System High Pressure (Pa)")
local productWaterFlow = ProtoField.float("nmea-2000-130567.productWaterFlow", "Product Water Flow (L/h)")
local brineWaterFlow = ProtoField.float("nmea-2000-130567.brineWaterFlow", "Brine Water Flow (L/h)")
local runTime = ProtoField.float("nmea-2000-130567.runTime", "Run Time (s)")

NMEA_2000_130567.fields = {watermakerOperatingState,productionStartStop,rinseStartStop,lowPressurePumpStatus,highPressurePumpStatus,emergencyStop,productSolenoidValveStatus,flushModeStatus,salinityStatus,sensorStatus,oilChangeIndicatorStatus,filterStatus,systemStatus,salinity,productWaterTemperature,preFilterPressure,postFilterPressure,feedPressure,systemHighPressure,productWaterFlow,brineWaterFlow,runTime}

function NMEA_2000_130567.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130567 (Watermaker Input Setting and Status)"
    local subtree = tree:add(NMEA_2000_130567, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(watermakerOperatingState, buffer(str_offset + 0, 1))
    subtree:add(productionStartStop, buffer(str_offset + 0, 1))
    subtree:add(rinseStartStop, buffer(str_offset + 1, 1))
    subtree:add(lowPressurePumpStatus, buffer(str_offset + 1, 1))
    subtree:add(highPressurePumpStatus, buffer(str_offset + 1, 1))
    subtree:add(emergencyStop, buffer(str_offset + 1, 1))
    subtree:add(productSolenoidValveStatus, buffer(str_offset + 2, 1))
    subtree:add(flushModeStatus, buffer(str_offset + 2, 1))
    subtree:add(salinityStatus, buffer(str_offset + 2, 1))
    subtree:add(sensorStatus, buffer(str_offset + 2, 1))
    subtree:add(oilChangeIndicatorStatus, buffer(str_offset + 3, 1))
    subtree:add(filterStatus, buffer(str_offset + 3, 1))
    subtree:add(systemStatus, buffer(str_offset + 3, 1))
    subtree:add(salinity, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 1)
    subtree:add(productWaterTemperature, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 0.01)
    subtree:add(preFilterPressure, buffer(str_offset + 8, 2), buffer(str_offset + 8, 2):le_uint() * 100)
    subtree:add(postFilterPressure, buffer(str_offset + 10, 2), buffer(str_offset + 10, 2):le_uint() * 100)
    subtree:add(feedPressure, buffer(str_offset + 12, 2), buffer(str_offset + 12, 2):le_int() * 1000)
    subtree:add(systemHighPressure, buffer(str_offset + 14, 2), buffer(str_offset + 14, 2):le_uint() * 1000)
    subtree:add(productWaterFlow, buffer(str_offset + 16, 2), buffer(str_offset + 16, 2):le_int() * 0.1)
    subtree:add(brineWaterFlow, buffer(str_offset + 18, 2), buffer(str_offset + 18, 2):le_int() * 0.1)
    subtree:add(runTime, buffer(str_offset + 20, 4), buffer(str_offset + 20, 4):le_uint() * 1)
end

return NMEA_2000_130567
