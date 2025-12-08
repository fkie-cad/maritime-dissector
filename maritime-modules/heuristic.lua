-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

local parser_nmea0183 = require "maritime-modules.parser.nmea0183"
local proto_nmea0183 = require "maritime-modules.proto.nmea0183"
local proto_nmea2000 = require "maritime-modules.proto.nmea2000"
local proto_iec61162450_nmea = require "maritime-modules.proto.iec61162450nmea"
local proto_iec61162450_nmea_multisentence = require "maritime-modules.proto.iec61162450nmea-multisentence"
local proto_iec61162450_binary = require "maritime-modules.proto.iec61162450binary"
local parser_nmea2000 = require "maritime-modules.parser.nmea2000"

-- CAN field accessors (available when dissecting CAN frames)
local can_id_f = Field.new("can.id")

local function nmea_0183_heuristic_checker(buffer, pinfo, tree)
    local length = buffer:len()
    if length < 12 then return false end

    local msg = buffer():raw()
    local pattern = "^[!%$]%u%w-%p.-%*[%d%u][%d%u]\r\n"
    if string.find(msg, pattern) then
        local matches, matches_order = parser_nmea0183:find_nmea_0183(buffer, pinfo)
        for _, beg_idx in pairs(matches_order) do
            match = matches[beg_idx]
            local sub_buff_beg = beg_idx - 1
            local sub_buff_len = match:len()
            local sub_buffer = buffer(sub_buff_beg, sub_buff_len):tvb()
            proto_nmea0183.dissector(sub_buffer, pinfo, tree)
        end
        return true
    else
        return false
    end
end

local function nmea_2000_heuristic_checker(buffer, pinfo, tree)
    -- Heuristic guardrails for NMEA 2000 (J1939 on CAN 2.0B):
    -- - must be a CAN frame with a 29-bit extended identifier
    -- - payload length should be 1..8 bytes (classic CAN, not CAN FD)
    -- - PGN derived from the 29-bit ID should fall within the common NMEA2000 ranges
    --     [0xE800..0xEEFF] and [0xEF00] and [0xF000..0x1FFFF] (decimal 59392..131071)

    -- require can.id from lower CAN dissector
    local can_id_field = can_id_f and can_id_f()
    local function reject(reason)
        if pinfo and pinfo.cols and pinfo.cols.info then
            pinfo.cols.info:set("NMEA2000 heuristic reject: " .. reason)
        end
        return false
    end
    if not can_id_field then
        -- Some tshark versions don’t populate can.id at heuristic time.
        proto_nmea2000.dissector(buffer, pinfo, tree)
        return true
    end

    -- ensure extended (29-bit) identifier; try direct tonumber then fallback to tostring
    local id = tonumber(can_id_field)
    if not id then
        proto_nmea2000.dissector(buffer, pinfo, tree)
        return true
    end
    if id <= 0x7FF then return reject("11-bit id") end  -- standard frame -> not NMEA2000

    -- classic CAN payload size check (NMEA2000 is CAN 2.0B, not CAN FD)
    local len = buffer:len()
    if len > 8 then return reject("len>8 (CAN FD)") end -- allow zero-length frames

    -- derive PGN and verify it sits in the typical NMEA2000 allocation
    local pgn = parser_nmea2000:extract_pgn(id)
    if not pgn then return reject("PGN extract failed") end

    -- Accept standard NMEA2000 PGN ranges (decimal): 59392 (0xE800) .. 131071 (0x1FFFF)
    if pgn < 59392 or pgn > 131071 then return reject("PGN out of range: " .. tostring(pgn)) end

    -- Passed all checks; hand over to actual dissector
    proto_nmea2000.dissector(buffer, pinfo, tree)
    return true
end

local function iec_61162_450_nmea_heuristic_checker(buffer, pinfo, tree)
    local length = buffer:len()
    if length < 30 then return false end

    local potential_proto_token = buffer(0,5):string()
    if potential_proto_token ~= "UdPbC" then return false end

    local msg = buffer(6,-1):string()
    local msg_pattern = "^\\%w%p.-%*[%d%u][%d%u]\\[!%$]%u%w-%p.-%*[%d%u][%d%u]\r\n$"
    if string.find(msg, msg_pattern) then
        local tag_sentence_pattern = "\\%w%p.-%*[%d%u][%d%u]\\[!%$]%u%w-%p.-%*[%d%u][%d%u]\r\n"
        local sentence_count = select(2, string.gsub(msg, tag_sentence_pattern, ""))
        if sentence_count > 1 then
            proto_iec61162450_nmea_multisentence.dissector(buffer, pinfo, tree)
            return true
        elseif sentence_count == 1 then
            proto_iec61162450_nmea.dissector(buffer, pinfo, tree)
            return true
        end
    else
        return false
    end
end

local function iec_61162_450_binary_heuristic_checker(buffer, pinfo, tree)
    local length = buffer:len()
    if length < 34 then return false end

    local tokens = {"RaUdP", "RpUdP", "RrUdP"}
    local is_token = false

    local potential_token = buffer(0,5):string()
    for _, t in pairs(tokens) do
        if t == potential_token then is_token = true end
    end

    if is_token == false then return false
    else
        proto_iec61162450_binary.dissector(buffer, pinfo, tree)
        return true
    end
end

local heuristic = {
    nmea_0183_heuristic_checker = nmea_0183_heuristic_checker,
    nmea_2000_heuristic_checker = nmea_2000_heuristic_checker,
    iec_61162_450_nmea_heuristic_checker = iec_61162_450_nmea_heuristic_checker,
    iec_61162_450_binary_heuristic_checker = iec_61162_450_binary_heuristic_checker
}

return heuristic
