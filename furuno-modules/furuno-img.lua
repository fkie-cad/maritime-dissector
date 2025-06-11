if not _G["furuno-dissector"] then return end

FURUNO_IMG = Proto("Furuno-IMG", "Furuno RADAR image protocol")

msg_type = ProtoField.bytes("furuno-img.msg_type", "Type", base.SPACE)
seq_number = ProtoField.uint8("furuno-img.seq_number", "Seq. Number", base.DEC)
furuno_marker = ProtoField.bytes("furuno-img.furuno_marker", "Furuno Marker", base.SPACE)
size = ProtoField.uint16("furuno-img.size", "Length (per 4 Byte)", base.DEC_HEX, NULL, 0x01ff, "Given in 4 Byte blocks")
spoke_cnt = ProtoField.uint8("furuno-img.spoke_cnt", "Number of Spokes", base.DEC_HEX, NULL, 0xfe)
cell_cnt = ProtoField.uint16("furuno-img.cell_cnt", "Number of Range Cells", base.DEC, NULL, 0x07ff)
compr_lvl = ProtoField.uint8("furuno-img.compr_lvl", "Compression Level", base.DEC, NULL, 0x18)
uk_1 = ProtoField.uint8("furuno-img.uk_1", "Unknown 1", base.DEC_HEX, NULL, 0xe0)
range = ProtoField.uint8("furuno-img.range", "Range", base.DEC, NULL)
ace = ProtoField.bool("furuno-img.ace", "ACE", 8, {"On", "Off"}, 0x01, "Automatic Clutter Elimination")
uk_2 = ProtoField.uint16("furuno-img.uk_2", "Unknown 2", base.HEX, NULL, 0xfff)
head_flag = ProtoField.uint8("furuno-img.heading_flag", "Heading Flag", base.DEC, NULL, 0x30)
uk_3 = ProtoField.uint8("furuno-img.uk_3", "Unknown 3", base.HEX, NULL, 0xc0, "Has something to do with the buffer used in decoding/inflating")
az = ProtoField.uint16("furuno-img.azimuth", "Azimuth", base.DEC_HEX, NULL)
heading = ProtoField.uint16("furuno-img.heading", "Heading", base.HEX, NULL)
encoded_data = ProtoField.bytes("furuno-img.encoded_data", "Encoded Echo Strengths", base.SPACE)
azs = ProtoField.string("furuno-img.azimuth_list", "Azimuths in Spokes")
headings = ProtoField.string("furuno-img.heading_list", "Headings in Spokes")

FURUNO_IMG.fields = {msg_type, seq_number, furuno_marker, size, spoke_cnt, cell_cnt, compr_lvl, uk_1, range, ace, uk_2, head_flag, uk_3, az, heading, encoded_data, azs, headings}
FURUNO_IMG.prefs.split_spokes = Pref.bool("Split Spokes", false, "Split the Spokes into azimuth, heading and encoded echo data. Note that this increases RAM usage significantly.")

function FURUNO_IMG.dissector(buffer, pinfo, tree)
    local length = buffer:len()
    if length == 0 then return end

    pinfo.cols.protocol = FURUNO_IMG.name

    local subtree = tree:add(FURUNO_IMG, buffer(), "Furuno Image Data")

    subtree:add(msg_type, buffer(0, 1))
    subtree:add(seq_number, buffer(1, 1))
    subtree:add(furuno_marker, buffer(2, 6))

    subtree:add_le(size, buffer(8, 2))                      -- XXXXXXXX .......X
    local spoke_cnt_val = (buffer(9, 1):uint() >> 1)
    subtree:add_le(spoke_cnt, buffer(9, 1))                 --          XXXXXXX.

    local cell_cnt_val = (buffer(10, 2):le_uint() & 0x7ff)
    subtree:add_le(cell_cnt, buffer(10, 2))                 -- XXXXXXXX .....XXX
    local compr_lvl_val = (buffer(11, 1):le_uint() & 0x18) >> 3
    subtree:add_le(compr_lvl, buffer(11, 1))                --          ...XX...
    subtree:add_le(uk_1, buffer(11, 1))                     --          XXX.....


    subtree:add_le(range, buffer(12, 1))                    -- 00XXXXXX

    subtree:add_le(ace, buffer(13, 1))                      -- .......X

    subtree:add_le(uk_2, buffer(14, 2))                     -- XXXXXXXX ....XXXX
    subtree:add_le(head_flag, buffer(15, 1))                --          ..XX....
    subtree:add_le(uk_3, buffer(15, 1))                     --          XX......

    local byte_ptr = 16
    local azimuth_list = ""
    local heading_list = ""
    if compr_lvl_val == 0 then
        -- no compression/encoding of echo data used
        for i=1, spoke_cnt_val, 1
        do
            if FURUNO_IMG.prefs.split_spokes then
                local spoke_data = subtree:add(FURUNO_IMG, buffer(byte_ptr, byte_ptr + cell_cnt_val), "Spoke Echo Data " .. i)
                spoke_data:add_le(az, buffer(byte_ptr, 2))            -- XXXXXXXX 000XXXXX
                byte_ptr = byte_ptr + 2
                spoke_data:add_le(heading, buffer(byte_ptr, 2))       -- XXXXXXXX 000XXXXX
                byte_ptr = byte_ptr + 2
                spoke_data:add(encoded_data, buffer(byte_ptr, cell_cnt_val))
            else
                azimuth_list = azimuth_list .. " " .. string.format("%04d", buffer(byte_ptr, 2):le_uint()) .. " "
                byte_ptr = byte_ptr + 2
                heading_list = heading_list .. " " .. string.format("%04d", buffer(byte_ptr, 2):le_uint()) .. " "
                byte_ptr = byte_ptr + 2
            end

            byte_ptr = byte_ptr + cell_cnt_val
        end

    elseif compr_lvl_val == 3 then
        -- Combination of Run-Length Encoding (RLE) and referencing to previous spoke used
        local byte_buffer = buffer():bytes()
        for i=1, spoke_cnt_val, 1
        do
            local ptr_cp = byte_ptr

            byte_ptr = byte_ptr + 4

            local byte_cnt = 0
            local cnt = 0
            while (cnt < cell_cnt_val)
            do
                local byte = byte_buffer:get_index(byte_ptr)
                byte_cnt = byte_cnt + 1
                if (byte & 3) > 0 then
                    -- reference or RLE
                    cnt = cnt + (byte >> 2)
                else
                    -- no encoding
                    cnt = cnt + 1
                end
                byte_ptr = byte_ptr + 1
            end

            if byte_cnt % 4 ~= 0 then
                for j=1,(4 - (byte_cnt % 4)),1
                do
                    byte_ptr = byte_ptr + 1
                    byte_cnt = byte_cnt + 1
                end
            end

            if FURUNO_IMG.prefs.split_spokes then
                local spoke_data = subtree:add(FURUNO_IMG, buffer(ptr_cp, byte_cnt + 4), "Spoke Echo Data " .. i)
                spoke_data:add_le(az, buffer(ptr_cp, 2))            -- XXXXXXXX 000XXXXX
                ptr_cp = ptr_cp + 2
                spoke_data:add_le(heading, buffer(ptr_cp, 2))       -- XXXXXXXX 000XXXXX
                ptr_cp = ptr_cp + 2
                spoke_data:add(encoded_data, buffer(ptr_cp, byte_cnt))
            else
                azimuth_list = azimuth_list .. " " .. string.format("%04d", buffer(ptr_cp, 2):le_uint()) .. " "
                ptr_cp = ptr_cp + 2
                heading_list = heading_list .. " " .. string.format("%04d", buffer(ptr_cp, 2):le_uint()) .. " "
                ptr_cp = ptr_cp + 2
            end

        end

        if not FURUNO_IMG.prefs.split_spokes then
            subtree:add(azs, buffer(16, length - 16), azimuth_list)
            subtree:add(headings, buffer(16, length - 16), heading_list)
        end
    end

end

return FURUNO_IMG
