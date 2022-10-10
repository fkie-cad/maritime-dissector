if not _G["br24-dissector"] then return end

BR24_REPORT = Proto("NavicoBR24-REP", "Navico BR24 RADAR report protocol")

-- STATUS report fields
st = ProtoField.bytes("br24-report.st", "status", base.SPACE)

-- SETTINGS report fields
range         = ProtoField.uint16("br24-report.range", "range", base.DEC)
gain_auto     = ProtoField.bytes("br24-report.gain_auto", "gain auto", base.SPACE)
gain          = ProtoField.uint8("br24-report.gain", "gain", base.DEC)
sea_auto      = ProtoField.bytes("br24-report.sea_auto", "sea-auto", base.SPACE)
sea_state     = ProtoField.uint8("br24-report.sea_state", "sea-state (sea clutter)", base.DEC)
rain          = ProtoField.uint8("br24-report.rain", "rain clutter", base.DEC)
if_rej        = ProtoField.bytes("br24-report.if_rej", "interference rejection", base.SPACE)
target_exp    = ProtoField.bytes("br24-report.target_exp", "target expansion", base.SPACE)
target_boost  = ProtoField.bytes("br24-report.target_boost", "target boost", base.SPACE)

-- FIRMWARE report fields
radar_type    = ProtoField.bytes("br24-report.radar_type", "radar type", base.SPACE)
firmware_date = ProtoField.bytes("br24-report.firmware_date", "firmware date", base.SPACE)
firmware_time = ProtoField.bytes("br24-report.firmware_time", "firmware time", base.SPACE)

-- BEARING report fields
bearing_alignment = ProtoField.bytes("br24-report.bearing_alignment", "bearing alignment", base.SPACE)
antenna = ProtoField.uint32("br24-report.antenna", "antenna height", base.DEC)

-- SCAN report fields
local_ifrej = ProtoField.bytes("br24-report.local_ifrej", "local interference rejection", base.SPACE)
scan_speed = ProtoField.bytes("br24-report.scan_speed", "scan speed", base.SPACE)
sls_auto = ProtoField.bytes("br24-report.sls_auto", "side lobe supression auto", base.SPACE)
sls = ProtoField.bytes("br24-report.sls", "side lobe supression value")
noise_rej = ProtoField.bytes("br24-report.noise_rej", "noise rejection", base.SPACE)
target_sep = ProtoField.bytes("br24-report.target_sep", "target separation", base.SPACE)


BR24_REPORT.fields = {st, range, gain, sea_auto, sea_state, rain, radar_type, firmware_date, firmware_time,
                               bearing_alignment, local_ifrej, scan_speed, sls_auto, sls, noise_rej, target_sep,
                               antenna, gain_auto, if_rej, target_exp, target_boost}

-- according to radarpi, the types seen on a BR24 are:
--
-- 2nd byte C4:   01 02 03 04 05 07 08
-- 2nd byte F5:   08 0C 0D 0F 10 11 12 13 14

REP_STATUS = "\01\196"      -- 0x01 0xC4 packet of length 18
REP_SETTINGS = "\02\196"    -- 0x02 0xC4 packet of length 99
REP_FIRMWARE = "\03\196"    -- 0x03 0xC4 packet of length 129
REP_BEARING = "\04\196"     -- 0x04 0xC4 packet of length 66
-- 05 07 (and 06?) are seen during bootup of the radar, but undocumented for now
-- 05 is also seen during normal operation along with the other reports
REP_SCAN = "\08\196"        -- 0x08 0xC4 packet of length 18

function decode_br24_str(string)

    local res = ""
    for char in string:gmatch"." do
        if char ~= "\00" then
            res = res .. char
        end
    end

    return res

end

function BR24_REPORT.dissector(buffer, pinfo, tree)

    length = buffer:len()
    if length == 0 then return end

    if pinfo.dst ~= Address.ip("236.6.7.9") and pinfo.dst ~= Address.ip("127.0.0.1") then return end

    local report_type_str = "Unknown"

    local report_type = buffer(0, 2):bytes():raw(0, 2)
    if report_type == REP_STATUS then
        report_type_str = "STATUS (0x01C4)"
    elseif  report_type == REP_SETTINGS then
        report_type_str = "SETTINGS (0x02C4)"
    elseif  report_type == REP_FIRMWARE then
        report_type_str = "FIRMWARE (0x03C4)"
    elseif  report_type == REP_BEARING then
        report_type_str = "BEARING (0x04C4)"
    elseif  report_type == REP_SCAN then
        report_type_str = "SCAN (0x08C4)"
    end

    pinfo.cols.protocol = BR24_REPORT.name .. " - " .. report_type_str

    local report_tree = tree:add(BR24_REPORT, buffer(), "Navico BR24 Report " .. report_type_str)

    -- fields need to be added on a case-by-case basis depending on report type

    if report_type == REP_STATUS then

        local radar_status = "Unknown"
        local radar_status_code = buffer(2, 1):bytes():raw(0, 1)
        if radar_status_code == "\01" then radar_status = "STANDBY"
        elseif radar_status_code == "\02" then radar_status = "TRANSMIT"
        elseif radar_status_code == "\05" then radar_status = "WAKEUP"
        end

        report_tree:add(st, buffer(2, 1)):append_text(" (" .. radar_status .. ")")

    elseif report_type == REP_SETTINGS then

        report_tree:add_le(range, buffer(2, 2)):append_text(" dm")
        report_tree:add(gain_auto, buffer(8, 1)):append_text(" (" .. parse_gain_auto(buffer(8, 1):bytes():raw(0, 1)) .. ")")
        report_tree:add(gain, buffer(12, 1)):append_text(" (" .. parse_percentage(buffer(12, 1):uint()) .. ")")
        report_tree:add(sea_auto, buffer(13, 1)):append_text(" (" .. parse_sea_clutter_auto(buffer(13, 1):bytes():raw(0, 1)) .. ")")
        report_tree:add(sea_state, buffer(17, 1)):append_text(" (" .. parse_percentage(buffer(17, 1):uint()) .. ")")
        report_tree:add(rain, buffer(22, 1)):append_text(" (" .. parse_percentage(buffer(22, 1):uint()) .. ")")
        report_tree:add(if_rej, buffer(34, 1)):append_text(" (" .. parse_if_rej(buffer(34, 1):bytes():raw(0, 1)) .. ")")
        report_tree:add(target_exp, buffer(38, 1))
        report_tree:add(target_boost, buffer(42, 1)):append_text(" (" .. parse_target_boost(buffer(42, 1):bytes():raw()) .. ")")

    elseif report_type == REP_FIRMWARE then


        report_tree:add(radar_type, buffer(2, 1)):append_text(" (" .. parse_radar_type(buffer(2, 1):bytes():raw()) .. ")")
        report_tree:add(firmware_date, buffer(58, 32)):append_text(" (" .. decode_br24_str(buffer(58, 32):bytes():raw(0, 32)) .. ")")

        report_tree:add(firmware_time, buffer(90, 32)):append_text(" (" .. decode_br24_str(buffer(90, 32):bytes():raw(0, 32)) .. ")")

    elseif report_type == REP_BEARING then

        local bearing_alignment_field = buffer(6,2):bytes()
        local bearing_alignment_val = bearing_alignment_field:get_index(0) + bit.lshift(bearing_alignment_field:get_index(1), 8)
        bearing_alignment_val = bearing_alignment_val / 10
        if bearing_alignment_val > 180 then
            bearing_alignment_val = bearing_alignment_val - 360
        end
        report_tree:add(bearing_alignment, buffer(6,2)):append_text(" (" .. bearing_alignment_val .. ")")
        report_tree:add_le(antenna, buffer(10, 4)):append_text(" mm")

    elseif report_type == REP_SCAN then
        report_tree:add(local_ifrej, buffer(3, 1)):append_text(" (" .. parse_loc_if_rej(buffer(3, 1):bytes():raw(0, 1)) .. ")")
        report_tree:add(scan_speed, buffer(4, 1)):append_text(" (" .. parse_scan_speed(buffer(4, 1):bytes():raw(0, 1)) .. ")")
        report_tree:add(sls_auto, buffer(5, 1))
        report_tree:add(sls, buffer(9, 1))
        report_tree:add(noise_rej, buffer(12, 1))
        report_tree:add(target_sep, buffer(13, 1))
    end

end

return BR24_REPORT
