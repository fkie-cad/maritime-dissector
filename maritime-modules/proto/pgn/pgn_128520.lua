-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_128520 = Proto("nmea-2000-128520", "Tracked Target Data (128520)")
local sid = ProtoField.uint8("nmea-2000-128520.sid", "SID")
local targetId = ProtoField.uint16("nmea-2000-128520.targetId", "Target ID #")
local trackStatus = ProtoField.uint8("nmea-2000-128520.trackStatus", "Track Status", base.DEC, NULL, 0x3)
local reportedTarget = ProtoField.uint8("nmea-2000-128520.reportedTarget", "Reported Target", base.DEC, NULL, 0x4)
local targetAcquisition = ProtoField.uint8("nmea-2000-128520.targetAcquisition", "Target Acquisition", base.DEC, NULL, 0x8)
local bearingReference = ProtoField.uint8("nmea-2000-128520.bearingReference", "Bearing Reference", base.DEC, NULL, 0x30)
local bearing = ProtoField.float("nmea-2000-128520.bearing", "Bearing (rad)")
local distance = ProtoField.float("nmea-2000-128520.distance", "Distance (m)")
local course = ProtoField.float("nmea-2000-128520.course", "Course (rad)")
local speed = ProtoField.float("nmea-2000-128520.speed", "Speed (m/s)")
local cpa = ProtoField.float("nmea-2000-128520.cpa", "CPA (m)")
local tcpa = ProtoField.float("nmea-2000-128520.tcpa", "TCPA (s)")
local utcOfFix = ProtoField.float("nmea-2000-128520.utcOfFix", "UTC of Fix (s)")
local name = ProtoField.string("nmea-2000-128520.name", "Name")
local referenceTarget = ProtoField.uint32("nmea-2000-128520.referenceTarget", "Reference Target", base.DEC)

NMEA_2000_128520.fields = {sid,targetId,trackStatus,reportedTarget,targetAcquisition,bearingReference,bearing,distance,course,speed,cpa,tcpa,utcOfFix,name,referenceTarget}

function NMEA_2000_128520.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 128520 (Tracked Target Data)"
    local subtree = tree:add(NMEA_2000_128520, buffer(), subtree_title)
    local str_offset = 0
    local bitfield_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(sid, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 2) then
        subtree:add_le(targetId, buffer(str_offset + 1, 2))
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(trackStatus, buffer(str_offset + 3, 1))
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(reportedTarget, buffer(str_offset + 3, 1))
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(targetAcquisition, buffer(str_offset + 3, 1))
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        subtree:add(bearingReference, buffer(str_offset + 3, 1))
    end
    if buffer:len() >= (str_offset + 4 + 2) then
        subtree:add(bearing, buffer(str_offset + 4, 2), buffer(str_offset + 4, 2):le_uint() * 0.0001)
    end
    if buffer:len() >= (str_offset + 6 + 4) then
        subtree:add(distance, buffer(str_offset + 6, 4), buffer(str_offset + 6, 4):le_int() * 0.01)
    end
    if buffer:len() >= (str_offset + 10 + 2) then
        subtree:add(course, buffer(str_offset + 10, 2), buffer(str_offset + 10, 2):le_uint() * 0.0001)
    end
    if buffer:len() >= (str_offset + 12 + 2) then
        subtree:add(speed, buffer(str_offset + 12, 2), buffer(str_offset + 12, 2):le_uint() * 0.01)
    end
    if buffer:len() >= (str_offset + 14 + 4) then
        subtree:add(cpa, buffer(str_offset + 14, 4), buffer(str_offset + 14, 4):le_int() * 0.01)
    end
    if buffer:len() >= (str_offset + 18 + 4) then
        subtree:add(tcpa, buffer(str_offset + 18, 4), buffer(str_offset + 18, 4):le_int() * 0.001)
    end
    if buffer:len() >= (str_offset + 22 + 4) then
        subtree:add(utcOfFix, buffer(str_offset + 22, 4), buffer(str_offset + 22, 4):le_uint() * 0.0001)
    end
    if buffer:len() >= (str_offset + 26 + 1) then
        length = buffer(str_offset + 26, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 26 + 2 + length) then
            -- type = buffer(str_offset + 26 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(name, buffer(str_offset + 26 + 2, length))
            str_offset = str_offset + 26 + length + 2
        end
    end
    do
        local _bit_len = 2
        local _bit_byte = math.floor(bitfield_offset / 8)
        local _bit_start = bitfield_offset % 8
        local _bytes = math.floor((_bit_start + _bit_len + 7) / 8)
        if buffer:len() >= (str_offset + _bit_byte + _bytes) then
            local _rng = buffer(str_offset + _bit_byte, _bytes)
            local _raw
            if _bytes <= 4 then
                _raw = _rng:le_uint()
            else
                _raw = _rng:le_uint64():tonumber()
            end
            local _val = math.floor(_raw / (2 ^ _bit_start)) % (2 ^ _bit_len)
            if false and _bit_len > 0 then
                local _sign_bit = 2 ^ (_bit_len - 1)
                if _val >= _sign_bit then
                    _val = _val - 2 ^ _bit_len
                end
            end
            subtree:add(referenceTarget, _rng, _val)
            bitfield_offset = bitfield_offset + _bit_len
            str_offset = str_offset + math.floor(bitfield_offset / 8)
            bitfield_offset = bitfield_offset % 8
        end
    end
    str_offset = str_offset + 1  -- skip RESERVED
end

return NMEA_2000_128520
