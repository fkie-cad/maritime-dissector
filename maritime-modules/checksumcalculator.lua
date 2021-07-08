-- prevent wireshark loading this file as plugin
if not _G['maritimedissector'] then return end

local checksum_calculator = {}

function checksum_calculator:bit_xor(a,b)
    local p,c=1,0
    while a>0 and b>0 do
        local ra,rb=a%2,b%2
        if ra~=rb then c=c+p end
        a,b,p=(a-ra)/2,(b-rb)/2,p*2
    end
    if a<b then a=b end
    while a>0 do
        local ra=a%2
        if ra>0 then c=c+p end
        a,p=(a-ra)/2,p*2
    end
    return c
end

function checksum_calculator:calc_checksum(msg)
    local chksm = 0
    for c in msg:gmatch(".") do
        chksm = checksum_calculator:bit_xor(chksm, string.byte(c))
    end
    chksm = string.format("%02x", chksm):upper()
    return chksm
end

return checksum_calculator