-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

local known_talkers = require "maritime-modules.knownids.talkers"
local known_sentences = require "maritime-modules.knownids.sentences"
local known_pgns = require "maritime-modules.knownids.pgn"

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

function idtranslator:get_pgn_translation(pgn)
    local pgn_trans = "Unknown"
    if known_pgns[pgn] ~= nil then
        pgn_trans = known_pgns[pgn]
    end
    return pgn_trans
end

return idtranslator
