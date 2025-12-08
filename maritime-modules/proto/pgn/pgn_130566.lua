-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130566 = Proto("nmea-2000-130566", "Lighting Program (130566)")
local programId = ProtoField.uint8("nmea-2000-130566.programId", "Program ID")
local nameOfProgram = ProtoField.string("nmea-2000-130566.nameOfProgram", "Name of Program")
local description = ProtoField.string("nmea-2000-130566.description", "Description")
local programCapabilities = ProtoField.uint32("nmea-2000-130566.programCapabilities", "Program Capabilities", base.DEC)

NMEA_2000_130566.fields = {programId,nameOfProgram,description,programCapabilities}

function NMEA_2000_130566.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130566 (Lighting Program)"
    local subtree = tree:add(NMEA_2000_130566, buffer(), subtree_title)
    local str_offset = 0
    local bitfield_offset = 0

    if buffer:len() >= (str_offset + 1) then
        subtree:add(programId, buffer(str_offset, 1))
    end
    if buffer:len() >= (str_offset + 1 + 1) then
        length = buffer(str_offset + 1, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 1 + 2 + length) then
            -- type = buffer(str_offset + 1 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(nameOfProgram, buffer(str_offset + 1 + 2, length))
            str_offset = str_offset + 1 + length + 2
        end
    end
    if buffer:len() >= (str_offset + 1) then
        length = buffer(str_offset, 1):uint() - 2
        if length and length >= 0 and buffer:len() >= (str_offset + 2 + length) then
            -- type = buffer(str_offset + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
            subtree:add(description, buffer(str_offset + 2, length))
            str_offset = str_offset + length + 2
        end
    end
    do
        local _bit_len = 4
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
            subtree:add(programCapabilities, _rng, _val)
            bitfield_offset = bitfield_offset + _bit_len
            str_offset = str_offset + math.floor(bitfield_offset / 8)
            bitfield_offset = bitfield_offset % 8
        end
    end
    str_offset = str_offset + 1  -- skip RESERVED
end

return NMEA_2000_130566
