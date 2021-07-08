-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- Global table of packets for reassembly
IEC_61162_450_PKTS = {}

local binarystream = {}

function binarystream:get_binary_stream(buffer, pinfo)
    local msgtype = buffer(20,2):uint()
    local first_pack = nil
    local prev_pack = nil
    local next_pack = nil

    if msgtype == 1 then
        local sourceid = buffer(8,6):string()
        local blockid = buffer(22,4):uint()
        local seqnum = buffer(26, 4):uint()
        local maxseqnum = buffer(30,4):uint()
        if IEC_61162_450_PKTS[sourceid] == nil then
            IEC_61162_450_PKTS[sourceid] = {}
            IEC_61162_450_PKTS[sourceid][blockid] = {}
            IEC_61162_450_PKTS[sourceid][blockid][seqnum] = pinfo.number
        else
            if IEC_61162_450_PKTS[sourceid][blockid] == nil then
                IEC_61162_450_PKTS[sourceid][blockid] = {}
                IEC_61162_450_PKTS[sourceid][blockid][seqnum] = pinfo.number
            else
                if IEC_61162_450_PKTS[sourceid][blockid][seqnum] == nil then
                    IEC_61162_450_PKTS[sourceid][blockid][seqnum] = pinfo.number
                end
            end
        end
        if seqnum > 1 then
            first_pack = IEC_61162_450_PKTS[sourceid][blockid][1]
            prev_pack = IEC_61162_450_PKTS[sourceid][blockid][seqnum-1]
        end
        if maxseqnum > 1 then
            if seqnum ~= maxseqnum then
                next_pack = IEC_61162_450_PKTS[sourceid][blockid][seqnum+1]
            end
        end
    end
    return first_pack, prev_pack, next_pack
end

return binarystream