-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

local utilities = require "utilities"
local checksum_calculator = require "checksumcalculator"

local parser_iec450 = {}

function parser_iec450:find_tags(buffer)
    local msg = buffer():string()
    local pattern = "^UdPbC\0(\\%w%p.-%*[%d%u][%d%u]\\)[!%$]%u%w-%p.-%*[%d%u][%d%u]\r\n"
    local tags = string.match(msg, pattern)
    local tags_beg, tags_end = string.find(msg, tags, 1, true)
    return utilities:offset_length(tags_beg, tags_end)
end

function parser_iec450:split_tag_blocks_len(buffer, tags_offset, tags_len)
    local tags = buffer(tags_offset, tags_len):string()
    local tag_blocks = {}
        for str in string.gmatch(tags, "([^\\]+)") do
            tag_blocks[str] = string.len(str)
        end
        return tag_blocks
end

function parser_iec450:find_tag_blocks_exceeded(buffer, tags_offset, tags_len)
    local tag_blocks = parser_iec450:split_tag_blocks_len(buffer, tags_offset, tags_len)
    local tag_blocks_exceeded = {}
    for k, v in pairs(tag_blocks) do
        if v > 80 then
            tag_blocks_exceeded[k] = v
        end
    end
    return tag_blocks_exceeded
end

function parser_iec450:find_tag_blocks_chcksm_corrupt(buffer, tags_offset, tags_len, subtree)
    local tags = buffer(tags_offset, tags_len):string()
    local tag_blocks = {}
    for block in string.gmatch(tags, "([^\\]+)") do
        local str, chcksm = string.match(block,  "(.+)%*([%d%u][%d%u])")
        if checksum_calculator:calc_checksum(str) ~= chcksm then
            tag_blocks[str] = chcksm
        end
    end
    return tag_blocks
end

function parser_iec450:find_sentence_iec(buffer)
    local msg = buffer():string()
    local pattern = "^UdPbC\0\\%w%p.-%*[%d%u][%d%u]\\([!%$]%u%w-%p.-%*[%d%u][%d%u]\r\n)"
    local sentence = string.match(msg, pattern)
    local sentence_beg, sentence_end = string.find(msg, sentence, 1, true)
    return utilities:offset_length(sentence_beg, sentence_end)
end

return parser_iec450