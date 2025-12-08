-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130570 = Proto("nmea-2000-130570", "Library Data File (130570)")
local source = ProtoField.uint8("nmea-2000-130570.source", "Source", base.DEC, NULL, 0xff)
local number = ProtoField.uint8("nmea-2000-130570.number", "Number")
local id = ProtoField.uint32("nmea-2000-130570.id", "ID")
local type = ProtoField.uint8("nmea-2000-130570.type", "Type", base.DEC, NULL, 0xff)
local name = ProtoField.string("nmea-2000-130570.name", "Name")
local track = ProtoField.uint16("nmea-2000-130570.track", "Track")
local station = ProtoField.uint16("nmea-2000-130570.station", "Station")
local favorite = ProtoField.uint8("nmea-2000-130570.favorite", "Favorite")
local radioFrequency = ProtoField.float("nmea-2000-130570.radioFrequency", "Radio Frequency (Hz)")
local hdFrequency = ProtoField.uint8("nmea-2000-130570.hdFrequency", "HD Frequency")
local zone = ProtoField.uint8("nmea-2000-130570.zone", "Zone", base.DEC)
local inPlayQueue = ProtoField.uint32("nmea-2000-130570.inPlayQueue", "In play queue", base.DEC)
local locked = ProtoField.uint32("nmea-2000-130570.locked", "Locked", base.DEC)
local artistName = ProtoField.string("nmea-2000-130570.artistName", "Artist Name")
local albumName = ProtoField.string("nmea-2000-130570.albumName", "Album Name")
local stationName = ProtoField.string("nmea-2000-130570.stationName", "Station Name")

NMEA_2000_130570.fields = {source,number,id,type,name,track,station,favorite,radioFrequency,hdFrequency,zone,inPlayQueue,locked,artistName,albumName,stationName}

function NMEA_2000_130570.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130570 (Library Data File)"
    local subtree = tree:add(NMEA_2000_130570, buffer(), subtree_title)
    local str_offset = 0
    local bitfield_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(source, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        subtree:add(number, buffer(str_offset + 1, 1))
    end
    if buffer:len() >= (str_offset + 2 + 4) then
        subtree:add_le(id, buffer(str_offset + 2, 4))
    end
    if buffer:len() >= (str_offset + 6 + 1) then
        subtree:add(type, buffer(str_offset + 6, 1))
    end
    if buffer:len() >= (str_offset + 7 + 1) then
        length = buffer(str_offset + 7, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 7 + 2 + length) then
            -- type = buffer(str_offset + 7 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(name, buffer(str_offset + 7 + 2, length))
            str_offset = str_offset + 7 + length + 2
        end
    end
    if buffer:len() >= (str_offset + 2) then
        subtree:add_le(track, buffer(str_offset, 2))
        str_offset = str_offset + 2
    end
    if buffer:len() >= (str_offset + 2) then
        subtree:add_le(station, buffer(str_offset, 2))
        str_offset = str_offset + 2
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(favorite, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 4) then
        subtree:add(radioFrequency, buffer(str_offset, 4), buffer(str_offset, 4):le_uint() * 10)
        str_offset = str_offset + 4
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(hdFrequency, buffer(str_offset, 1))
        str_offset = str_offset + 1
    end
    if buffer:len() >= (str_offset + 1) then
        subtree:add(zone, buffer(str_offset, 1))
        str_offset = str_offset + 1
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
            subtree:add(inPlayQueue, _rng, _val)
            bitfield_offset = bitfield_offset + _bit_len
            str_offset = str_offset + math.floor(bitfield_offset / 8)
            bitfield_offset = bitfield_offset % 8
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
            subtree:add(locked, _rng, _val)
            bitfield_offset = bitfield_offset + _bit_len
            str_offset = str_offset + math.floor(bitfield_offset / 8)
            bitfield_offset = bitfield_offset % 8
        end
    end
    str_offset = str_offset + 1  -- skip RESERVED
    if buffer:len() >= (str_offset + 1) then
        length = buffer(str_offset, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 2 + length) then
            -- type = buffer(str_offset + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(artistName, buffer(str_offset + 2, length))
            str_offset = str_offset + length + 2
        end
    end
    if buffer:len() >= (str_offset + 1) then
        length = buffer(str_offset, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 2 + length) then
            -- type = buffer(str_offset + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(albumName, buffer(str_offset + 2, length))
            str_offset = str_offset + length + 2
        end
    end
    if buffer:len() >= (str_offset + 1) then
        length = buffer(str_offset, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 2 + length) then
            -- type = buffer(str_offset + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(stationName, buffer(str_offset + 2, length))
            str_offset = str_offset + length + 2
        end
    end
end

return NMEA_2000_130570
