-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- load modules
local utilities = require "maritime-modules.utilities"

local parser_nmea = {}

function parser_nmea:find_sentence(buffer)
    local msg = buffer():raw()
    local pattern = "([!%$]%u%w-%p.-%*[%d%u][%d%u])\r\n"
    local sentence = string.match(buffer(0, -1):string(), pattern)
    local sentence_beg, sentence_end = string.find(msg, sentence, 1, true)
    return utilities:offset_length(sentence_beg, sentence_end)
end

function parser_nmea:find_sentence_load(buffer)
    local msg = buffer():raw()
    local pattern = "[!%$](%u%w-%p.-)%*[%d%u][%d%u]\r\n"
    local sentence = string.match(buffer(0, -1):string(), pattern)
    local sentence_beg, sentence_end = string.find(msg, sentence, 1, true)
    return utilities:offset_length(sentence_beg, sentence_end)
end

function parser_nmea:find_talker_id(buffer)
    local msg = buffer():raw()
    local pattern = "[!%$](%u%w-)%p.-%*[%d%u][%d%u]\r\n"
    local talker_sentence_ids = string.match(buffer(0, -1):string(), pattern)
    local talkerid = talker_sentence_ids:sub(1, -4)
    local talk_id_beg, talk_id_end = string.find(msg, talkerid, 1, true)
    return utilities:offset_length(talk_id_beg, talk_id_end)
end

function parser_nmea:find_sentence_id(buffer)
    local msg = buffer():raw()
    local pattern = "[!%$](%u%w-)%p.-%*[%d%u][%d%u]\r\n"
    local talker_sentence_id = string.match(buffer(0, -1):string(), pattern)
    local sentenceid = talker_sentence_id:sub(-3, -1)
    local sent_id_beg, sent_id_end = string.find(msg, sentenceid, 1, true)
    return utilities:offset_length(sent_id_beg, sent_id_end)
end

function parser_nmea:find_data(buffer)
    local msg = buffer():raw()
    local pattern = "[!%$]%u%w-%p(.-)%*[%d%u][%d%u]\r\n"
    local data = string.match(buffer(0, -1):string(), pattern)
    local data_beg, data_end = string.find(msg, data, 1, true)
    return utilities:offset_length(data_beg, data_end)
end

function parser_nmea:find_checksum(buffer)
    local msg = buffer():raw()
    local pattern = "[!%$]%u%w-%p.-%*([%d%u][%d%u])\r\n"
    local chksm = string.match(buffer(0, -1):string(), pattern)
    local chksm_beg, chksm_end = string.find(msg, chksm, 1, true)
    return utilities:offset_length(chksm_beg, chksm_end)
end

function parser_nmea:find_nmea_0183(buffer, pinfo)
    local msg = buffer():raw()
    local pattern = "[!%$]%u%w-%p.-%*[%d%u][%d%u]\r\n"
    local matches = {}
    local matches_order = {}
    for match in string.gmatch(msg, pattern) do
        local beg_idx, end_idx = string.find(msg, match, 1, true)
        matches[beg_idx] = match
        table.insert(matches_order, beg_idx)
    end
    return matches, matches_order
end

return parser_nmea