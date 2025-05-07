function cmp(a, b)
    local ta, tb = type(a), type(b)
    if tb == "table" then return -cmp(b, a) end
    if ta == "table" then
        -- BigNum
        if a.compare then return a:compare(b) end
        -- OmegaNum
        if a.compareTo then return a:compareTo(b) end
        error("unsupported number representation for " .. a .. " - must be either float, BigNum, or OmegaNum")
    end
    local diff = (a - b)
    return (diff == 0 and 0) or (math.abs(diff) / diff)
end

function count_if(t, predicate)
    local count = 0
    for _, value in pairs(t) do
        if predicate(value) then
            count = count + 1
        end
    end
    return count
end