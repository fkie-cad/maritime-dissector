-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

local known_talkers = require "knownids.talkers"
local known_sentences = require "knownids.sentences"

local idtranslator = {}

function idtranslator:get_translation(talker, sentence)
    local talker_trans = "Unknown"
    if talker:find("P") == 1 then
        talker_trans = "Vendor specific"
    end
    if known_talkers[talker] ~= nil then
        talker_trans = known_talkers[talker]
    end

    local sentence_trans = "Unknown"
    if known_sentences[sentence] ~= nil then
        sentence_trans = known_sentences[sentence]
    end
    return talker_trans, sentence_trans
end

return idtranslator