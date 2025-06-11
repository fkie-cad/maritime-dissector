-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129538 = Proto("nmea-2000-129538", "GNSS Control Status (129538)")
local svElevationMask = ProtoField.float("nmea-2000-129538.svElevationMask", "SV Elevation Mask (rad)")
local pdopMask = ProtoField.float("nmea-2000-129538.pdopMask", "PDOP Mask")
local pdopSwitch = ProtoField.float("nmea-2000-129538.pdopSwitch", "PDOP Switch")
local snrMask = ProtoField.float("nmea-2000-129538.snrMask", "SNR Mask (dB)")
local gnssModeDesired = ProtoField.uint8("nmea-2000-129538.gnssModeDesired", "GNSS Mode (desired)", base.DEC, NULL, 0x7)
local dgnssModeDesired = ProtoField.uint8("nmea-2000-129538.dgnssModeDesired", "DGNSS Mode (desired)", base.DEC, NULL, 0x38)
local positionVelocityFilter = ProtoField.uint8("nmea-2000-129538.positionVelocityFilter", "Position/Velocity Filter", base.DEC, NULL, 0xc0)
local maxCorrectionAge = ProtoField.float("nmea-2000-129538.maxCorrectionAge", "Max Correction Age (s)")
local antennaAltitudeFor2dMode = ProtoField.float("nmea-2000-129538.antennaAltitudeFor2dMode", "Antenna Altitude for 2D Mode (m)")
local useAntennaAltitudeFor2dMode = ProtoField.uint8("nmea-2000-129538.useAntennaAltitudeFor2dMode", "Use Antenna Altitude for 2D Mode", base.DEC, NULL, 0x3)

NMEA_2000_129538.fields = {svElevationMask,pdopMask,pdopSwitch,snrMask,gnssModeDesired,dgnssModeDesired,positionVelocityFilter,maxCorrectionAge,antennaAltitudeFor2dMode,useAntennaAltitudeFor2dMode}

function NMEA_2000_129538.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129538 (GNSS Control Status)"
    local subtree = tree:add(NMEA_2000_129538, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(svElevationMask, buffer(str_offset + 0, 2), buffer(str_offset + 0, 2):le_int() * 0.0001)
    subtree:add(pdopMask, buffer(str_offset + 2, 2), buffer(str_offset + 2, 2):le_int() * 0.01)
    subtree:add(pdopSwitch, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_int() * 0.01)
    subtree:add(snrMask, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_int() * 0.01)
    subtree:add(gnssModeDesired, buffer(str_offset + 8, 1))
    subtree:add(dgnssModeDesired, buffer(str_offset + 8, 1))
    subtree:add(positionVelocityFilter, buffer(str_offset + 8, 1))
    subtree:add(maxCorrectionAge, buffer(str_offset + 9, 2), buffer(str_offset + 9, 2):le_uint() * 0.01)
    subtree:add(antennaAltitudeFor2dMode, buffer(str_offset + 11, 4), buffer(str_offset + 11, 4):le_int() * 0.01)
    subtree:add(useAntennaAltitudeFor2dMode, buffer(str_offset + 15, 1))
end

return NMEA_2000_129538
