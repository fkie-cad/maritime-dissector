import pytest
import math
import subprocess
import json
import os

from utils import duplicate_keys_to_array

FILES = [
    (f"nmea2000/{f}", f"nmea2000/{f.replace('.pcap', '.json')}")
    for f in os.listdir("nmea2000/") if f.startswith("nmea2000-") and f.endswith(".pcap")
]

def compare_json_with_tolerance(expected, actual, tolerance: float = 1e-15):
    """
    Recursively compare two JSON objects with a specified tolerance for float comparisons.
    """
    if isinstance(expected, dict) and isinstance(actual, dict):
        for key in expected:
            if key.startswith("Lua Error") or key == "Lua Traceback": # Somehow errors are different on machines
                continue

            assert key in actual, f"Key '{key}' not found in actual JSON."

            if key != "frame.time": # This can be different depending on local time settings
                compare_json_with_tolerance(expected[key], actual[key], tolerance)

    elif isinstance(expected, str) and isinstance(actual, str):
        try:
            compare_json_with_tolerance(float(expected), float(actual), tolerance)
        except ValueError:
            assert expected == actual, f"Value mismatch: {expected} != {actual}"

    elif isinstance(expected, list) and isinstance(actual, list):
        assert len(expected) == len(
            actual
        ), f"List lengths differ: {len(expected)} != {len(actual)}"
        for expected_item, actual_item in zip(expected, actual):
            compare_json_with_tolerance(expected_item, actual_item, tolerance)

    elif isinstance(expected, float) and isinstance(actual, float):
        if math.isnan(expected) and math.isnan(actual):
            pass  # Both are NaN, considered equal
        else:
            assert (
                abs(expected - actual) <= tolerance
            ), f"Value mismatch: {expected} != {actual} within tolerance {tolerance}"

    else:
        assert expected == actual, f"Value mismatch: {expected} != {actual}"


@pytest.mark.parametrize("pcap,control", FILES)
def test_nmea2000_pgn(pcap, control):
    process = subprocess.run(['tshark', '-T', 'json', '-X', 'lua_script:../maritime-dissector.lua', '-r', pcap], stdout=subprocess.PIPE)
    json_pcap = json.loads(process.stdout)

    with open(control, "r") as f:
        json_control = json.load(f)

    compare_json_with_tolerance(json_pcap, json_control)
