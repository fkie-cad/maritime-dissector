import subprocess
import json

from utils import duplicate_keys_to_array


def test_furuno_img():
    process = subprocess.run(['tshark', '-T', 'json', '-X', 'lua_script:../furuno-dissector.lua', '-r', 'furuno-radar-img.pcap', '-o', 'furuno-img.split_spokes:false', '-2'], stdout=subprocess.PIPE)
    pkts = json.loads(process.stdout, object_pairs_hook=duplicate_keys_to_array)
    for pkt in pkts:
        assert "furuno-img" in pkt["_source"]["layers"]

    pkt = pkts[3]["_source"]["layers"]["furuno-img"]
    assert pkt["furuno-img.msg_type"] == "02"
    assert pkt["furuno-img.seq_number"] == "3"
    assert pkt["furuno-img.furuno_marker"] == "00:01:00:00:00:00"
    assert pkt["furuno-img.size"] == "134"
    assert pkt["furuno-img.spoke_cnt"] == "10"
    assert pkt["furuno-img.cell_cnt"] == "884"
    assert pkt["furuno-img.compr_lvl"] == "3"
    assert pkt["furuno-img.range"] == "2"
    assert pkt["furuno-img.ace"] == "1"

    assert "furuno-img" not in pkt
    assert len(pkt["furuno-img.azimuth_list"].split("  ")) == len(pkt["furuno-img.heading_list"].split("  ")) == int(pkt["furuno-img.spoke_cnt"])


def test_furuno_img_split_spokes():
    process = subprocess.run(['tshark', '-T', 'json', '-X', 'lua_script:../furuno-dissector.lua', '-r', 'furuno-radar-img.pcap', '-o', 'furuno-img.split_spokes:true', '-2'], stdout=subprocess.PIPE)
    pkts = json.loads(process.stdout, object_pairs_hook=duplicate_keys_to_array)
    for pkt in pkts:
        assert "furuno-img" in pkt["_source"]["layers"]

    pkt = pkts[7]["_source"]["layers"]["furuno-img"]
    assert "furuno-img.azimuth_list" not in pkt
    assert "furuno-img.heading_list" not in pkt
    assert len(pkt["furuno-img"]) == int(pkt["furuno-img.spoke_cnt"])

    correct_azs = ["46", "46", "48", "50", "52", "52", "54" ,"54", "56", "56"]
    for spoke, az in zip(pkt["furuno-img"], correct_azs):
        assert spoke["furuno-img.azimuth"] == az
        assert spoke["furuno-img.heading"] == "0x09de"
        assert "furuno-img.encoded_data" in spoke


