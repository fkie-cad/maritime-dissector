-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127233 = Proto("nmea-2000-127233", "Man Overboard Notification (127233)")
local sid = ProtoField.float("nmea-2000-127233.sid", "SID")
local mobEmitterId = ProtoField.float("nmea-2000-127233.mobEmitterId", "MOB Emitter ID")
local manOverboardStatus = ProtoField.uint8("nmea-2000-127233.manOverboardStatus", "Man Overboard Status", base.DEC, NULL, 0x7)
local activationTime = ProtoField.float("nmea-2000-127233.activationTime", "Activation Time (s)")
local positionSource = ProtoField.uint8("nmea-2000-127233.positionSource", "Position Source", base.DEC, NULL, 0x7)
local positionDate = ProtoField.float("nmea-2000-127233.positionDate", "Position Date (d)")
local positionTime = ProtoField.float("nmea-2000-127233.positionTime", "Position Time (s)")
local latitude = ProtoField.float("nmea-2000-127233.latitude", "Latitude (deg)")
local longitude = ProtoField.float("nmea-2000-127233.longitude", "Longitude (deg)")
local cogReference = ProtoField.uint8("nmea-2000-127233.cogReference", "COG Reference", base.DEC, NULL, 0x3)
local cog = ProtoField.float("nmea-2000-127233.cog", "COG (rad)")
local sog = ProtoField.float("nmea-2000-127233.sog", "SOG (m/s)")
local mmsiOfVesselOfOrigin = ProtoField.float("nmea-2000-127233.mmsiOfVesselOfOrigin", "MMSI of vessel of origin")
local mobEmitterBatteryLowStatus = ProtoField.uint8("nmea-2000-127233.mobEmitterBatteryLowStatus", "MOB Emitter Battery Low Status", base.DEC, NULL, 0x7)

NMEA_2000_127233.fields = {sid,mobEmitterId,manOverboardStatus,activationTime,positionSource,positionDate,positionTime,latitude,longitude,cogReference,cog,sog,mmsiOfVesselOfOrigin,mobEmitterBatteryLowStatus}

function NMEA_2000_127233.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127233 (Man Overboard Notification)"
    local subtree = tree:add(NMEA_2000_127233, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(mobEmitterId, buffer(str_offset + 1, 4), buffer(str_offset + 1, 4):le_uint() * 1)
    subtree:add(manOverboardStatus, buffer(str_offset + 5, 1))
    subtree:add(activationTime, buffer(str_offset + 6, 4), buffer(str_offset + 6, 4):le_uint() * 0.0001)
    subtree:add(positionSource, buffer(str_offset + 10, 1))
    subtree:add(positionDate, buffer(str_offset + 11, 2), buffer(str_offset + 11, 2):le_uint() * 1)
    subtree:add(positionTime, buffer(str_offset + 13, 4), buffer(str_offset + 13, 4):le_uint() * 0.0001)
    subtree:add(latitude, buffer(str_offset + 17, 4), buffer(str_offset + 17, 4):le_int() * 1e-07)
    subtree:add(longitude, buffer(str_offset + 21, 4), buffer(str_offset + 21, 4):le_int() * 1e-07)
    subtree:add(cogReference, buffer(str_offset + 25, 1))
    subtree:add(cog, buffer(str_offset + 26, 2), buffer(str_offset + 26, 2):le_uint() * 0.0001)
    subtree:add(sog, buffer(str_offset + 28, 2), buffer(str_offset + 28, 2):le_uint() * 0.01)
    subtree:add(mmsiOfVesselOfOrigin, buffer(str_offset + 30, 4), buffer(str_offset + 30, 4):le_uint() * 1)
    subtree:add(mobEmitterBatteryLowStatus, buffer(str_offset + 34, 1))
end

return NMEA_2000_127233
