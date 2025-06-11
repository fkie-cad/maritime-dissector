import subprocess
import json

from utils import duplicate_keys_to_array


def test_br24_img_data():
    process = subprocess.run(['tshark', '-T', 'json', '-X', 'lua_script:../br24-dissector.lua', '-r', 'br24-img-data.pcap', '-2'], stdout=subprocess.PIPE)
    pkt = json.loads(process.stdout, object_pairs_hook=duplicate_keys_to_array)[-1]
    assert "navicobr24-img" in pkt["_source"]["layers"]

    navico_pkt = pkt["_source"]["layers"]["navicobr24-img"]["navicobr24-img"]
    assert navico_pkt[0]["br24-img.msgstart"] == "01:00:00:00:00"
    assert int(navico_pkt[0]["br24-img.ns"]) == len(navico_pkt[1]["navicobr24-img"])
    assert navico_pkt[0]["br24-img.ss"] == "512"

    navico_pkt_img_head = navico_pkt[1]["navicobr24-img"][0]["navicobr24-img"][0]
    assert navico_pkt_img_head["br24-img.l"] == "24"
    assert navico_pkt_img_head["br24-img.st"] == "02"
    assert navico_pkt_img_head["br24-img.rc"] == "0"
    assert navico_pkt_img_head["br24-img.a"] == "0"
    assert navico_pkt_img_head["br24-img.heading"] == "37428"
    assert navico_pkt_img_head["br24-img.scale"] == "424"

    navico_pkt_img_data = navico_pkt[1]["navicobr24-img"][0]["navicobr24-img"][1]
    assert len(navico_pkt_img_data["br24-img.pixels"].split(":")) == int(navico_pkt[0]["br24-img.ss"])


def test_br24_reg_data():
    process = subprocess.run(
        ['tshark', '-T', 'json', '-X', 'lua_script:../br24-dissector.lua', '-r', 'br24-reg-data.pcap', '-2'],
        stdout=subprocess.PIPE)
    pkts = json.loads(process.stdout, object_pairs_hook=duplicate_keys_to_array)

    for p in pkts:
        assert "navicobr24-reg" in p["_source"]["layers"]

    pkt = pkts[0]
    assert pkt["_source"]["layers"]["navicobr24-reg"]["br24-register.register"] == "a0"
    assert pkt["_source"]["layers"]["navicobr24-reg"]["br24-register.command"] == "c1"


def test_br24_rep_data():
    process = subprocess.run(
        ['tshark', '-T', 'json', '-X', 'lua_script:../br24-dissector.lua', '-r', 'br24-rep-data.pcap', '-2'],
        stdout=subprocess.PIPE)
    pkts = json.loads(process.stdout, object_pairs_hook=duplicate_keys_to_array)

    for p in pkts:
        assert "navicobr24-rep" in p["_source"]["layers"]

    pkt = pkts[0]["_source"]["layers"]["navicobr24-rep"]
    assert pkt["br24-report.st"] == "02"

    pkt = pkts[1]["_source"]["layers"]["navicobr24-rep"]
    assert pkt["br24-report.range"] == "30000"
    assert pkt["br24-report.gain_auto"] == "00"
    assert pkt["br24-report.gain"] == "129"
    assert pkt["br24-report.sea_auto"] == "00"
    assert pkt["br24-report.sea_state"] == "52"
    assert pkt["br24-report.rain"] == "78"
    assert pkt["br24-report.if_rej"] == "01"
    assert pkt["br24-report.target_exp"] == "01"
    assert pkt["br24-report.target_boost"] == "00"

    pkt = pkts[2]["_source"]["layers"]["navicobr24-rep"]
    assert pkt["br24-report.radar_type"] == "0f"
    assert "br24-report.firmware_date" in pkt
    assert "br24-report.firmware_time" in pkt

    pkt = pkts[3]["_source"]["layers"]["navicobr24-rep"]
    assert pkt["br24-report.bearing_alignment"] == "00:00"
    assert pkt["br24-report.antenna"] == "4000"
