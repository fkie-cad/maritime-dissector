if not _G["br24-dissector"] then return end

function parse_radar_type(rt_code)
    local radar_type_str = "Unknown"
    if rt_code == "\01" then radar_type_str = "4G or 3G+"
    elseif rt_code == "\08" then radar_type_str = "3G"
    elseif rt_code == "\15" then radar_type_str = "BR24"
    elseif rt_code == "\00" then radar_type_str = "HALO"
    end
    return radar_type_str
end

function parse_rw(rw_code)
    local cmd = "Unknown"
    if rw_code == "\193" then cmd = "WRITE" -- 0xc1
    elseif rw_code == "\194" then cmd = "READ"
    end
    return cmd
end

function parse_ops(op_code)
    local cmd = "Unknown"
    if op_code == "\00" then cmd = "STOP"
    elseif op_code == "\01" then cmd = "START"
    end
    return cmd
end

function parse_percentage(raw_val)
    local percentage = "Invalid Value"
    if raw_val <= 255 then
        percentage = ("%.2g"):format(math.floor((raw_val + 1) * 100 / 255))
        percentage = percentage .. "%"
    end
    return percentage
end

function parse_if_rej(ifr_code)
    local cmd = "Unknown"
    if ifr_code == "\00" then cmd = "OFF"
    elseif ifr_code == "\01" then cmd = "LOW"
    elseif ifr_code == "\02" then cmd = "MEDIUM"
    elseif ifr_code == "\03" then cmd = "HIGH"
    end
    return cmd
end

function parse_target_boost(tb_code)
    local cmd = "Unknown"
    if tb_code == "\00" then cmd = "OFF"
    elseif tb_code == "\01" then cmd = "LOW"
    elseif tb_code == "\02" then cmd = "HIGH"
    end
    return cmd
end

function parse_loc_if_rej(ifr_code)
    local cmd = "Unknown"
    if ifr_code == "\00" then cmd = "OFF"
    elseif ifr_code == "\01" then cmd = "LOW"
    elseif ifr_code == "\02" then cmd = "MEDIUM"
    elseif ifr_code == "\03" then cmd = "HIGH"
    end
    return cmd
end

function parse_scan_speed(sp_code)
    local cmd = "Unknown"
    if sp_code == "\00" then cmd = "NORMAL"
    elseif sp_code == "\01" then cmd = "FAST"
    end
    return cmd
end

function parse_sea_clutter_auto(sa_code)
    local cmd = "Unknown"
    if sa_code == "\00" then cmd = "OFF"
    elseif sa_code == "\01" then cmd = "HARBOR"
    elseif sa_code == "\02" then cmd = "OFFSHORE"
    end
    return cmd
end

function parse_gain_auto(ga_code)
    local cmd = "Unknown"
    if ga_code == "\00" then cmd = "OFF"
    elseif ga_code == "\01" then cmd = "ON"
    end
    return cmd
end
