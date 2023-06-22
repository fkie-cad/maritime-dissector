import os
import pytest
import subprocess
import json
import re

from utils import duplicate_keys_to_array

FRAME_PROTOCOLS = ['eth:ethertype:ip:udp:iec-61162-450-binary:iec-61162-450-binary', 'eth:ethertype:ip:udp:iec-61162-450-binary:iec-61162-450-binary:binary-file-descriptor']
LAYERS = ['iec-61162-450-binary', 'binary-file-descriptor']


@pytest.fixture
def packets_iec_450_binary_type1():
    process = subprocess.run(['tshark', '-T', 'json', '-X', 'lua_script:../maritime-dissector.lua', '-r', 'iec-61162-450-binary-type1.pcap', '-2'], stdout=subprocess.PIPE)
    packets = json.loads(process.stdout, object_pairs_hook=duplicate_keys_to_array)
    return packets


@pytest.fixture
def packet_iec_450_binary_type1_1(packets_iec_450_binary_type1):
    return packets_iec_450_binary_type1[0]


@pytest.fixture
def packet_iec_450_binary_type1_2(packets_iec_450_binary_type1):
    return packets_iec_450_binary_type1[1]


@pytest.fixture
def packet_iec_450_binary_type2():
    process = subprocess.run(['tshark', '-T', 'json', '-X', 'lua_script:../maritime-dissector.lua', '-r', 'iec-61162-450-binary-type2.pcap'], stdout=subprocess.PIPE)
    packet = json.loads(process.stdout, object_pairs_hook=duplicate_keys_to_array)
    return packet[0]


@pytest.fixture
def packets_all(packet_iec_450_binary_type1_1, packet_iec_450_binary_type1_2, packet_iec_450_binary_type2):
    return packet_iec_450_binary_type1_1, packet_iec_450_binary_type1_2, packet_iec_450_binary_type2


@pytest.mark.dependency()
def test_frame_protocols_iec_450_binary(packets_all):
    for packet in packets_all:
        assert packet['_source']['layers']['frame']['frame.protocols'] in FRAME_PROTOCOLS


@pytest.mark.dependency(depends=['test_frame_protocols_iec_450_binary'])
def test_layers_iec_450_binary(packets_all):
    for packet in packets_all:
        assert packet['_source']['layers']
        assert any((True for layer in LAYERS if layer in packet['_source']['layers']))


@pytest.mark.dependency(depends=['test_layers_iec_450_binary'])
def test_iec_450_binary_type1(packets_iec_450_binary_type1):
    packet1, packet2 = packets_iec_450_binary_type1
    assert 'iec-61162-450-binary' in packet1['_source']['layers']
    assert 'iec-61162-450-binary' in packet2['_source']['layers']
    assert 'iec-61162-450-binary.token' in packet1['_source']['layers']['iec-61162-450-binary']
    assert 'iec-61162-450-binary.token' in packet2['_source']['layers']['iec-61162-450-binary']
    assert 'iec-61162-450-binary.version' in packet1['_source']['layers']['iec-61162-450-binary']
    assert 'iec-61162-450-binary.version' in packet2['_source']['layers']['iec-61162-450-binary']
    assert 'iec-61162-450-binary.srcid' in packet1['_source']['layers']['iec-61162-450-binary']
    assert 'iec-61162-450-binary.srcid' in packet2['_source']['layers']['iec-61162-450-binary']
    assert 'iec-61162-450-binary.destid' in packet1['_source']['layers']['iec-61162-450-binary']
    assert 'iec-61162-450-binary.destid' in packet2['_source']['layers']['iec-61162-450-binary']
    assert 'iec-61162-450-binary.mtype' in packet1['_source']['layers']['iec-61162-450-binary']
    assert 'iec-61162-450-binary.mtype' in packet2['_source']['layers']['iec-61162-450-binary']
    assert 'iec-61162-450-binary.blockid' in packet1['_source']['layers']['iec-61162-450-binary']
    assert 'iec-61162-450-binary.blockid' in packet2['_source']['layers']['iec-61162-450-binary']
    assert 'iec-61162-450-binary.seqnum' in packet1['_source']['layers']['iec-61162-450-binary']
    assert 'iec-61162-450-binary.seqnum' in packet2['_source']['layers']['iec-61162-450-binary']
    assert 'iec-61162-450-binary.maxseqnum' in packet1['_source']['layers']['iec-61162-450-binary']
    assert 'iec-61162-450-binary.maxseqnum' in packet2['_source']['layers']['iec-61162-450-binary']
    assert 'iec-61162-450-binary.nextpacket' in packet1['_source']['layers']['iec-61162-450-binary']
    assert not 'iec-61162-450-binary.nextpacket' in packet2['_source']['layers']['iec-61162-450-binary']
    assert not 'iec-61162-450-binary.firstpacket' in packet1['_source']['layers']['iec-61162-450-binary']
    assert 'iec-61162-450-binary.firstpacket' in packet2['_source']['layers']['iec-61162-450-binary']
    assert not 'iec-61162-450-binary.prevpacket' in packet1['_source']['layers']['iec-61162-450-binary']
    assert 'iec-61162-450-binary.prevpacket' in packet2['_source']['layers']['iec-61162-450-binary']
    assert 'binary-file-descriptor' in packet1['_source']['layers']['iec-61162-450-binary']
    assert not 'binary-file-descriptor' in packet2['_source']['layers']['iec-61162-450-binary']


@pytest.mark.dependency(depends=['test_iec_450_binary_type1'])
def test_iec_450_binary_type1_bfd(packet_iec_450_binary_type1_1):
    assert 'binary-file-descriptor.fd_length' in packet_iec_450_binary_type1_1['_source']['layers']['iec-61162-450-binary']['binary-file-descriptor']
    assert 'binary-file-descriptor.file_length' in packet_iec_450_binary_type1_1['_source']['layers']['iec-61162-450-binary']['binary-file-descriptor']
    assert 'binary-file-descriptor.stat_of_acquisition' in packet_iec_450_binary_type1_1['_source']['layers']['iec-61162-450-binary']['binary-file-descriptor']
    assert 'binary-file-descriptor.device' in packet_iec_450_binary_type1_1['_source']['layers']['iec-61162-450-binary']['binary-file-descriptor']
    assert 'binary-file-descriptor.channel' in packet_iec_450_binary_type1_1['_source']['layers']['iec-61162-450-binary']['binary-file-descriptor']
    assert 'binary-file-descriptor.type_length' in packet_iec_450_binary_type1_1['_source']['layers']['iec-61162-450-binary']['binary-file-descriptor']
    assert 'binary-file-descriptor.data_type' in packet_iec_450_binary_type1_1['_source']['layers']['iec-61162-450-binary']['binary-file-descriptor']
    assert 'binary-file-descriptor.stat_and_info' in packet_iec_450_binary_type1_1['_source']['layers']['iec-61162-450-binary']['binary-file-descriptor']


@pytest.mark.dependency(depends=['test_layers_iec_450_binary'])
def test_iec_450_binary_type2(packet_iec_450_binary_type2):
    assert 'iec-61162-450-binary' in packet_iec_450_binary_type2['_source']['layers']
    assert 'iec-61162-450-binary.token' in packet_iec_450_binary_type2['_source']['layers']['iec-61162-450-binary']
    assert 'iec-61162-450-binary.version' in packet_iec_450_binary_type2['_source']['layers']['iec-61162-450-binary']
    assert 'iec-61162-450-binary.srcid' in packet_iec_450_binary_type2['_source']['layers']['iec-61162-450-binary']
    assert 'iec-61162-450-binary.destid' in packet_iec_450_binary_type2['_source']['layers']['iec-61162-450-binary']
    assert 'iec-61162-450-binary.mtype' in packet_iec_450_binary_type2['_source']['layers']['iec-61162-450-binary']
    assert 'iec-61162-450-binary.blockid' in packet_iec_450_binary_type2['_source']['layers']['iec-61162-450-binary']
    assert 'iec-61162-450-binary.seqnum' in packet_iec_450_binary_type2['_source']['layers']['iec-61162-450-binary']
    assert 'iec-61162-450-binary.maxseqnum' in packet_iec_450_binary_type2['_source']['layers']['iec-61162-450-binary']
    assert not 'iec-61162-450-binary.nextpacket' in packet_iec_450_binary_type2['_source']['layers']['iec-61162-450-binary']
    assert not 'iec-61162-450-binary.firstpacket' in packet_iec_450_binary_type2['_source']['layers']['iec-61162-450-binary']
    assert not 'iec-61162-450-binary.prevpacket' in packet_iec_450_binary_type2['_source']['layers']['iec-61162-450-binary']
    assert not 'binary-file-descriptor' in packet_iec_450_binary_type2['_source']['layers']['iec-61162-450-binary']


@pytest.mark.dependency(depends=['test_iec_450_binary_type1', 'test_iec_450_binary_type1_bfd', 'test_iec_450_binary_type2'])
def test_iec_450_binary_token(packets_all):
    for packet in packets_all:
        assert 'RrUdP' == packet['_source']['layers']['iec-61162-450-binary']['iec-61162-450-binary.token']


@pytest.mark.dependency(depends=['test_iec_450_binary_type1', 'test_iec_450_binary_type1_bfd', 'test_iec_450_binary_type2'])
def test_iec_450_binary_version(packets_all):
    for packet in packets_all:
        assert '1' == packet['_source']['layers']['iec-61162-450-binary']['iec-61162-450-binary.version']


@pytest.mark.dependency(depends=['test_iec_450_binary_type1', 'test_iec_450_binary_type1_bfd', 'test_iec_450_binary_type2'])
def test_iec_450_binary_srcid(packets_all):
    for packet in packets_all:
        assert 'EI0001' == packet['_source']['layers']['iec-61162-450-binary']['iec-61162-450-binary.srcid']


@pytest.mark.dependency(depends=['test_iec_450_binary_type1', 'test_iec_450_binary_type1_bfd', 'test_iec_450_binary_type2'])
def test_iec_450_binary_destid(packets_all):
    for packet in packets_all:
        assert 'VR0001' == packet['_source']['layers']['iec-61162-450-binary']['iec-61162-450-binary.destid']


@pytest.mark.dependency(depends=['test_iec_450_binary_type1', 'test_iec_450_binary_type1_bfd', 'test_iec_450_binary_type2'])
def test_iec_450_binary_mtype(packets_all):
    packet1, packet2, packet3 = packets_all
    assert '1' == packet1['_source']['layers']['iec-61162-450-binary']['iec-61162-450-binary.mtype']
    assert '1' == packet2['_source']['layers']['iec-61162-450-binary']['iec-61162-450-binary.mtype']
    assert '2' == packet3['_source']['layers']['iec-61162-450-binary']['iec-61162-450-binary.mtype']


@pytest.mark.dependency(depends=['test_iec_450_binary_type1', 'test_iec_450_binary_type1_bfd', 'test_iec_450_binary_type2'])
def test_iec_450_binary_blockid(packets_all):
    packet1, packet2, packet3 = packets_all
    assert '513' == packet1['_source']['layers']['iec-61162-450-binary']['iec-61162-450-binary.blockid']
    assert '513' == packet2['_source']['layers']['iec-61162-450-binary']['iec-61162-450-binary.blockid']
    assert '514' == packet3['_source']['layers']['iec-61162-450-binary']['iec-61162-450-binary.blockid']


@pytest.mark.dependency(depends=['test_iec_450_binary_type1', 'test_iec_450_binary_type1_bfd', 'test_iec_450_binary_type2'])
def test_iec_450_binary_seqnum(packets_all):
    packet1, packet2, packet3 = packets_all
    assert '1' == packet1['_source']['layers']['iec-61162-450-binary']['iec-61162-450-binary.seqnum']
    assert '2' == packet2['_source']['layers']['iec-61162-450-binary']['iec-61162-450-binary.seqnum']
    assert '0' == packet3['_source']['layers']['iec-61162-450-binary']['iec-61162-450-binary.seqnum']


@pytest.mark.dependency(depends=['test_iec_450_binary_type1', 'test_iec_450_binary_type1_bfd', 'test_iec_450_binary_type2'])
def test_iec_450_binary_maxseqnum(packets_all):
    packet1, packet2, packet3 = packets_all
    assert '2' == packet1['_source']['layers']['iec-61162-450-binary']['iec-61162-450-binary.maxseqnum']
    assert '2' == packet2['_source']['layers']['iec-61162-450-binary']['iec-61162-450-binary.maxseqnum']
    assert '0' == packet3['_source']['layers']['iec-61162-450-binary']['iec-61162-450-binary.maxseqnum']


@pytest.mark.dependency(depends=['test_iec_450_binary_type1', 'test_iec_450_binary_type1_bfd', 'test_iec_450_binary_type2'])
def test_iec_450_binary_firstpacket(packet_iec_450_binary_type1_2):
    assert '1' == packet_iec_450_binary_type1_2['_source']['layers']['iec-61162-450-binary']['iec-61162-450-binary.firstpacket']


@pytest.mark.dependency(depends=['test_iec_450_binary_type1', 'test_iec_450_binary_type1_bfd', 'test_iec_450_binary_type2'])
def test_iec_450_binary_nextpacket(packet_iec_450_binary_type1_1):
    assert '2' == packet_iec_450_binary_type1_1['_source']['layers']['iec-61162-450-binary']['iec-61162-450-binary.nextpacket']


@pytest.mark.dependency(depends=['test_iec_450_binary_type1', 'test_iec_450_binary_type1_bfd', 'test_iec_450_binary_type2'])
def test_iec_450_binary_prevpacket(packet_iec_450_binary_type1_2):
    assert '1' == packet_iec_450_binary_type1_2['_source']['layers']['iec-61162-450-binary']['iec-61162-450-binary.prevpacket']


@pytest.mark.dependency(depends=['test_iec_450_binary_type1', 'test_iec_450_binary_type1_bfd'])
def test_iec_450_binary_type1_bfd_fd_length(packet_iec_450_binary_type1_1):
    assert '31' == packet_iec_450_binary_type1_1['_source']['layers']['iec-61162-450-binary']['binary-file-descriptor']['binary-file-descriptor.fd_length']


@pytest.mark.dependency(depends=['test_iec_450_binary_type1', 'test_iec_450_binary_type1_bfd'])
def test_iec_450_binary_type1_bfd_file_length(packet_iec_450_binary_type1_1):
    assert '1500' == packet_iec_450_binary_type1_1['_source']['layers']['iec-61162-450-binary']['binary-file-descriptor']['binary-file-descriptor.file_length']


@pytest.mark.dependency(depends=['test_iec_450_binary_type1', 'test_iec_450_binary_type1_bfd'])
def test_iec_450_binary_type1_bfd_stat_of_acquisition(packet_iec_450_binary_type1_1):
    assert '0' == packet_iec_450_binary_type1_1['_source']['layers']['iec-61162-450-binary']['binary-file-descriptor']['binary-file-descriptor.stat_of_acquisition']


@pytest.mark.dependency(depends=['test_iec_450_binary_type1', 'test_iec_450_binary_type1_bfd'])
def test_iec_450_binary_type1_bfd_device(packet_iec_450_binary_type1_1):
    assert '03' == packet_iec_450_binary_type1_1['_source']['layers']['iec-61162-450-binary']['binary-file-descriptor']['binary-file-descriptor.device']


@pytest.mark.dependency(depends=['test_iec_450_binary_type1', 'test_iec_450_binary_type1_bfd'])
def test_iec_450_binary_type1_bfd_channel(packet_iec_450_binary_type1_1):
    assert '01' == packet_iec_450_binary_type1_1['_source']['layers']['iec-61162-450-binary']['binary-file-descriptor']['binary-file-descriptor.channel']


@pytest.mark.dependency(depends=['test_iec_450_binary_type1', 'test_iec_450_binary_type1_bfd'])
def test_iec_450_binary_type1_bfd_type_length(packet_iec_450_binary_type1_1):
    assert '11' == packet_iec_450_binary_type1_1['_source']['layers']['iec-61162-450-binary']['binary-file-descriptor']['binary-file-descriptor.type_length']


@pytest.mark.dependency(depends=['test_iec_450_binary_type1', 'test_iec_450_binary_type1_bfd'])
def test_iec_450_binary_type1_bfd_data_type(packet_iec_450_binary_type1_1):
    assert 'text/plain' == packet_iec_450_binary_type1_1['_source']['layers']['iec-61162-450-binary']['binary-file-descriptor']['binary-file-descriptor.data_type']


@pytest.mark.dependency(depends=['test_iec_450_binary_type1', 'test_iec_450_binary_type1_bfd'])
def test_iec_450_binary_type1_bfd_stat_and_info(packet_iec_450_binary_type1_1):
    assert 'TEST\r\n' == packet_iec_450_binary_type1_1['_source']['layers']['iec-61162-450-binary']['binary-file-descriptor']['binary-file-descriptor.stat_and_info']
