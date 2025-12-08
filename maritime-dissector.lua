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

-- ensure local modules can be required regardless of CWD
do
    local debug = require("debug")
    local info = debug.getinfo(1, "S")
    local script = info and info.source or ""
    if script:sub(1,1) == "@" then
        local base_dir = script:match("(.+[\\/])") or "./"
        local base_dir = script:match("(.*/)") or "./"
        -- Append search patterns for modules under the repository root (where this file lives)
        local function add_path(p)
            if not string.find(package.path, p, 1, true) then
                package.path = package.path .. ";" .. p
            end
        end
        add_path(base_dir .. "?.lua")
        add_path(base_dir .. "?/init.lua")
    end
end

-- load modules
local proto_nmea0183 = require "maritime-modules.proto.nmea0183"
local proto_nmea2000 = require "maritime-modules.proto.nmea2000"
local proto_iec61162450_nmea = require "maritime-modules.proto.iec61162450nmea"
local proto_iec61162450_binary = require "maritime-modules.proto.iec61162450binary"
local heuristic = require "maritime-modules.heuristic"

-- register heuristic checkers (idempotent guard to avoid double registration)
if not _G.__maritimedissector_heuristics_registered then
    local function safe_register(proto, table_name, fn)
        pcall(function() proto:register_heuristic(table_name, fn) end)
    end
    safe_register(proto_nmea0183, "udp", heuristic.nmea_0183_heuristic_checker)
    safe_register(proto_nmea2000, "can", heuristic.nmea_2000_heuristic_checker)
    safe_register(proto_iec61162450_nmea, "udp", heuristic.iec_61162_450_nmea_heuristic_checker)
    safe_register(proto_iec61162450_binary, "udp", heuristic.iec_61162_450_binary_heuristic_checker)
    safe_register(proto_iec61162450_binary, "pgm", heuristic.iec_61162_450_binary_heuristic_checker)
    _G.__maritimedissector_heuristics_registered = true
end

-- disable loading of modules
_G['maritimedissector'] = nil
