-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

local parser_nmea = require "parser.nmea"
local idtranslator = require "idtranslator"
local checksum_calculator = require "checksumcalculator"

-- Dissector for NMEA 0183 sentences
NMEA_0183 = Proto("nmea-0183", "NMEA 0183")

local talkerid = ProtoField.string("nmea-0183.talkerid", "TalkerID")
local sentenceid = ProtoField.string("nmea-0183.sentenceid", "SentenceID")
local data = ProtoField.string("nmea-0183.data", "Data")
local checksum = ProtoField.string("nmea-0183.checksum", "Checksum")

local sentencelengthwarn_expert_info = ProtoExpert.new("nmea-0183.length-exceeded", "NMEA 0183 Length exceeded", expert.group.MALFORMED, expert.severity.ERROR)
local checksumcorrupt_expert_info = ProtoExpert.new("nmea-0183.checksum-corrupt", "NMEA 0183 Checksum corrupt", expert.group.CHECKSUM, expert.severity.ERROR)
NMEA_0183.fields = {talkerid, sentenceid, data, checksum}
NMEA_0183.experts = {sentencelengthwarn_expert_info, checksumcorrupt_expert_info}

function NMEA_0183.dissector(buffer, pinfo, tree)
    local sentence_offset, sentence_len = parser_nmea:find_sentence(buffer)
    local sentence_load_offset, sentence_load_len = parser_nmea:find_sentence_load(buffer)
    local talk_id_offset, talk_id_len = parser_nmea:find_talker_id(buffer)
    local sent_id_offset, sent_id_len = parser_nmea:find_sentence_id(buffer)
    local data_offset, data_len = parser_nmea:find_data(buffer)
    local chksm_offset, chksm_len = parser_nmea:find_checksum(buffer)

    local talker_id = buffer(talk_id_offset, talk_id_len):string()
    local sentence_id = buffer(sent_id_offset, sent_id_len):string()
    local talk_trans, sent_trans = idtranslator:get_translation(talker_id, sentence_id)
    local subtree_title = "NMEA 0183, Talker: " .. talker_id .. " (" .. talk_trans .. "), Sentence: " .. sentence_id .. " (" .. sent_trans .. ")"

    local subtree = tree:add(NMEA_0183, buffer(), subtree_title)

    pinfo.cols.protocol = NMEA_0183.name

    local sentence_load = buffer(sentence_load_offset, sentence_load_len):string()
    local chksm = buffer(chksm_offset, chksm_len):string()
    local chksm_calculated = checksum_calculator:calc_checksum(sentence_load)
    local chksm_result = ""
    if chksm == chksm_calculated then
        chksm_result = "0x" .. chksm .. " [valid]"
    else
        chksm_result = "0x" .. chksm .. " [CORRUPT]"
    end

    subtree:add(talkerid, buffer(talk_id_offset, talk_id_len))
    subtree:add(sentenceid, buffer(sent_id_offset, sent_id_len))
    subtree:add(data, buffer(data_offset, data_len))
    subtree:add(checksum, chksm_result)
    if sentence_len > 80 then
        local str = tostring(sentence_len + 2) .. " Byte [Max. allowed: 82 Byte]"
        subtree:add_proto_expert_info(sentencelengthwarn_expert_info, "NMEA 0183 Length exceeded: " .. str)
    end
    if chksm ~= chksm_calculated then
        subtree:add_proto_expert_info(checksumcorrupt_expert_info)
    end
end

return NMEA_0183