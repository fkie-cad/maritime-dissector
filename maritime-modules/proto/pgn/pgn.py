#!/usr/bin/env python3
import requests
import json
import os

abspath = os.path.abspath(__file__)
dname = os.path.dirname(abspath)
os.chdir(dname)

UNSUPPORTED = [130817]

def get_bitmask(length, offset): # Note Litle endian
    mask = 0x00
    while length > 0:
        mask = mask << 1 | 0x01
        length -= 1

    while offset > 0:
        mask = mask << 1
        offset -= 1
    return hex(mask)

def parse_field(field, pgn):
    if "FieldType" not in field:
        if not field["Id"].endswith("RepeatAsNeeded") and not field["Id"].endswith("RepeatedAsNeeded"):
            print("WARNING: Missing Fieldtype")
        else:
            pass # TODO Handle those types
        return [], [], []

    ######### Integer
    if field["FieldType"] in ["NUMBER", "DATE", "TIME", "DURATION", "PGN", "ISO_NAME", "MMSI"]: # uint8 uint16 uint32 int8 ...
        if "BitStart" in field and int(field["BitStart"]) % 8 != 0:
            print("WARNING: BitStart not divisible by 8")
            return [], [], []
            assert int(field["BitStart"]) % 8 == 0

        if "BitOffset" not in field:
            print("WARNING: Missing BitOffset")
            return [], [], []

        if int(field["BitLength"]) % 8 != 0:
            print("WARNING: BitLength not divisible by 8")
            return [], [], []

        assert int(field["BitOffset"]) % 8 == 0
        assert int(field["BitLength"]) % 8 == 0

        if "Resolution" in field:
            scale = field["Resolution"]
            proto = f"""local {field["Id"]} = ProtoField.float("nmea-2000-{pgn}.{field["Id"]}", "{field["Name"]}{" ("+field["Unit"]+")" if "Unit" in field else ""}")"""

            if "Signed" not in field: # NOTE default unsigned for DATE/TIME/DURATION/PGN/ISO_NAME/MMSI
                field["Signed"] = False

            if field["Signed"]:
                tree = f"""subtree:add({field["Id"]}, buffer(str_offset + {int(field["BitOffset"]) // 8}, {int(field["BitLength"]) // 8}), buffer(str_offset + {int(field["BitOffset"]) // 8}, {int(field["BitLength"]) // 8}):le_int{"64():tonumber" if field["BitLength"] == "64" else ""}() * {scale})"""
            else:
                tree = f"""subtree:add({field["Id"]}, buffer(str_offset + {int(field["BitOffset"]) // 8}, {int(field["BitLength"]) // 8}), buffer(str_offset + {int(field["BitOffset"]) // 8}, {int(field["BitLength"]) // 8}):le_uint{"64():tonumber" if field["BitLength"] == "64" else ""}() * {scale})"""

        else:
            assert False

        return [proto], [tree], [field["Id"]]

    ######### Float
    elif field["FieldType"] == "FLOAT": # float32 resolution 1, signed 1
        assert int(field["BitStart"]) % 8 == 0
        assert int(field["BitOffset"]) % 8 == 0
        assert int(field["BitLength"]) == 32
        assert field["Signed"] == True

        proto = f"""local {field["Id"]} = ProtoField.float("nmea-2000-{pgn}.{field["Id"]}", "{field["Name"]}{" ("+field["Unit"]+")" if "Unit" in field else ""}")"""

        tree = f"""subtree:add({field["Id"]}, buffer(str_offset + {int(field["BitOffset"]) // 8}, {int(field["BitLength"]) // 8}))"""

        return [proto], [tree], [field["Id"]]

    ######### Bit
    elif field["FieldType"] == "LOOKUP":

        if "BitOffset" not in field:
            print("WARNING: Missing BitOffset")
            return [], [], []

        if "BitLength" not in field:
            if pgn not in ["129792", "129795", "129797"]:
                print("WARNING: Missing BitLength")
            else:
                pass # TODO handle these fields
            return [], [], []

        if int(field["BitLength"]) > 8:
            print("WARNING: bit is too long. Not Implemented yet")
            return [], [], []

        assert field["FieldType"] == "LOOKUP"
        assert int(field["BitLength"]) <= 8
        assert (int(field["BitOffset"]) - int(field["BitStart"])) % 8 == 0
        assert "Resolution" not in field or field["Resolution"] == 1
        assert field["Signed"] == False

        bitmask = get_bitmask(int(field["BitLength"]), int(field["BitStart"]))

        proto = f"""local {field["Id"]} = ProtoField.uint8("nmea-2000-{pgn}.{field["Id"]}", "{field["Name"]}{" ("+field["Unit"]+")" if "Unit" in field else ""}", base.DEC, NULL, {bitmask})"""

        tree = f"""subtree:add({field["Id"]}, buffer(str_offset + {int(field["BitOffset"]) // 8}, 1))"""

        return [proto], [tree], [field["Id"]]

    ######### String FIX
    elif field["FieldType"] == "STRING_FIX":

        if "BitOffset" not in field:
            print("WARNING: Missing BitOffset")
            return [], [], []

        if "BitLength" not in field:
            print("WARNING: Missing BitLength")
            return [], [], []

        assert "BitStart" not in field or int(field["BitStart"]) == 0
        assert int(field["BitOffset"]) % 8 == 0
        assert int(field["BitLength"]) % 8 == 0

        proto = f"""local {field["Id"]} = ProtoField.string("nmea-2000-{pgn}.{field["Id"]}", "{field["Name"]}{" ("+field["Unit"]+")" if "Unit" in field else ""}")"""

        tree = f"""subtree:add({field["Id"]}, buffer(str_offset + {int(field["BitOffset"]) // 8}, {int(field["BitLength"]) // 8}))"""

        return [proto], [tree], [field["Id"]]

    ######### String LAU
    elif field["FieldType"] == "STRING_LAU":
        # Variable encoding 1. byte length 2. byte type (0 UNICODE, 1 ASCII)
        # TODO Problem: other fields after a STRING_LAU may change their position depending on the length of the string

        if "BitOffset" not in field:
            field["BitOffset"] = 0 # Hack: we rely on str_offset

        assert "BitStart" not in field or int(field["BitStart"]) == 0
        assert int(field["BitOffset"]) % 8 == 0

        proto = f"""local {field["Id"]} = ProtoField.string("nmea-2000-{pgn}.{field["Id"]}", "{field["Name"]}{" ("+field["Unit"]+")" if "Unit" in field else ""}")"""

        tree = f"""length = buffer(str_offset + {int(field["BitOffset"]) // 8}, 1):uint() - 2
    -- type = buffer(str_offset + {int(field["BitOffset"]) // 8} + 1, 1):uint() --0 Unicode, 1 ASCII (ignored)
    subtree:add({field["Id"]}, buffer(str_offset + {int(field["BitOffset"]) // 8} + 2, length))
    str_offset = str_offset + length + 2"""

        return [proto], [tree], [field["Id"]]

    ######### Unknown
    else: # Unknown or reserved
        if field["FieldType"] not in ["RESERVED", "SPARE"]:
            print(f"""Unknown field type {field["FieldType"]}""")
            print(json.dumps(field, indent=4), pgn)
        return [], [], []


# Download NMEA2000 definition
if os.path.isfile("../../../docs/canboat.json"):
    with open("../../../docs/canboat.json", "r") as f:
        data = json.load(f)
else:
    print("Downloading NMEA2000 definition ...")
    url = "https://raw.githubusercontent.com/canboat/canboat/refs/heads/master/docs/canboat.json"
    response = requests.get(url)
    data = json.loads(response.content)

# Parse NMEA2000 definition
created = []
for pgn in data["PGNs"]:

    if pgn["PGN"] in UNSUPPORTED:
        continue

    if 59392 <= pgn["PGN"] and pgn["PGN"] <= 60928: # Ignore ISO 11783 protocol definition
        continue
    if pgn["PGN"] == 61184: # Ignore Manufacturer proprietary
        continue
    if 65280 <= pgn["PGN"] and pgn["PGN"] <= 65535: # Ignore Manufacturer proprietary
        continue

    created.append(pgn["PGN"])
    fieldnames = []
    proto_fields = []
    tree_nodes = []

    for field in pgn["Fields"]:
        # Sanitize field["Id"] as they cannot contain numbers
        if field["Id"].startswith("1st"):
            field["Id"] = "first" + field["Id"][2:]

        proto, tree, name = parse_field(field, pgn["PGN"])
        proto_fields += proto
        tree_nodes += tree
        fieldnames += name
     
    # Write pgn_***.lua files
    with open(f"pgn_{pgn["PGN"]}.lua", "w") as f:

        f.write(f"""-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

NMEA_2000_{pgn["PGN"]} = Proto("nmea-2000-{pgn["PGN"]}", "{pgn["Description"]} ({pgn["PGN"]})")\n""")

        for field in proto_fields:
            f.write(f"""{field}\n""")

        f.write(f"""\nNMEA_2000_{pgn["PGN"]}.fields = {{{",".join(fieldnames)}}}

function NMEA_2000_{pgn["PGN"]}.dissector(buffer, pinfo, tree)
    local subtree_title = "PGN {pgn["PGN"]} ({pgn["Description"]})"
    local subtree = tree:add(NMEA_2000_{pgn["PGN"]}, buffer(), subtree_title)
    local str_offset = 0\n\n""")

        for node in tree_nodes:
            f.write(f"""    {node}\n""")

        f.write(f"""end

return NMEA_2000_{pgn["PGN"]}
""")

with open(f"./pgn.lua", "w") as f:
    f.write(f"""-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

-- WARNING: This file is generated automatically by ./pgn.py --

local pgn_dissector = {{}}

""")

    for c in created:
        f.write(f"NMEA_2000_{c} = require \"maritime-modules.proto.pgn.pgn_{c}\"\n")

    f.write(f"""\nfunction pgn_dissector.dissector(buffer, pinfo, tree, pgn)\n""")

    for c in created:
        f.write(f"""    {"if" if c == created[0] else "elseif"} pgn == {c} then
        NMEA_2000_{c}.dissector(buffer, pinfo, tree)\n""")

    f.write(f"""    else
        return false
    end

    return true
end

return pgn_dissector""")
