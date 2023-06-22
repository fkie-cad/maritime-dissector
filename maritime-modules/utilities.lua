-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

local utilities = {}

function utilities:offset_length(beg_idx, end_idx)
    local offset = beg_idx - 1
    local length = end_idx - offset
    return offset, length
end

return utilities