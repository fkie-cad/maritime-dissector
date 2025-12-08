#!/usr/bin/env bash
set -euo pipefail

# Ensure no global/system plugins interfere
EMPTY_PLUGINS_DIR="$(dirname "$0")/../empty_plugins"
mkdir -p "$EMPTY_PLUGINS_DIR"

for file in ./nmea2000-*.pcap; do
    out_json="$(basename "$file" .pcap).json"
    WIRESHARK_PLUGIN_DIR="$EMPTY_PLUGINS_DIR" \
    tshark -T json -X lua_script:../../maritime-dissector.lua -r "$file" > "$out_json"
done
