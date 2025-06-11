-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- load modules
local utilities = require "maritime-modules.utilities"

local parser_nmea2000 = {}

function parser_nmea2000:extract_pgn(id)
    -- Inspired by https://github.com/canboat/canboat/blob/master/common/common.c#L632 --
    id = tonumber(tostring(id))

    local pf = (id >> 16) & 0xff
    local ps = (id >> 8) & 0xff
    local rdp = (id >> 24) & 0x03

    if (pf < 240) then
        return (rdp << 16) + (pf << 8)
    else
      return (rdp << 16) + (pf << 8) + ps;
    end
end

function parser_nmea2000:extract_src(id)
    -- Inspired by https://github.com/canboat/canboat/blob/master/common/common.c#L632 --
    id = tonumber(tostring(id))
    return (id >> 0) & 0xff
end

function parser_nmea2000:extract_dst(id)
    -- Inspired by https://github.com/canboat/canboat/blob/master/common/common.c#L632 --
    id = tonumber(tostring(id))

    local pf = (id >> 16) & 0xff
    local ps = (id >> 8) & 0xff
    local rdp = (id >> 24) & 0x03

    if (pf < 240) then
        return ps
    else
        return 0xff
    end
end

function parser_nmea2000:extract_prio(id)
    -- Inspired by https://github.com/canboat/canboat/blob/master/common/common.c#L632 --
    id = tonumber(tostring(id))
    return (id >> 26) & 0x7
end

return parser_nmea2000
