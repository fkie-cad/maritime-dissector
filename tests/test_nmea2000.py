import pytest
import math
import subprocess
import json
import os
import tempfile

from utils import duplicate_keys_to_array


script_dir = os.path.dirname(os.path.realpath(__file__))
FILES = [
    (
        f"{script_dir}/nmea2000/{f}",
        f"{script_dir}/nmea2000/{f.replace('.pcap', '.json')}",
    )
    for f in os.listdir(script_dir + "/nmea2000/")
    if f.startswith("nmea2000-") and f.endswith(".pcap")
]


# Fields that vary between tshark versions and should be skipped
VERSION_DEPENDENT_FIELDS = {
    "can.reserved", "can.len8dlc", "canfd",
    "frame.encoding", "frame.time_delta", "frame.time_delta_displayed",
    "_type",
}

# Timestamp fields with format changes between tshark versions
TIMESTAMP_FORMAT_FIELDS = {"frame.time", "frame.time_utc", "frame.time_epoch"}

# Relative tolerance for float comparison (tshark 4.6+ changed numeric precision)
FLOAT_RELATIVE_TOLERANCE = 1e-5


def floats_are_close(a: float, b: float, rel_tol: float = FLOAT_RELATIVE_TOLERANCE) -> bool:
    """Compare floats with relative tolerance, handling edge cases."""
    if math.isnan(a) and math.isnan(b):
        return True
    if math.isinf(a) or math.isinf(b):
        return a == b
    # Use relative tolerance based on the larger magnitude
    max_val = max(abs(a), abs(b), 1.0)
    return abs(a - b) / max_val <= rel_tol


def compare_json_with_tolerance(expected, actual, tolerance: float = FLOAT_RELATIVE_TOLERANCE, current_key: str = ""):
    """Recursively compare two JSON objects, skipping version-dependent fields."""
    if isinstance(expected, dict) and isinstance(actual, dict):
        for key in expected:
            if key.startswith("Lua Error") or key == "Lua Traceback":
                continue
            if key in VERSION_DEPENDENT_FIELDS or key in TIMESTAMP_FORMAT_FIELDS:
                continue

            assert key in actual, f"Key '{key}' not found in actual JSON."
            compare_json_with_tolerance(expected[key], actual[key], tolerance, key)

    elif isinstance(expected, str) and isinstance(actual, str):
        try:
            compare_json_with_tolerance(float(expected), float(actual), tolerance, current_key)
        except ValueError:
            assert expected == actual, f"Value mismatch: {expected} != {actual}"

    elif isinstance(expected, list) and isinstance(actual, list):
        assert len(expected) == len(actual), f"List lengths differ: {len(expected)} != {len(actual)}"
        for expected_item, actual_item in zip(expected, actual):
            compare_json_with_tolerance(expected_item, actual_item, tolerance, current_key)

    elif isinstance(expected, float) and isinstance(actual, float):
        assert floats_are_close(expected, actual, tolerance), (
            f"Value mismatch: {expected} != {actual}"
        )

    # Handle CAN layer differences between tshark versions
    elif expected == "Controller Area Network" and isinstance(actual, dict):
        pass
    elif isinstance(expected, dict) and actual == "Controller Area Network":
        pass

    else:
        assert expected == actual, f"Value mismatch: {expected} != {actual}"


@pytest.mark.parametrize("pcap,control", FILES)
def test_nmea2000_pgn(pcap, control):
    # Ensure no system/global plugins conflict with local script
    repo_root = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))

    with tempfile.TemporaryDirectory() as empty_plugins_dir:
        env = os.environ.copy()
        env["WIRESHARK_PLUGIN_DIR"] = empty_plugins_dir

        process = subprocess.run(
            [
                "tshark",
                "-T",
                "json",
                "-X",
                "lua_script:../maritime-dissector.lua",
                "-r",
                pcap,
            ],
            stdout=subprocess.PIPE,
            env=env,
        )

    json_pcap = json.loads(process.stdout, object_pairs_hook=duplicate_keys_to_array)

    with open(control, "r") as f:
        json_control = json.load(f, object_pairs_hook=duplicate_keys_to_array)

    compare_json_with_tolerance(json_pcap, json_control)
