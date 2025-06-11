-- prevent wireshark loading this file as plugin
if not _G['furuno-dissector'] then return end

local proto_img = require "furuno-modules.furuno-img"

local function img_checker(buffer, pinfo, tree)
    local msgid = buffer(0, 1):uint()           -- Message type? 
    local furuno_marker = buffer(2, 6):uint64() -- Furuno specific Tag?
    -- For now, we only support message type 2 here
    if furuno_marker ~= UInt64(0x00000000, 0x00000001) or msgid ~= 0x2 or pinfo.dst_port ~= 10024 then return false end

    proto_img.dissector(buffer, pinfo, tree)
    return true
end

local heuristics = {
    img_checker = img_checker,
}

return heuristics
