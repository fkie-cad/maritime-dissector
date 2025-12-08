-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130574 = Proto("nmea-2000-130574", "Supported Zone Data (130574)")
local firstZoneId = ProtoField.uint8("nmea-2000-130574.firstZoneId", "First zone ID")
local zoneCount = ProtoField.uint8("nmea-2000-130574.zoneCount", "Zone count")
local totalZoneCount = ProtoField.uint8("nmea-2000-130574.totalZoneCount", "Total zone count")
local zoneId = ProtoField.uint8("nmea-2000-130574.zoneId", "Zone ID", base.DEC, NULL, 0xff)
local name = ProtoField.string("nmea-2000-130574.name", "Name")

NMEA_2000_130574.fields = {firstZoneId,zoneCount,totalZoneCount,zoneId,name}

function NMEA_2000_130574.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130574 (Supported Zone Data)"
    local subtree = tree:add(NMEA_2000_130574, buffer(), subtree_title)
    local str_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(firstZoneId, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(zoneCount, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 1) then
        subtree:add(totalZoneCount, buffer(str_offset + 2, 1))
    end
    local count_1 = buffer(1, 1):uint()
    if count_1 > 100 then count_1 = 0 end  -- sentinel check
    local cursor_1 = str_offset
    for _i_1 = 1, count_1 do
        if cursor_1 >= buffer:len() then break end
        if buffer:len() >= (cursor_1 + 1) then
            subtree:add(zoneId, buffer(cursor_1, 1))
            cursor_1 = cursor_1 + 1
        end
        if buffer:len() > cursor_1 then
            local _name_len = buffer(cursor_1, 1):uint()
            if _name_len >= 2 and buffer:len() >= (cursor_1 + _name_len) then
                subtree:add(name, buffer(cursor_1 + 2, _name_len - 2))
                cursor_1 = cursor_1 + _name_len
            elseif _name_len == 0 or _name_len == 1 then
                cursor_1 = cursor_1 + math.max(1, _name_len)  -- empty string
            else
                cursor_1 = cursor_1 + 1  -- malformed, skip length byte
            end
        end
    end
end

return NMEA_2000_130574
