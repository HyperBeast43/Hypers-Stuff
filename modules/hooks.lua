local insrep = SMODS.insert_repetitions
SMODS.insert_repetitions = function(ret, eval, effect_card, _type)
    local storedeval = eval
    local jera = next(SMODS.find_card("j_hypr_jera"))

    local tempeval = eval
    local wrongguy = true
	
    for tk, tv in pairs(tempeval) do
		if type(tv)=="table" and tv.jeracheck or not(tk=="jeracard" and --[[not]] tv:is_suit("Hearts")) then 
		--[[depending on if i have the not there, it allows outside repititions..on all suits. god damn you]]
			wrongguy = false
			break
		end
    end
	
    if wrongguy then
        return 
    end

    if not jera then
        return insrep(ret, tempeval, effect_card, _type)
    end

    local repetitions = 1
    if eval and eval.repetitions then
        repetitions = eval.repetitions
    end

    for i = 1, repetitions do
        local effect = {}
        for k, v in pairs(eval) do
            if k ~= 'extra' then effect[k] = v end
        end
        effect.card = effect_card
        effect.message = localize('k_again_ex')
        table.insert(ret, _type == "joker_retrigger" and effect or { retriggers = effect })
    end

end