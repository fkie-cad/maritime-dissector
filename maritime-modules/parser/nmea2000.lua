-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- load modules
local utilities = require "maritime-modules.utilities"

local parser_nmea2000 = {}

function parser_nmea2000:extract_pgn(id)
    -- Inspired by https://github.com/canboat/canboat/blob/master/common/common.c#L632 --
    id = tonumber(tostring(id))

    local pf = bit.band(bit.rshift(id, 16), 0xff)
    local ps = bit.band(bit.rshift(id, 8), 0xff)
    local rdp = bit.band(bit.rshift(id, 24), 0x03)

    if (pf < 240) then
        return bit.bor(bit.lshift(rdp, 16), bit.lshift(pf, 8))
    else
      return bit.bor(bit.bor(bit.lshift(rdp, 16), bit.lshift(pf, 8)), ps);
    end
end

function parser_nmea2000:extract_src(id)
    -- Inspired by https://github.com/canboat/canboat/blob/master/common/common.c#L632 --
    id = tonumber(tostring(id))
    return bit.band(id, 0xff)
end

function parser_nmea2000:extract_dst(id)
    -- Inspired by https://github.com/canboat/canboat/blob/master/common/common.c#L632 --
    id = tonumber(tostring(id))

    local pf = bit.band(bit.rshift(id, 16), 0xff)
    local ps = bit.band(bit.rshift(id, 8), 0xff)
    local rdp = bit.band(bit.rshift(id, 24), 0x03)

    if (pf < 240) then
        return ps
    else
        return 0xff
    end
end

function parser_nmea2000:extract_prio(id)
    -- Inspired by https://github.com/canboat/canboat/blob/master/common/common.c#L632 --
    id = tonumber(tostring(id))
    return bit.band(bit.rshift(id, 26), 0x7)
end

return parser_nmea2000
