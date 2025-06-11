#!/usr/bin/env bash
set -e

# Provide a pcap file to the script such as from https://github.com/canboat/canboat/blob/master/samples/can0-1.pcap

all_pgn=$(tshark -T json -X lua_script:../../maritime-dissector.lua -r can.pcap | grep nmea-2000.pgn | cut -d '"' -f 4 | sort -n | uniq)

for pgn in $all_pgn;
do
    echo $pgn
    tshark -Y "nmea-2000.pgn == $pgn" -X lua_script:../../maritime-dissector.lua -r can.pcap -w nmea2000-$pgn.pcap
done
