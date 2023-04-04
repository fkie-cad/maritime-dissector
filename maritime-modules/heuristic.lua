-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

local parser_nmea = require "parser.nmea"
local proto_nmea0183 = require "proto.nmea0183"
local proto_iec61162450_nmea = require "proto.iec61162450nmea"
local proto_iec61162450_binary = require "proto.iec61162450binary"

local function nmea_0183_heuristic_checker(buffer, pinfo, tree)
    local length = buffer:len()
    if length < 12 then return false end
	
	local cnt = -1
	repeat
		cnt = cnt + 1
	
		local pattern = "^[!%$]%u%w-%p.-%*[%d%u][%d%u]\r\n"
		local nmea_sentence = string.find(buffer:raw(cnt), pattern)
		if nmea_sentence ~= nil then
			local matches, matches_order = parser_nmea:find_nmea_0183(buffer, pinfo)
			for _, beg_idx in pairs(matches_order) do
				match = matches[beg_idx]
				local sub_buff_beg = beg_idx - 1
				local sub_buff_len = match:len()
				local sub_buffer = buffer(sub_buff_beg, sub_buff_len):tvb()
				proto_nmea0183.dissector(sub_buffer, pinfo, tree)
			end
			return true
		end
	until(cnt >= length or cnt > 32)
	return false
end

local function iec_61162_450_nmea_heuristic_checker(buffer, pinfo, tree)
    local length = buffer:len()
    if length < 30 then return false end

    local potential_proto_token = buffer(0,5):string()
    if potential_proto_token ~= "UdPbC" then return false end

    local msg = buffer():string()
    local msg_pattern = "^(UdPbC\0)\\(%w%p.-%*[%d%u][%d%u])\\([!%$]%u%w-%p.-%*[%d%u][%d%u]\r\n)"
    local token, tags, sentence = string.match(msg, msg_pattern)
    if token == false then return false
    elseif tags == false then return false
    elseif sentence == false then return false
    else
        proto_iec61162450_nmea.dissector(buffer, pinfo, tree)
        return true
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
    iec_61162_450_nmea_heuristic_checker = iec_61162_450_nmea_heuristic_checker,
    iec_61162_450_binary_heuristic_checker = iec_61162_450_binary_heuristic_checker
}

return heuristic