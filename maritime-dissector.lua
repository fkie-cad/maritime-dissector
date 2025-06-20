-- set the plugin version information
if set_plugin_info then
    local my_info = {
        version = "0.2.0",
        license = "MIT License (supplemented)",
        copyright = "Copyright (c) 2025 Fraunhofer FKIE",
        author = "CAD-Maritime",
        email = "cad-maritime@fkie.fraunhofer.de",
        repository = "https://github.com/fkie-cad/maritime-dissector",
        description = "This is a plugin for Wireshark, to dissect maritime protocols such as IEC-61162-450, NMEA-0183, and NMEA-2000.",
        help = [[
    HOW TO RUN THIS SCRIPT:
    Wireshark and Tshark support multiple ways of loading Lua scripts: through
    a dofile() call in init.lua, through the file being in either the global
    or personal plugins directories, or via the command line. The latter two
    methods are the best: either copy this script into your "Personal Plugins"
    directory, or load it from the command line.
    ]]
    }
    set_plugin_info(my_info)
end

-- check for testenvironment
RUN_TESTS=os.getenv("TEST")
GET_COVERAGE=os.getenv("COVERAGETEST")

-- if testenvironment detected use luacov for code coverage
if RUN_TESTS then
    _G.debug = require("debug")
    if GET_COVERAGE then
        local luacov = require("luacov")
    end
end

-- enable loading of modules
_G['maritimedissector'] = {}

-- load modules
local proto_nmea0183 = require "maritime-modules.proto.nmea0183"
local proto_nmea2000 = require "maritime-modules.proto.nmea2000"
local proto_iec61162450_nmea = require "maritime-modules.proto.iec61162450nmea"
local proto_iec61162450_binary = require "maritime-modules.proto.iec61162450binary"
local heuristic = require "maritime-modules.heuristic"

-- register heuristic checkers
proto_nmea0183:register_heuristic("udp", heuristic.nmea_0183_heuristic_checker)
proto_nmea2000:register_heuristic("can", heuristic.nmea_2000_heuristic_checker)
proto_iec61162450_nmea:register_heuristic("udp", heuristic.iec_61162_450_nmea_heuristic_checker)
proto_iec61162450_binary:register_heuristic("udp", heuristic.iec_61162_450_binary_heuristic_checker)
proto_iec61162450_binary:register_heuristic("pgm", heuristic.iec_61162_450_binary_heuristic_checker)

-- disable loading of modules
_G['maritimedissector'] = nil
