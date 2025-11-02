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

function dblog(a) print(a); return a end

function ensure(v,typ)
	if not typ then return end
	if type(v)==typ then return v end
	if 
		typ=='boolean' then return not not v
		elseif typ=='number' then
			if type(v)=='boolean' then return (v and 1) or 0 
			elseif type(v)=='string' then return tonumber(v) and tonumber(v) or 0 
			elseif type(v)=='table' then 
				local i = 0
				for _,_ in pairs(v) do
					i = i+1
				end return i
			else goto invcast end
		elseif typ=='string' then return tostring(v) 
		elseif typ=='function' then return function() return v end 
	end
	::invcast::
	sendWarnMessage('WARN: ensure() called with invalid cast, returning nil!', 'Hyper\'s Stuff')
end