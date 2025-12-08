-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

can_id_f = Field.new("can.id")

local parser_nmea = require "maritime-modules.parser.nmea2000"
local idtranslator = require "maritime-modules.idtranslator"
local pgn_dissector = require "maritime-modules.proto.pgn.pgn"
local fragmented_pgns = require "maritime-modules.knownids.pgn-fragmented" -- Lookup table for PGN if they are long or single frames.

-- Load PGN dissectors --

-- Dissector for NMEA 2000 sentences
NMEA_2000 = Proto("nmea-2000", "NMEA 2000")

local pgn = ProtoField.uint32("nmea-2000.pgn", "Parameter Group Number")
local src = ProtoField.uint32("nmea-2000.src", "Source")
local dst = ProtoField.uint32("nmea-2000.dst", "Destination")
local prio = ProtoField.uint32("nmea-2000.prio", "Priority")
local data = ProtoField.bytes("nmea-2000.data", "data")
local frag_data = ProtoField.bytes("nmea-2000.frag_data", "Fragmented data")
-- for long frames --
local seq = ProtoField.uint8("nmea-2000.seq", "Sequence Number", base.DEC, NULL, 0xe0)
local counter = ProtoField.uint8("nmea-2000.counter", "Frame Counter", base.DEC, NULL, 0x1f)
local len = ProtoField.uint8("nmea-2000.len", "Length (Bytes)")

NMEA_2000.fields = {pgn, src, dst, prio, data, frag_data, seq, counter, len}
NMEA_2000.experts = {}

-- Buffer for long frames
local frag_buffer = {}
local defragmented = {}

function is_fast(pgn)
    -- https://canboat.github.io/canboat/canboat.html cf PGN Ranges
    if 0x1ED00 <= pgn and pgn <= 0x1EE00 then
        return true
    elseif pgn == 0x1EF00 then
        return true
    elseif 0x1FF00 <= pgn and pgn <= 0x1FFFF then
        return true
    elseif 0x1F000 <= pgn and pgn <= 0x1FEFF then
        return fragmented_pgns[pgn] ~= nil
    else
        return false
    end
end

local function fragment_payload_length(fragment)
    local length = 0
    for _, v in pairs(fragment.frames) do
        length = length + #v
    end
    return length
end

function fragment_complete(fragment)
    if not fragment or not fragment.length then return false end
    return fragment_payload_length(fragment) >= fragment.length
end

function get_fragment_data(fragment)
    frame = 0
    data = fragment["frames"][0]

    while #data < fragment["length"] do
        frame = frame + 1
        data = data .. fragment["frames"][frame]
    end
    return data
end

function get_closest(key, time)
    closest = 0
    for k, v in pairs(defragmented[key]) do
        if math.abs(time - k) < math.abs(closest - time) then
            closest = k
        end
    end

    if closest == 0 or math.abs(closest - time) > 0.5 then -- NOTE 0.5 seconds is an assumption --
        return nil
    else
        return closest
    end
end

function NMEA_2000.dissector(buffer, pinfo, tree)
    local pgn_id = parser_nmea:extract_pgn(can_id_f())
    local pgn_trans = idtranslator:get_pgn_translation(pgn_id)

    local subtree_title = "NMEA 2000, PGN: " .. pgn_id .. " (" .. pgn_trans .. ")"
    local subtree = tree:add(NMEA_2000, buffer(), subtree_title)

    subtree:add(pgn, pgn_id)
    subtree:add(src, parser_nmea:extract_src(can_id_f()))
    subtree:add(dst, parser_nmea:extract_dst(can_id_f()))
    subtree:add(prio, parser_nmea:extract_prio(can_id_f()))

    if is_fast(pgn_id) then -- handle fragmented messages
        subtree:add(seq, buffer(0, 1))
        seq_ = bit.rshift(buffer(0, 1):uint(), 5)
        subtree:add(counter, buffer(0, 1))
        counter_ = bit.band(buffer(0, 1):uint(), 0x1f)

        if counter_ == 0 then -- only in first packet has length--
            subtree:add(len, buffer(1, 1))
            subtree:add(frag_data, buffer(2, 6))
        else
            subtree:add(frag_data, buffer(1, 7))
        end

        key = string.format("%d-%d-%d-%d", pgn_id, parser_nmea:extract_src(can_id_f()), parser_nmea:extract_dst(can_id_f()), seq_)
        if defragmented[key] ~= nil and get_closest(key, pinfo.abs_ts) ~= nil then -- Lookup fragmented packet
            pgn_dissector.dissector(ByteArray.tvb(defragmented[key][get_closest(key, pinfo.abs_ts)], "Reassembled Data"), pinfo, subtree, pgn_id)

        else -- Handle fragmentation

            if frag_buffer[key] == nil then
                frag_buffer[key] = {}
                frag_buffer[key]["frames"] = {}
                frag_buffer[key]["length"] = 99999
            end

            if counter_ == 0 then -- first packet carries total payload length and first up to 6 bytes
                local declared_len = buffer(1, 1):uint() or 0
                frag_buffer[key]["time"] = pinfo.abs_ts
                frag_buffer[key]["length"] = declared_len
                -- Clamp first chunk to remaining length (may be < 6 if malformed capture)
                local first_chunk_len = math.min(6, math.max(0, declared_len))
                frag_buffer[key]["frames"][counter_] = buffer(2, first_chunk_len):raw()

            else
                -- For subsequent frames always 7 data bytes but clamp to remaining
                local remaining = frag_buffer[key]["length"] - fragment_payload_length(frag_buffer[key])
                if remaining > 0 then
                    local take = math.min(7, remaining)
                    frag_buffer[key]["frames"][counter_] = buffer(1, take):raw()
                end
            end

            if fragment_complete(frag_buffer[key]) then
                if defragmented[key] == nil then
                    defragmented[key] = {}
                end

                defragmented[key][frag_buffer[key]["time"]] = ByteArray.new(get_fragment_data(frag_buffer[key]), true)
                -- Only call the PGN dissector if we exactly match declared length
                local re_buf = defragmented[key][frag_buffer[key]["time"]]
                if re_buf:len() == frag_buffer[key]["length"] then
                    pgn_dissector.dissector(ByteArray.tvb(re_buf, "Reassembled Data"), pinfo, subtree, pgn_id)
                else
                    subtree:add_expert_info(PI_MALFORMED, PI_ERROR, string.format("Reassembled length mismatch: have %d expected %d", re_buf:len(), frag_buffer[key]["length"]))
                end
                frag_buffer[key] = nil
            end

        end

    else

        -- Parse single-frame pgn types --
        if pgn_dissector.dissector(buffer, pinfo, subtree, pgn_id) == false then
            if pgn_id == 59904 then
                subtree:add(data, buffer(0, 3))
            else
                subtree:add(data, buffer(0, 8))
            end
        end
    end

    pinfo.cols.protocol = NMEA_2000.name
end

return NMEA_2000
