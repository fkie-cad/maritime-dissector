-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- load modules
local binarystream = require "maritime-modules.binarystream"

-- Dissector for the binary file descriptor
BINARY_FILE_DESCRIPTOR = Proto("binary-file-descriptor", "Binary File Descriptor")

local fd_length = ProtoField.uint32("binary-file-descriptor.fd_length", "File descriptor Length")
local file_length = ProtoField.uint32("binary-file-descriptor.file_length", "File Length")
local stat_of_acquisition = ProtoField.uint16("binary-file-descriptor.stat_of_acquisition", "Status of acquisition")
local device  = ProtoField.bytes("binary-file-descriptor.device", "Device")
local channel = ProtoField.bytes("binary-file-descriptor.channel", "Channel")
local type_length = ProtoField.uint8("binary-file-descriptor.type_length", "Type Length")
local data_type = ProtoField.string("binary-file-descriptor.data_type", "Data Type")
local stat_and_info = ProtoField.string("binary-file-descriptor.stat_and_info", "Status and information text")
BINARY_FILE_DESCRIPTOR.fields = {fd_length, file_length, stat_of_acquisition, device, channel, type_length, data_type, stat_and_info}

function BINARY_FILE_DESCRIPTOR.dissector(buffer, pinfo, tree)
    local fd_len = buffer(0, 4):uint()
    local type_len = buffer(12, 1):uint()
    local stat_and_info_len = fd_len - type_len - 13

    local subtree = tree:add(BINARY_FILE_DESCRIPTOR, buffer(), "IEC 61162-450 Binary file descriptor")

    subtree:add(fd_length, buffer(0, 4))
    subtree:add(file_length, buffer(4, 4))
    subtree:add(stat_of_acquisition, buffer(8, 2))
    subtree:add(device, buffer(10, 1))
    subtree:add(channel, buffer(11, 1))
    subtree:add(type_length, buffer(12, 1))
    subtree:add(data_type, buffer(13, type_len))
    subtree:add(stat_and_info, buffer(13 + type_len, stat_and_info_len))
end
IEC_61162_450_BINARY = Proto("iec-61162-450-binary", "IEC 61162-450 Binary File")

local token = ProtoField.string("iec-61162-450-binary.token", "Token")
local version = ProtoField.uint16("iec-61162-450-binary.version", "Version")
local srcid = ProtoField.string("iec-61162-450-binary.srcid", "Source ID")
local destid = ProtoField.string("iec-61162-450-binary.destid", "Destination ID")
local mtype = ProtoField.uint16("iec-61162-450-binary.mtype", "Type")
local blockid = ProtoField.uint32("iec-61162-450-binary.blockid", "Block ID")
local seqnum = ProtoField.uint32("iec-61162-450-binary.seqnum", "Sequence Number")
local maxseqnum = ProtoField.uint32("iec-61162-450-binary.maxseqnum", "Maximum Sequence Number")
local firstpacket = ProtoField.framenum("iec-61162-450-binary.firstpacket", "First binary fragment (incl. binary file descriptor)", base.None, frametype.REQUEST)
local prevpacket = ProtoField.framenum("iec-61162-450-binary.prevpacket", "Previous binary fragment", base.None, frametype.REQUEST)
local nextpacket = ProtoField.framenum("iec-61162-450-binary.nextpacket", "Next binary fragment", base.None, frametype.RESPONSE)
IEC_61162_450_BINARY.fields = {token, version, srcid, destid, mtype, blockid, seqnum, maxseqnum, firstpacket, prevpacket, nextpacket}

function IEC_61162_450_BINARY.dissector(buffer, pinfo, tree)
    local length = buffer:len()
    if length == 0 then return end

    pinfo.cols.protocol = IEC_61162_450_BINARY.name

    local subtree = tree:add(IEC_61162_450_BINARY, buffer(), "IEC 61162-450 Binary")

    subtree:add(token, buffer(0,6))
    subtree:add(version, buffer(6,2))
    subtree:add(srcid, buffer(8,6))
    subtree:add(destid, buffer(14,6))
    subtree:add(mtype, buffer(20,2))
    subtree:add(blockid, buffer(22,4))
    subtree:add(seqnum, buffer(26,4))
    subtree:add(maxseqnum, buffer(30,4))

    local first_pack, prev_pack, next_pack = binarystream:get_binary_stream(buffer, pinfo)
    if first_pack ~= nil then
        subtree:add(firstpacket, first_pack)
    end
    if prev_pack ~= nil then
        subtree:add(prevpacket, prev_pack)
    end
    if next_pack ~= nil then
        subtree:add(nextpacket, next_pack)
    end

    local mtype = buffer(20,2):uint()
    local seqnum = buffer(26, 4):uint()
    if seqnum == 1 then
        if mtype == 1 then
            local subbuffer = buffer(34):tvb()
            BINARY_FILE_DESCRIPTOR.dissector(subbuffer, pinfo, subtree)
        end
    end
end

return IEC_61162_450_BINARY