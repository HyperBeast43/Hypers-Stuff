SMODS.Atlas {
	key = "cards",
	path = "cards.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "placeholder",
	path = "placeholder.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
    key = "sleeves",
    path = "sleeves.png",
    px = 73,
    py = 95
}

SMODS.DynaTextEffect {
    key = "shake",
    func = function (dynatext, index, letter) 
		letter.offset.y = 10*math.random()
		letter.offset.x = 10*math.random()
    end
}

SMODS.DynaTextEffect {
    key = "circle",
    func = function (dynatext, index, letter) 
		letter.offset.x = math.cos(G.TIMERS.REAL*2 + index/1.5)*3
		letter.offset.y = math.sin(G.TIMERS.REAL*2 + index/1.5)*3
    end
}

local clamp = function(x)
	if x<0 then return 0
	elseif x>1 then return 1 end
	return x
end

local psin = function(x)
	local modx = x % math.pi
    local s = 1
    if x % (2*math.pi) > math.pi then s = -1 end
    local y = 2*modx/math.pi - 1
    return (1 - y*y) * s
end

local clamplow = function(x)
	if x<0 then return 0 end
	return x
end

SMODS.DynaTextEffect {
    key = "2", --because bunco fucks with the kerning on this effect specifically, somehow because it loads its own font for the suit displays. no i dont know why this fixes it
    func = function (dynatext, k, letter)
		if G.SETTINGS.reduced_motion then return end
		letter.offset.y = dynatext.bump_amount*math.sqrt(dynatext.scale)*7*clamplow((5+dynatext.bump_rate)*math.sin(dynatext.bump_rate*G.TIMERS.REAL+200*k) - 3 - dynatext.bump_rate)
    end
}

SMODS.DynaTextEffect {
    key = "tremble",
    func = function (dynatext, index, letter) 
        letter.r = (math.random()-.5)/6
    end
}

--[[ this doesnt work because you can't set letter.char

local obfus =
{
['12.16']='.:!|il;',
['20.16']=']()j',
['36.16']='WwmM',
['32.32']='XxQ',
['24.32']='<>*',
['12.48']='\',',
['40.32']='&',
['28.16']='4SRTs7rt896YV=Z~_A$a%BDcbdGzHyg+FvuhqK-J5?nLk/ef^CO1U3IP0oN2Ep'
}

SMODS.DynaTextEffect {
    key = "obfuscate",
    func = function (dynatext, index, letter) 
		local letterpool = obfus[tostring(letter.dims.x)]
		if not letterpool then return end --assert(letterpool,'Tried to obfuscate an unrenderable character!')
		local randindex = math.floor(math.random()*string.len(letterpool))+1
		letter.char = string.sub(letterpool,randindex,randindex)
    end
}]]