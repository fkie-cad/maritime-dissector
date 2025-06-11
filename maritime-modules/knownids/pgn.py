#!/usr/bin/env python3
import requests
import os
import json

ONLINE = False

UNSUPPORTED = [130817]

# Download NMEA2000 definition
if os.path.isfile("../../docs/canboat.json"):
    with open("../../docs/canboat.json", "r") as f:
        data = json.load(f)
else:
    print("Downloading NMEA2000 definition ...")
    url = "https://raw.githubusercontent.com/canboat/canboat/refs/heads/master/docs/canboat.json"
    response = requests.get(url)
    data = json.loads(response.content)

with open("pgn.lua", "w") as f:
    f.write(f"""-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

-- List of known PGN for NMEA 2000 (Source: https://github.com/canboat/canboat/blob/master/sources/NMEA_database_1_300.xml)
local known_pgns = {{\n""")

    # Parse XML
    for pgn in data["PGNs"]:
        if pgn["PGN"] in UNSUPPORTED:
            continue

        f.write(f"\t[{int(pgn["PGN"])}]=\"{pgn["Description"]}\",\n")

    f.write(f"""}}

return known_pgns""")

with open("pgn-fragmented.lua", "w") as f:
    f.write(f"""-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

-- List of fragmented PGN for NMEA 2000 (Source: https://github.com/canboat/canboat/blob/master/sources/NMEA_database_1_300.xml)
local fragmented_pgns = {{\n""")

    # Parse XML
    for pgn in data["PGNs"]:
        if pgn["PGN"] in UNSUPPORTED:
            continue

        if pgn["Type"] == "Fast":
            f.write(f"\t[{int(pgn["PGN"])}]=true,\n")

    f.write(f"""}}

return fragmented_pgns""")
