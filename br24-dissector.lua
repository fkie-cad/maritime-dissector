-- set the plugin version information
if set_plugin_info then
    local my_info = {
        version = "0.1.0",
        license = "MIT License (supplemented)",
        copyright = "Copyright (c) 2025 Fraunhofer FKIE",
        author = "CAD-Maritime",
        email = "cad-maritime@fkie.fraunhofer.de",
        repository = "https://github.com/fkie-cad/maritime-dissector",
        description = "This is a plugin for Wireshark, to dissect the BR24 RADAR protocol.",
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
_G['br24-dissector'] = {}

-- load modules
require "br24-modules.parsers"
local proto_img = require "br24-modules.br24-img"
local proto_report = require "br24-modules.br24-report"
local proto_register = require "br24-modules.br24-register"

-- register the protos
local udp_port = DissectorTable.get("udp.port")
udp_port:add(6678, proto_img)
udp_port:add(6679, proto_report)
udp_port:add(6680, proto_register)

-- disable loading of modules
_G['br24-dissector'] = {}
