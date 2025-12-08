-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127233 = Proto("nmea-2000-127233", "Man Overboard Notification (127233)")
local sid = ProtoField.uint8("nmea-2000-127233.sid", "SID")
local mobEmitterId = ProtoField.uint32("nmea-2000-127233.mobEmitterId", "MOB Emitter ID")
local manOverboardStatus = ProtoField.uint8("nmea-2000-127233.manOverboardStatus", "Man Overboard Status", base.DEC, NULL, 0x7)
local activationTime = ProtoField.float("nmea-2000-127233.activationTime", "Activation Time (s)")
local positionSource = ProtoField.uint8("nmea-2000-127233.positionSource", "Position Source", base.DEC, NULL, 0x7)
local positionDate = ProtoField.uint16("nmea-2000-127233.positionDate", "Position Date (d)")
local positionTime = ProtoField.float("nmea-2000-127233.positionTime", "Position Time (s)")
local latitude = ProtoField.float("nmea-2000-127233.latitude", "Latitude (deg)")
local longitude = ProtoField.float("nmea-2000-127233.longitude", "Longitude (deg)")
local cogReference = ProtoField.uint8("nmea-2000-127233.cogReference", "COG Reference", base.DEC, NULL, 0x3)
local cog = ProtoField.float("nmea-2000-127233.cog", "COG (rad)")
local sog = ProtoField.float("nmea-2000-127233.sog", "SOG (m/s)")
local mmsiOfVesselOfOrigin = ProtoField.uint32("nmea-2000-127233.mmsiOfVesselOfOrigin", "MMSI of vessel of origin")
local mobEmitterBatteryLowStatus = ProtoField.uint8("nmea-2000-127233.mobEmitterBatteryLowStatus", "MOB Emitter Battery Low Status", base.DEC, NULL, 0x7)

NMEA_2000_127233.fields = {sid,mobEmitterId,manOverboardStatus,activationTime,positionSource,positionDate,positionTime,latitude,longitude,cogReference,cog,sog,mmsiOfVesselOfOrigin,mobEmitterBatteryLowStatus}

function NMEA_2000_127233.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127233 (Man Overboard Notification)"
    local subtree = tree:add(NMEA_2000_127233, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sid, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 4) then
        subtree:add_le(mobEmitterId, buffer(str_offset + 1, 4))
    end
    if buffer:len() >= (str_offset + 5 + 1) then
        subtree:add(manOverboardStatus, buffer(str_offset + 5, 1))
    end
    if buffer:len() >= (str_offset + 6 + 4) then
        subtree:add(activationTime, buffer(str_offset + 6, 4), buffer(str_offset + 6, 4):le_uint() * 0.0001)
    end
    if buffer:len() >= (str_offset + 10 + 1) then
        subtree:add(positionSource, buffer(str_offset + 10, 1))
    end
    if buffer:len() >= (str_offset + 11 + 2) then
        subtree:add_le(positionDate, buffer(str_offset + 11, 2))
    end
    if buffer:len() >= (str_offset + 13 + 4) then
        subtree:add(positionTime, buffer(str_offset + 13, 4), buffer(str_offset + 13, 4):le_uint() * 0.0001)
    end
    if buffer:len() >= (str_offset + 17 + 4) then
        subtree:add(latitude, buffer(str_offset + 17, 4), buffer(str_offset + 17, 4):le_int() * 1e-07)
    end
    if buffer:len() >= (str_offset + 21 + 4) then
        subtree:add(longitude, buffer(str_offset + 21, 4), buffer(str_offset + 21, 4):le_int() * 1e-07)
    end
    if buffer:len() >= (str_offset + 25 + 1) then
        subtree:add(cogReference, buffer(str_offset + 25, 1))
    end
    if buffer:len() >= (str_offset + 26 + 2) then
        subtree:add(cog, buffer(str_offset + 26, 2), buffer(str_offset + 26, 2):le_uint() * 0.0001)
    end
    if buffer:len() >= (str_offset + 28 + 2) then
        subtree:add(sog, buffer(str_offset + 28, 2), buffer(str_offset + 28, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 30 + 4) then
        local mmsiOfVesselOfOrigin_val = buffer(str_offset + 30, 4):le_uint()
        local _ti = subtree:add(mmsiOfVesselOfOrigin, buffer(str_offset + 30, 4), mmsiOfVesselOfOrigin_val)
        _ti:append_text(string.format(" (%09d)", mmsiOfVesselOfOrigin_val))
    end
    if buffer:len() >= (str_offset + 34 + 1) then
        subtree:add(mobEmitterBatteryLowStatus, buffer(str_offset + 34, 1))
    end
end

return NMEA_2000_127233
