-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_129540 = Proto("nmea-2000-129540", "GNSS Sats in View (129540)")
local sid = ProtoField.float("nmea-2000-129540.sid", "SID")
local rangeResidualMode = ProtoField.uint8("nmea-2000-129540.rangeResidualMode", "Range Residual Mode", base.DEC, NULL, 0x3)
local satsInView = ProtoField.float("nmea-2000-129540.satsInView", "Sats in View")
local prn = ProtoField.float("nmea-2000-129540.prn", "PRN")
local elevation = ProtoField.float("nmea-2000-129540.elevation", "Elevation (rad)")
local azimuth = ProtoField.float("nmea-2000-129540.azimuth", "Azimuth (rad)")
local snr = ProtoField.float("nmea-2000-129540.snr", "SNR (dB)")
local rangeResiduals = ProtoField.float("nmea-2000-129540.rangeResiduals", "Range residuals (m)")
local status = ProtoField.uint8("nmea-2000-129540.status", "Status", base.DEC, NULL, 0xf)

NMEA_2000_129540.fields = {sid,rangeResidualMode,satsInView,prn,elevation,azimuth,snr,rangeResiduals,status}

function NMEA_2000_129540.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 129540 (GNSS Sats in View)"
    local subtree = tree:add(NMEA_2000_129540, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(sid, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    subtree:add(rangeResidualMode, buffer(str_offset + 1, 1))
    subtree:add(satsInView, buffer(str_offset + 2, 1), buffer(str_offset + 2, 1):le_uint() * 1)
    subtree:add(prn, buffer(str_offset + 3, 1), buffer(str_offset + 3, 1):le_uint() * 1)
    subtree:add(elevation, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_int() * 0.0001)
    subtree:add(azimuth, buffer(str_offset + 6, 2), buffer(str_offset + 6, 2):le_uint() * 0.0001)
    subtree:add(snr, buffer(str_offset + 8, 2), buffer(str_offset + 8, 2):le_int() * 0.01)
    subtree:add(rangeResiduals, buffer(str_offset + 10, 4), buffer(str_offset + 10, 4):le_int() * 1e-05)
    subtree:add(status, buffer(str_offset + 14, 1))
end

return NMEA_2000_129540
