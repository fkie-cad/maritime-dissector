#!/usr/bin/env bash

for file in ./nmea2000-*.pcap; do
    out=
    tshark -T json -X lua_script:../../maritime-dissector.lua -r $file > "$(basename "$file" .pcap).json"
done
