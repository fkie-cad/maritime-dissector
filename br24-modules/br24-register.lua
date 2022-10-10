if not _G["br24-dissector"] then return end

BR24_REGISTER = Proto("NavicoBR24-REG", "NAVICO BR24 RADAR register control protocol")

-- shared fields
register = ProtoField.bytes("br24-register.register", "register", base.SPACE)
command  = ProtoField.bytes("br24-register.command", "command", base.SPACE)

-- radar ops payload
startstop = ProtoField.bytes("br24-register.startstop", "start/stop", base.SPACE)
-- zoom level payload
range = ProtoField.uint32("br24-register.range", "range", base.DEC)

-- bearing payload
bearing = ProtoField.uint16("br24-register.bearing", "bearing alignment angle", base.DEC)

-- filters payload
selector = ProtoField.bytes("br24-register.selector", "selector", base.SPACE)
autoflag = ProtoField.bool("br24-register.filterauto", "auto flag")
filter_value = ProtoField.bytes("br24-register.filtervalue", "value", base.SPACE)

-- interference rejection payload
ifrej = ProtoField.bytes("br24-register.ifrej", "interference rejection", base.SPACE)

-- target boost payload
target_boost = ProtoField.bytes("br24-register.targetboost", "target boost", base.SPACE)

-- local interference filter payload
local_ifrej = ProtoField.bytes("br24-register.localifrej", "local interference filter")

-- scan speed payload
scan_speed = ProtoField.bytes("br24-register.scanspeed", "scan speed", base.SPACE)

-- antenna height payload
antenna = ProtoField.uint32("br24-register.antenna", "antenna height", base.DEC)

BR24_REGISTER.fields = {register, command, range, startstop, bearing, selector, autoflag, filter_value, ifrej,
                                 target_boost, local_ifrej, scan_speed, antenna}

-- known registers
REG_RADAR_OPS_A = "\00"
REG_RADAR_OPS_B = "\01"
REG_ZOOM = "\03"
REG_BEARING = "\05"
REG_FILTERS = "\06"
REG_IF_REJ = "\08"
REG_TARGET_EXPANSION = "\09"
REG_TARGET_BOOST = "\10"
REG_LOCAL_IF_FILTER = "\14"
REG_SCAN_SPEED = "\15"
REG_NOISE_REJ = "\33"
REG_TARGET_SEP = "\34"
REG_DOPPLER = "\35"
REG_ANTENNA_HEIGHT = "\48"
REG_KEEP_ALIVE = "\160"

-- filter selectors
SEL_GAIN = "\00"
SEL_SEA  = "\02"
SEL_RAIN = "\04"

function get_selector_name(s_code)

    local sel_name = "Unknown"

    if s_code == SEL_GAIN then sel_name = "GAIN"
    elseif s_code == SEL_SEA then sel_name = "SEA CLUTTER"
    elseif s_code == SEL_RAIN then sel_name = "RAIN CLUTTER"
    end

    return sel_name
end

function get_register_name(r_code)

    local register_name = "Unknown"

    if     r_code == REG_RADAR_OPS_A then register_name = "RADAR START/STOP (0x00)"
    elseif r_code == REG_RADAR_OPS_B then register_name = "RADAR START/STOP (0x01)"
    elseif r_code == REG_ZOOM then register_name = "ZOOM LEVEL (0x03)"
    elseif r_code == REG_BEARING then register_name = "BEARING ALIGNMENT (0x05)"
    elseif r_code == REG_FILTERS then register_name = "FILTERS (0x06)"
    elseif r_code == REG_IF_REJ then register_name = "INTERFERENCE REJECTION (0x08)"
    elseif r_code == REG_TARGET_BOOST then register_name = "TARGET BOOST (0x0A)" -- 0x0a is \10
    elseif r_code == REG_LOCAL_IF_FILTER then register_name = "LOCAL INTERFERENCE FILTER (0x0E)" -- 0x0e is \14
    elseif r_code == REG_SCAN_SPEED then register_name = "SCAN SPEED (0x0F)" -- 0x0f is \15
    elseif r_code == REG_KEEP_ALIVE then register_name = "KEEP ALIVE (0xA0)" -- 0xa0 is \160 etc..
    elseif r_code == REG_ANTENNA_HEIGHT then register_name = "ANTENNA HEIGHT (0x30)" 
    end
    return register_name
end

function BR24_REGISTER.dissector(buffer, pinfo, tree)
    length = buffer:len()
    if length < 2 then return end

    if pinfo.dst ~= Address.ip("236.6.7.10") and pinfo.dst ~= Address.ip("127.0.0.1") then return end

    local reg_code = buffer(0, 1):bytes():raw(0, 1)
    local reg_name = get_register_name(reg_code)
    pinfo.cols.protocol = BR24_REGISTER.name .. " - " .. reg_name

    local reg_tree = tree:add(BR24_REGISTER, buffer(), "Navico BR24 " .. reg_name .. " Register Control")

    reg_tree:add(register, buffer(0, 1)):append_text(" (" .. reg_name .. ")")

    local rw = parse_rw(buffer(1, 1):bytes():raw(0, 1))
    reg_tree:add(command, buffer(1, 1)):append_text(" (" .. rw .. ")")

    -- register 00 and 01, start/stop
    if (reg_code == REG_RADAR_OPS_A or reg_code == REG_RADAR_OPS_B) and length >= 3 then
        reg_tree:add(startstop, buffer(2, 1)):append_text(" (" .. parse_ops(buffer(2, 1):bytes():raw(0, 1)) .. ")")

    -- register 03, zoom
    elseif reg_code == REG_ZOOM and length >= 6 then
        reg_tree:add_le(range, buffer(2, 4)):append_text(" dm")

    -- register 05, bearing
    elseif reg_code == REG_BEARING and length >= 4 then
        reg_tree:add_le(bearing, buffer(2, 2))

    -- register 06, filters
    elseif reg_code == REG_FILTERS and length >= 11 then
        selector_code = buffer(2, 1):bytes():raw(0, 1)
        selector_name = get_selector_name(selector_code)
        auto = buffer(6, 1):bytes():raw(0, 1) == "\01"
        reg_tree:add(selector, buffer(2, 1)):append_text(" (" .. selector_name .. ")")
        reg_tree:add(autoflag, buffer(6, 1))
        if auto then
            if selector_code == SEL_SEA and auto then
                reg_tree:add(filter_value, buffer(10, 1))
                        :append_text(" (" .. parse_sea_clutter_auto(buffer(10, 1)
                        :bytes():raw(0, 1)) .. ")")
            else
                reg_tree:add(filter_value, buffer(10, 1))
            end
        else
            reg_tree:add(filter_value, buffer(10, 1)):append_text(" (" .. parse_percentage(buffer(10, 1):uint()) .. ")")
        end

    -- register 08, filters
    elseif reg_code == REG_IF_REJ and length >= 3 then
        ifrej_code = buffer(2, 1):bytes():raw(0, 1)
        ifrej_val = parse_if_rej(ifrej_code)
        reg_tree:add(ifrej, buffer(2, 1)):append_text(" (" .. ifrej_val .. ")")
    -- register 10, target boost
    elseif reg_code == REG_TARGET_BOOST and length >= 3 then
        tb_code = buffer(2, 1):bytes():raw(0, 1)
        tb_val = parse_target_boost(tb_code)
        reg_tree:add(target_boost, buffer(2, 1)):append_text(" (" .. tb_val .. ")")

    -- register 14 local interference filter
    elseif reg_code == REG_LOCAL_IF_FILTER and length >= 3 then
        local_ifrej_code = buffer(2, 1):bytes():raw(0, 1)
        local_ifrej_val = parse_loc_if_rej(local_ifrej_code)
        reg_tree:add(local_ifrej, buffer(2, 1)):append_text(" (" .. local_ifrej_val .. ")")

    -- register 15, scan speed
    elseif reg_code == REG_SCAN_SPEED and length >= 3 then
        sp_code = buffer(2, 1):bytes():raw(0, 1)
        sp_val = parse_scan_speed(sp_code)
        reg_tree:add(scan_speed, buffer(2, 1)):append_text(" (" .. sp_val .. ")")

    -- register 48, antenna height
    elseif reg_code == REG_ANTENNA_HEIGHT and length >= 10 then
        reg_tree:add_le(antenna, buffer(6, 4)):append_text(" mm")
    end
end

return BR24_REGISTER
