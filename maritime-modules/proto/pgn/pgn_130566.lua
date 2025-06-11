-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_130566 = Proto("nmea-2000-130566", "Lighting Program (130566)")
local programId = ProtoField.float("nmea-2000-130566.programId", "Program ID")
local nameOfProgram = ProtoField.string("nmea-2000-130566.nameOfProgram", "Name of Program")
local description = ProtoField.string("nmea-2000-130566.description", "Description")

NMEA_2000_130566.fields = {programId,nameOfProgram,description}

function NMEA_2000_130566.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN 130566 (Lighting Program)"
    local subtree = tree:add(NMEA_2000_130566, buffer(), subtree_title)
    local str_offset = 0

    subtree:add(programId, buffer(str_offset + 0, 1), buffer(str_offset + 0, 1):le_uint() * 1)
    length = buffer(str_offset + 1, 1):uint() - 2
    -- type = buffer(str_offset + 1 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(nameOfProgram, buffer(str_offset + 1 + 2, length))
    str_offset = str_offset + length + 2
    length = buffer(str_offset + 0, 1):uint() - 2
    -- type = buffer(str_offset + 0 + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add(description, buffer(str_offset + 0 + 2, length))
    str_offset = str_offset + length + 2
end

return NMEA_2000_130566
