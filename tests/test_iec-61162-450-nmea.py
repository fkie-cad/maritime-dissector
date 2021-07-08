import os
import pytest
import subprocess
import json
import re

FRAME_PROTOCOLS = ['eth:ethertype:ip:udp:iec-61162-450-nmea:iec-61162-450-nmea:nmea-0183', 'eth:ethertype:ip:udp:nmea-0183:nmea-0183']
LAYERS = ['iec-61162-450-nmea', 'nmea-0183']

# TODO add special testcases: vendor specific talker (talkerID starts with P), nmea_sentence does not match pattern

@pytest.fixture
def packet_nmea_0183():
    process = subprocess.run(['tshark', '-T', 'json', '-X', 'lua_script:../maritime-dissector.lua', '-r', 'nmea-0183.pcap'], stdout=subprocess.PIPE)
    packet = json.loads(process.stdout)
    return packet[0]


@pytest.fixture
def packet_nmea_0183_wrong_checksum():
    process = subprocess.run(['tshark', '-T', 'json', '-X', 'lua_script:../maritime-dissector.lua', '-r', 'nmea-0183-wrong-chcksm.pcap'], stdout=subprocess.PIPE)
    packet = json.loads(process.stdout)
    return packet[0]


@pytest.fixture
def packet_iec_450_nmea():
    process = subprocess.run(['tshark', '-T', 'json', '-X', 'lua_script:../maritime-dissector.lua', '-r', 'iec-61162-450-nmea.pcap'], stdout=subprocess.PIPE)
    packet = json.loads(process.stdout)
    return packet[0]


@pytest.fixture
def packet_iec_450_nmea_multitag():
    process = subprocess.run(['tshark', '-T', 'json', '-X', 'lua_script:../maritime-dissector.lua', '-r', 'iec-61162-450-nmea-multitag.pcap'], stdout=subprocess.PIPE)
    packet = json.loads(process.stdout)
    return packet[0]


@pytest.fixture
def packet_iec_450_nmea_wrong_tag_checksum():
    process = subprocess.run(['tshark', '-T', 'json', '-X', 'lua_script:../maritime-dissector.lua', '-r', 'iec-61162-450-nmea-wrong-tag-chcksm.pcap'], stdout=subprocess.PIPE)
    packet = json.loads(process.stdout)
    return packet[0]


@pytest.fixture
def packet_nmea_0183_sentence_too_long():
    process = subprocess.run(['tshark', '-T', 'json', '-X', 'lua_script:../maritime-dissector.lua', '-r', 'nmea-0183-sentence-too-long.pcap'], stdout=subprocess.PIPE)
    packet = json.loads(process.stdout)
    return packet[0]


@pytest.fixture
def packet_iec_450_nmea_sentence_too_long():
    process = subprocess.run(['tshark', '-T', 'json', '-X', 'lua_script:../maritime-dissector.lua', '-r', 'iec-61162-450-nmea-sentence-too-long.pcap'], stdout=subprocess.PIPE)
    packet = json.loads(process.stdout)
    return packet[0]


@pytest.fixture
def packet_iec_450_nmea_tag_too_long():
    process = subprocess.run(['tshark', '-T', 'json', '-X', 'lua_script:../maritime-dissector.lua', '-r', 'iec-61162-450-nmea-tag-too-long.pcap'], stdout=subprocess.PIPE)
    packet = json.loads(process.stdout)
    return packet[0]


@pytest.fixture
def packets_all(packet_nmea_0183, packet_nmea_0183_wrong_checksum, packet_iec_450_nmea, packet_iec_450_nmea_multitag, packet_iec_450_nmea_wrong_tag_checksum):
    return packet_nmea_0183, packet_nmea_0183_wrong_checksum, packet_iec_450_nmea, packet_iec_450_nmea_multitag, packet_iec_450_nmea_wrong_tag_checksum


@pytest.mark.dependency()
def test_frame_protocols_iec_450_nmea(packets_all):
    for packet in packets_all:
        assert packet['_source']['layers']['frame']['frame.protocols'] in FRAME_PROTOCOLS


@pytest.mark.dependency(depends=['test_frame_protocols_iec_450_nmea'])
def test_layers_iec_450_nmea(packets_all):
    for packet in packets_all:
        assert packet['_source']['layers']
        assert any((True for layer in LAYERS if layer in packet['_source']['layers']))


@pytest.mark.dependency(depends=['test_layers_iec_450_nmea'])
def test_iec_450_nmea(packet_iec_450_nmea):
    assert 'iec-61162-450-nmea' in packet_iec_450_nmea['_source']['layers']
    assert 'iec-61162-450-nmea.token' in packet_iec_450_nmea['_source']['layers']['iec-61162-450-nmea']
    assert 'iec-61162-450-nmea.tags' in packet_iec_450_nmea['_source']['layers']['iec-61162-450-nmea']
    assert 'iec-61162-450-nmea.sentence' in packet_iec_450_nmea['_source']['layers']['iec-61162-450-nmea']
    assert 'nmea-0183' in packet_iec_450_nmea['_source']['layers']['iec-61162-450-nmea']


@pytest.mark.dependency(depends=['test_iec_450_nmea'])
def test_iec_450_nmea_token(packet_iec_450_nmea):
    assert 'UdPbC' == packet_iec_450_nmea['_source']['layers']['iec-61162-450-nmea']['iec-61162-450-nmea.token']


@pytest.mark.dependency(depends=['test_iec_450_nmea'])
def test_iec_450_nmea_tags(packet_iec_450_nmea):
    assert '\\s:HE0001*45\\' == packet_iec_450_nmea['_source']['layers']['iec-61162-450-nmea']['iec-61162-450-nmea.tags']


@pytest.mark.dependency(depends=['test_iec_450_nmea'])
def test_iec_450_nmea_sentence(packet_iec_450_nmea):
    assert '$HEROT,+000.05,A*35\r\n' == packet_iec_450_nmea['_source']['layers']['iec-61162-450-nmea']['iec-61162-450-nmea.sentence']


@pytest.mark.dependency(depends=['test_iec_450_nmea'])
def test_iec_450_nmea_0183(packet_iec_450_nmea):
    assert 'nmea-0183.talkerid' in packet_iec_450_nmea['_source']['layers']['iec-61162-450-nmea']['nmea-0183'] 
    assert 'HE' == packet_iec_450_nmea['_source']['layers']['iec-61162-450-nmea']['nmea-0183']['nmea-0183.talkerid']
    assert 'nmea-0183.sentenceid' in packet_iec_450_nmea['_source']['layers']['iec-61162-450-nmea']['nmea-0183']
    assert 'ROT' == packet_iec_450_nmea['_source']['layers']['iec-61162-450-nmea']['nmea-0183']['nmea-0183.sentenceid']
    assert 'nmea-0183.data' in packet_iec_450_nmea['_source']['layers']['iec-61162-450-nmea']['nmea-0183']
    assert '+000.05,A' == packet_iec_450_nmea['_source']['layers']['iec-61162-450-nmea']['nmea-0183']['nmea-0183.data']
    assert 'nmea-0183.checksum' in packet_iec_450_nmea['_source']['layers']['iec-61162-450-nmea']['nmea-0183']
    assert '0x35 [valid]' == packet_iec_450_nmea['_source']['layers']['iec-61162-450-nmea']['nmea-0183']['nmea-0183.checksum']


@pytest.mark.dependency(depends=['test_layers_iec_450_nmea'])
def test_nmea_0183(packet_nmea_0183):
    assert 'nmea-0183' in packet_nmea_0183['_source']['layers']
    assert 'nmea-0183.talkerid' in packet_nmea_0183['_source']['layers']['nmea-0183']
    assert 'nmea-0183.sentenceid' in packet_nmea_0183['_source']['layers']['nmea-0183']
    assert 'nmea-0183.data' in packet_nmea_0183['_source']['layers']['nmea-0183']
    assert 'nmea-0183.checksum' in packet_nmea_0183['_source']['layers']['nmea-0183']


@pytest.mark.dependency(depends=['test_nmea_0183'])
def test_nmea_0183_talkerid(packet_nmea_0183):
    assert 'HE' == packet_nmea_0183['_source']['layers']['nmea-0183']['nmea-0183.talkerid']


@pytest.mark.dependency(depends=['test_nmea_0183'])
def test_nmea_0183_sentenceid(packet_nmea_0183):
    assert 'ROT' == packet_nmea_0183['_source']['layers']['nmea-0183']['nmea-0183.sentenceid']


@pytest.mark.dependency(depends=['test_nmea_0183'])
def test_nmea_0183_data(packet_nmea_0183):
    assert '+000.05,A' == packet_nmea_0183['_source']['layers']['nmea-0183']['nmea-0183.data']


@pytest.mark.dependency(depends=['test_nmea_0183'])
def test_nmea_0183_checksum(packet_nmea_0183):
    assert '0x35 [valid]' == packet_nmea_0183['_source']['layers']['nmea-0183']['nmea-0183.checksum']


@pytest.mark.dependency(depends=['test_layers_iec_450_nmea'])
def test_iec_450_nmea_multitag(packet_iec_450_nmea_multitag):
    assert 'iec-61162-450-nmea' in packet_iec_450_nmea_multitag['_source']['layers']
    assert 'iec-61162-450-nmea.token' in packet_iec_450_nmea_multitag['_source']['layers']['iec-61162-450-nmea']
    assert 'iec-61162-450-nmea.tags' in packet_iec_450_nmea_multitag['_source']['layers']['iec-61162-450-nmea']
    assert 'iec-61162-450-nmea.sentence' in packet_iec_450_nmea_multitag['_source']['layers']['iec-61162-450-nmea']
    assert 'nmea-0183' in packet_iec_450_nmea_multitag['_source']['layers']['iec-61162-450-nmea']


@pytest.mark.dependency(depends=['test_iec_450_nmea_multitag'])
def test_iec_450_nmea_multitag_token(packet_iec_450_nmea_multitag):
    assert 'UdPbC' == packet_iec_450_nmea_multitag['_source']['layers']['iec-61162-450-nmea']['iec-61162-450-nmea.token']


@pytest.mark.dependency(depends=['test_iec_450_nmea_multitag'])
def test_iec_450_nmea_multitag_tags(packet_iec_450_nmea_multitag):
    assert '\\d:HE0002*51\\\\s:HE0001*45\\' == packet_iec_450_nmea_multitag['_source']['layers']['iec-61162-450-nmea']['iec-61162-450-nmea.tags']


@pytest.mark.dependency(depends=['test_iec_450_nmea_multitag'])
def test_iec_450_nmea_multitag_sentence(packet_iec_450_nmea_multitag):
    assert '$HEROT,+000.05,A*35\r\n' == packet_iec_450_nmea_multitag['_source']['layers']['iec-61162-450-nmea']['iec-61162-450-nmea.sentence']


@pytest.mark.dependency(depends=['test_iec_450_nmea_multitag'])
def test_iec_450_nmea_multitag_nmea_0183(packet_iec_450_nmea_multitag):
    assert 'nmea-0183.talkerid' in packet_iec_450_nmea_multitag['_source']['layers']['iec-61162-450-nmea']['nmea-0183'] 
    assert 'HE' == packet_iec_450_nmea_multitag['_source']['layers']['iec-61162-450-nmea']['nmea-0183']['nmea-0183.talkerid']
    assert 'nmea-0183.sentenceid' in packet_iec_450_nmea_multitag['_source']['layers']['iec-61162-450-nmea']['nmea-0183']
    assert 'ROT' == packet_iec_450_nmea_multitag['_source']['layers']['iec-61162-450-nmea']['nmea-0183']['nmea-0183.sentenceid']
    assert 'nmea-0183.data' in packet_iec_450_nmea_multitag['_source']['layers']['iec-61162-450-nmea']['nmea-0183']
    assert '+000.05,A' == packet_iec_450_nmea_multitag['_source']['layers']['iec-61162-450-nmea']['nmea-0183']['nmea-0183.data']
    assert 'nmea-0183.checksum' in packet_iec_450_nmea_multitag['_source']['layers']['iec-61162-450-nmea']['nmea-0183']
    assert '0x35 [valid]' == packet_iec_450_nmea_multitag['_source']['layers']['iec-61162-450-nmea']['nmea-0183']['nmea-0183.checksum']


@pytest.mark.dependency(depends=['test_iec_450_nmea'])
def test_iec_450_nmea_wrong_tag_checksum(packet_iec_450_nmea, packet_iec_450_nmea_wrong_tag_checksum):
    ws_expert = {
        'iec-61162-450-nmea.tag-checksum-corrupt': '', 
        '_ws.expert.message': 'IEC-61162-450 Tag checksum corrupt: s:HE0001*AA', 
        '_ws.expert.severity': '8388608', 
        '_ws.expert.group': '16777216'}
    assert '_ws.expert' in packet_iec_450_nmea_wrong_tag_checksum['_source']['layers']['iec-61162-450-nmea']
    assert packet_iec_450_nmea_wrong_tag_checksum['_source']['layers']['iec-61162-450-nmea']['_ws.expert'] == ws_expert


@pytest.mark.dependency(depends=['test_nmea_0183'])
def test_nmea_0183_wrong_checksum(packet_nmea_0183_wrong_checksum):
    ws_expert = {
        'nmea-0183.checksum-corrupt': '', 
        '_ws.expert.message': 'NMEA 0183 Checksum corrupt', 
        '_ws.expert.severity': '8388608', 
        '_ws.expert.group': '16777216'}
    assert '_ws.expert' in packet_nmea_0183_wrong_checksum['_source']['layers']['nmea-0183']
    assert packet_nmea_0183_wrong_checksum['_source']['layers']['nmea-0183']['_ws.expert'] == ws_expert


@pytest.mark.dependency(depends=['test_nmea_0183'])
def test_nmea_0183_sentence_too_long(packet_nmea_0183_sentence_too_long):
    ws_expert = {
        'nmea-0183.length-exceeded': '', 
        '_ws.expert.message': 'NMEA 0183 Length exceeded: 95 Byte [Max. allowed: 82 Byte]', 
        '_ws.expert.severity': '8388608', 
        '_ws.expert.group': '117440512'}
    assert '_ws.expert' in packet_nmea_0183_sentence_too_long['_source']['layers']['nmea-0183']
    assert packet_nmea_0183_sentence_too_long['_source']['layers']['nmea-0183']['_ws.expert'] == ws_expert


@pytest.mark.dependency(depends=['test_nmea_0183'])
def test_iec_450_nmea_sentence_too_long(packet_iec_450_nmea_sentence_too_long):
    ws_expert = {
        'nmea-0183.length-exceeded': '', 
        '_ws.expert.message': 'NMEA 0183 Length exceeded: 95 Byte [Max. allowed: 82 Byte]', 
        '_ws.expert.severity': '8388608', 
        '_ws.expert.group': '117440512'}
    assert '_ws.expert' in packet_iec_450_nmea_sentence_too_long['_source']['layers']['iec-61162-450-nmea']['nmea-0183']
    assert packet_iec_450_nmea_sentence_too_long['_source']['layers']['iec-61162-450-nmea']['nmea-0183']['_ws.expert'] == ws_expert


@pytest.mark.dependency(depends=['test_nmea_0183'])
def test_iec_450_nmea_tag_too_long(packet_iec_450_nmea_tag_too_long):
    ws_expert = {
        'iec-61162-450-nmea.tag-exceeded': '', 
        '_ws.expert.message': 'Tag length exceeded: s:HE0001,x:THIS-IS-A-VERY-VERY-VERY-VERY-VERY-VERY-VERY-VERY-VERY-VERY-VERY-LONG_TAG*69 (length: 87 Byte; allowed: 80 Byte)', 
        '_ws.expert.severity': '8388608', 
        '_ws.expert.group': '117440512'}
    assert '_ws.expert' in packet_iec_450_nmea_tag_too_long['_source']['layers']['iec-61162-450-nmea']
    assert packet_iec_450_nmea_tag_too_long['_source']['layers']['iec-61162-450-nmea']['_ws.expert'] == ws_expert
