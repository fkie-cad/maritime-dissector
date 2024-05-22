-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

local utilities = require "utilities"
local proto_nmea0183 = require "proto.nmea0183"
local proto_iec450 = require "proto.iec61162450nmea"
local parser_iec450 = require "parser.iec450"

-- Dissector for IEC 61162-450 packets containing multiple sentences
-- Using the IEC 61162-450 dissector for packets containing single sentences
IEC_61162_450_NMEA_MULTI = Proto("iec-61162-450-nmea-multi", "IEC 61162-450 NMEA Multi")

local type = ProtoField.string("iec-61162-450-nmea-multi.token", "Type")
local token = ProtoField.string("iec-61162-450-nmea-multi.token", "Token")
local tags = ProtoField.string("iec-61162-450-nmea-multi.tags", "Tags")
local sentence = ProtoField.string("iec-61162-450-nmea-multi.sentence", "Sentence")

local taglengthwarn_expert_info = ProtoExpert.new("iec-61162-450-nmea-multi.tag-exceeded", "IEC-61162-450 Tag length exceeded", expert.group.MALFORMED, expert.severity.ERROR)
local tagchcksm_expert_info = ProtoExpert.new("iec-61162-450-nmea-multi.tag-checksum-corrupt", "IEC-61162-450 Tag checksum corrupt", expert.group.CHECKSUM, expert.severity.ERROR)
IEC_61162_450_NMEA_MULTI.fields = {token, tags, sentence}
IEC_61162_450_NMEA_MULTI.experts = {taglengthwarn_expert_info, tagchcksm_expert_info}

function IEC_61162_450_NMEA_MULTI.dissector(buffer, pinfo, tree)
    local length = buffer:len()
    if length == 0 then return end

    local subtree = tree:add(IEC_61162_450_NMEA_MULTI, buffer(), "IEC 61162-450 NMEA Multi")
    if buffer(0,5):string() == "UdPbC" then
        -- remove token from buffer. Necessary since :string() stops at \0 bytes
        buffer_no_token = buffer(6,-1)

        subtree:add(type, "Multiple sentences")
        subtree:add(token, buffer(0,6))
    else
        buffer_no_token = buffer
    end 

    local pattern = "\\%w%p.-%*[%d%u][%d%u]\\[!%$]%u%w-%p.-%*[%d%u][%d%u]\r\n"
    local idx_counter = 1
    for sentence in string.gmatch(buffer_no_token:string(), pattern) do
        local sentence_beg, sentence_end = string.find(buffer_no_token:string(), sentence, idx_counter, true)
        if sentence_beg == nil then break end
        local sentence_offset, sentence_len = utilities:offset_length(sentence_beg, sentence_end)
        local sub_buffer = buffer_no_token(sentence_offset, sentence_len):tvb()
        proto_iec450.dissector(sub_buffer, pinfo, subtree)
        idx_counter = sentence_end + 1
    end
    pinfo.cols.protocol = IEC_61162_450_NMEA_MULTI.name
end

return IEC_61162_450_NMEA_MULTI