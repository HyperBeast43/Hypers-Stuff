function where(t, thing)
	if not t then return end
	for k, v in ipairs(t) do
		if v == thing then
			return k
		end
	end
end

function tablepeek(table)
	local ret = ''
	for k,_ in pairs(table) do
		ret = ret..','..k
	end
	return string.sub(ret,2,-1)
end

function cmp(a, b)
    local ta, tb = type(a), type(b)
	if not Talisman then goto notalisman end
    if tb == "table" then return -cmp(b, a) end
    if ta == "table" then
        -- BigNum
        if a.compare then return a:compare(b) end
        -- OmegaNum
        if a.compareTo then return a:compareTo(b) end
        error("unsupported number representation for " .. a .. " - must be either float, BigNum, or OmegaNum")
    end
	::notalisman::
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

function blend(a, b, weight) -- from WOKElatro
	weight = weight or 0.5
	return {
		a[1]*(1-weight)+b[1]*weight,
		a[2]*(1-weight)+b[2]*weight,
		a[3]*(1-weight)+b[3]*weight,
		a[4]*(1-weight)+b[4]*weight
	}
end