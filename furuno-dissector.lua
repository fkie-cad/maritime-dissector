-- set the plugin version information
if set_plugin_info then
    local my_info = {
        version = "0.1.0",
        license = "MIT License (supplemented)",
        copyright = "Copyright (c) 2025 Fraunhofer FKIE",
        author = "CAD-Maritime",
        email = "cad-maritime@fkie.fraunhofer.de",
        repository = "https://github.com/fkie-cad/maritime-dissector",
        description = "This is a plugin for Wireshark, to dissect the Furuno RADAR protocol.",
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

-- enable loading of modules
_G['furuno-dissector'] = {}

-- load modules
local proto_img = require "furuno-modules.furuno-img"
local furuno_heuristic = require "furuno-modules.furuno-heuristics"

-- register the protos
proto_img:register_heuristic("udp", furuno_heuristic.img_checker)

-- disable loading of modules
_G['furuno-dissector'] = nil
