if not _G["br24-dissector"] then return end

BR24_IMG = Proto("NavicoBR24-IMG", "Navico BR24 RADAR image protocol")

-- fields definitions
-- header fields
msg_marker = ProtoField.bytes("br24-img.msgstart", "Message start marker", base.SPACE)
ns         = ProtoField.uint8("br24-img.ns", "Number of scan lines", base.DEC)
ss         = ProtoField.uint16("br24-img.ss", "Size of scan line", base.DEC)
-- scanline header fields
l          = ProtoField.uint8("br24-img.l", "Length of scan line header", base.DEC)
st         = ProtoField.bytes("br24-img.st", "Status", base.SPACE)
rc         = ProtoField.uint16("br24-img.rc", "Raw scan line counter", base.DEC)
st_unknown = ProtoField.bytes("br24-img.st_unknown", "Static unknown", base.SPACE)
v_unknown  = ProtoField.bytes("br24-img.st_unknown", "Variable unknown", base.SPACE)
a          = ProtoField.uint16("br24-img.a", "Absolute angle", base.DEC)
heading    = ProtoField.uint16("br24-img.heading", "Heading", base.DEC)
scale      = ProtoField.uint16("br24-img.scale", "Scale of the scan radius", base.DEC)

-- scanline data field
pixels     = ProtoField.bytes("br24-img.pixels", "Scanline pixels", base.SPACE)


BR24_IMG.fields = {msg_marker, ns, ss, l, st, rc, st_unknown, a, v_unknown, scale, pixels, heading}

function get_st_code(stcode)

    local st_name = "Unknown"

    if stcode == "\02" then st_name = "VALID DATA"
    elseif stcode == "\24" then st_name = "STARTUP" --0x18 is \24
    end
    return st_name
end

function BR24_IMG.dissector(buffer, pinfo, tree)
    length = buffer:len()
    if length == 0 then return end

    if pinfo.dst ~= Address.ip("236.6.7.8") and pinfo.dst ~= Address.ip("127.0.0.1") then return end

    pinfo.cols.protocol = BR24_IMG.name

    -- tree structure
    local subtree = tree:add(BR24_IMG, buffer(), "Navico BR24 Image Data")
    local header_subtree = subtree:add(BR24_IMG, buffer(), "Frame Header")

    local scanlines_subtree = subtree:add(BR24_IMG, buffer(), "Scanlines")

    -- add header fields
    header_subtree:add(msg_marker, buffer(0,5))
    header_subtree:add(ns, buffer(5,1))
    header_subtree:add_le(ss, buffer(6,2))


    local offset = 0
    for i=0, 31, 1
    do
        local scanline_tree = scanlines_subtree:add(BR24_IMG, buffer(), "Scanline " .. i+1)
        local scanline_header_subtree = scanline_tree:add(BR24_IMG, buffer(), "Scanline Header")
        local scanline = scanline_tree:add(BR24_IMG, buffer(), "Scanline")

        -- add scanline header fields
        scanline_header_subtree:add(l, buffer(offset+8, 1))

        local status = buffer(offset+9, 1):bytes():raw(0, 1)
        local st_code = get_st_code(status)
        scanline_header_subtree:add(st, buffer(offset+9, 1)):append_text(" (" .. st_code .. ")")

        scanline_header_subtree:add_le(rc, buffer(offset+10, 2))
        scanline_header_subtree:add_le(a, buffer(offset+16, 2))
        scanline_header_subtree:add_le(heading, buffer(offset+18, 2))
        scanline_header_subtree:add_le(scale, buffer(offset+20, 3))

        scanline_header_subtree:add(v_unknown, buffer(offset+26, 2))
        scanline_header_subtree:add(v_unknown, buffer(offset+31, 1))

        scanline:add(pixels, buffer(offset+32, 512))

        -- increase offset by scanline header and scanline length. These values should
        -- always be the same
        offset = offset + 24 + 512
    end

end

return BR24_IMG
