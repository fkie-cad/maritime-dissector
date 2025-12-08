-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_127498 = Proto("nmea-2000-127498", "Engine Parameters, Static (127498)")
local instance = ProtoField.uint8("nmea-2000-127498.instance", "Instance", base.DEC, NULL, 0xff)
local ratedEngineSpeed = ProtoField.float("nmea-2000-127498.ratedEngineSpeed", "Rated Engine Speed (rpm)")
local vin = ProtoField.string("nmea-2000-127498.vin", "VIN")
local softwareId = ProtoField.string("nmea-2000-127498.softwareId", "Software ID")

NMEA_2000_127498.fields = {instance,ratedEngineSpeed,vin,softwareId}

function NMEA_2000_127498.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 127498 (Engine Parameters, Static)"
    local subtree = tree:add(NMEA_2000_127498, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(instance, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 2) then
        subtree:add(ratedEngineSpeed, buffer(str_offset + 1, 2), buffer(str_offset + 1, 2):le_uint() * 0.25)
    end
    if buffer:len() >= (str_offset + 3 + 1) then
        length = buffer(str_offset + 3, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 3 + 2 + length) then
            -- type = buffer(str_offset + 3 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(vin, buffer(str_offset + 3 + 2, length))
            str_offset = str_offset + 3 + length + 2
        end
    end
    if buffer:len() >= (str_offset + 1) then
        length = buffer(str_offset, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 2 + length) then
            -- type = buffer(str_offset + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(softwareId, buffer(str_offset + 2, length))
            str_offset = str_offset + length + 2
        end
    end
end

return NMEA_2000_127498
