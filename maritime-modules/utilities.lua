-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

local utilities = {}

function utilities:pgsub(str)
    local replaced = str:gsub("*", "%%*"):gsub("-", "%%-"):gsub(",", "%%p"):gsub("%.", "%%p"):gsub("?", "%%p"):gsub("+", "%%p")
    return replaced
end

function utilities:offset_length(beg_idx, end_idx)
    local offset = beg_idx - 1
    local length = end_idx - offset
    return offset, length
end

return utilities