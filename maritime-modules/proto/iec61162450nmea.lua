-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

local proto_nmea0183 = require "maritime-modules.proto.nmea0183"
local parser_iec450 = require "maritime-modules.parser.iec450"

-- Dissector for IEC 61162-450 packets containing single sentences
-- Using the NMEA 0183 dissector
IEC_61162_450_NMEA = Proto("iec-61162-450-nmea", "IEC 61162-450 NMEA")

local type = ProtoField.string("iec-61162-450-nmea.token", "Type")
local token = ProtoField.string("iec-61162-450-nmea.token", "Token")
local tags = ProtoField.string("iec-61162-450-nmea.tags", "Tags")
local sentence = ProtoField.string("iec-61162-450-nmea.sentence", "Sentence")

local taglengthwarn_expert_info = ProtoExpert.new("iec-61162-450-nmea.tag-exceeded", "IEC-61162-450 Tag length exceeded", expert.group.MALFORMED, expert.severity.ERROR)
local tagchcksm_expert_info = ProtoExpert.new("iec-61162-450-nmea.tag-checksum-corrupt", "IEC-61162-450 Tag checksum corrupt", expert.group.CHECKSUM, expert.severity.ERROR)
IEC_61162_450_NMEA.fields = {token, tags, sentence}
IEC_61162_450_NMEA.experts = {taglengthwarn_expert_info, tagchcksm_expert_info}

function IEC_61162_450_NMEA.dissector(buffer, pinfo, tree)
    local length = buffer:len()
    if length == 0 then return end

    local subtree = tree:add(IEC_61162_450_NMEA, buffer(), "IEC 61162-450 NMEA")
    local offset_shift = 0
    if buffer(0,5):string() == "UdPbC" then
        -- remove token from buffer. Necessary since :string() stops at \0 bytes
        sub_buffer = buffer(6,-1)
        offset_shift = 6

        subtree:add(type, "Single sentence")
        subtree:add(token, buffer(0,6))
    else
        sub_buffer = buffer
    end

    local tags_offset, tags_len = parser_iec450:find_tags(sub_buffer)
    local sent_offset, sent_len = parser_iec450:find_sentence_iec(sub_buffer)

    -- shift by 6 for removed token characters, if it was removed
    tags_offset = tags_offset + offset_shift
    sent_offset = sent_offset + offset_shift

    local tag_blocks_exceeded = parser_iec450:find_tag_blocks_exceeded(buffer, tags_offset, tags_len)
    local tag_blocks_chcksm_corrupt = parser_iec450:find_tag_blocks_chcksm_corrupt(buffer, tags_offset, tags_len, subtree)
    
    subtree:add(tags, buffer(tags_offset, tags_len))
    subtree:add(sentence, buffer(sent_offset, sent_len))
    for k, v in pairs(tag_blocks_exceeded) do
        local str = "Tag length exceeded: " .. k .. " (length: " .. v .." Byte; allowed: 80 Byte)"
        subtree:add_proto_expert_info(taglengthwarn_expert_info, str)
    end
    for k, v in pairs(tag_blocks_chcksm_corrupt) do
        local str = "IEC-61162-450 Tag checksum corrupt: " .. k .. "*" .. v
        subtree:add_proto_expert_info(tagchcksm_expert_info, str)
    end

    local sub_buffer = buffer(-sent_len):tvb()

    proto_nmea0183.dissector(sub_buffer, pinfo, subtree)
    pinfo.cols.protocol = IEC_61162_450_NMEA.name
end

return IEC_61162_450_NMEA