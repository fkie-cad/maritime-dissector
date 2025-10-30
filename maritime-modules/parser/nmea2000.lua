-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- load modules
local utilities = require "maritime-modules.utilities"

local parser_nmea2000 = {}

function parser_nmea2000:extract_pgn(id)
    -- Inspired by https://github.com/canboat/canboat/blob/master/common/common.c#L632 --
    id = tonumber(tostring(id))

    local pf = bit32.band(bit32.rshift(id, 16), 0xff)
    local ps = bit32.band(bit32.rshift(id, 8), 0xff)
    local rdp = bit32.band(bit32.rshift(id, 24), 0x03)

    if (pf < 240) then
        return bit32.lshift(rdp, 16) + bit32.lshift(pf, 8)
    else
      return bit32.lshift(rdp, 16) + bit32.lshift(pf, 8) + ps;
    end
end

function parser_nmea2000:extract_src(id)
    -- Inspired by https://github.com/canboat/canboat/blob/master/common/common.c#L632 --
    id = tonumber(tostring(id))
    return bit32.band(id, 0xff) -- rshift(id, 0) non è necessario
end

function parser_nmea2000:extract_dst(id)
    -- Inspired by https://github.com/canboat/canboat/blob/master/common/common.c#L632 --
    id = tonumber(tostring(id))

    local pf = bit32.band(bit32.rshift(id, 16), 0xff)
    local ps = bit32.band(bit32.rshift(id, 8), 0xff)
    local rdp = bit32.band(bit32.rshift(id, 24), 0x03)

    if (pf < 240) then
        return ps
    else
        return 0xff
    end
end

function parser_nmea2000:extract_prio(id)
    -- Inspired by https://github.com/canboat/canboat/blob/master/common/common.c#L632 --
    id = tonumber(tostring(id))
    return bit32.band(bit32.rshift(id, 26), 0x7)
end

return parser_nmea2000