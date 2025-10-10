local insrep = SMODS.insert_repetitions
SMODS.insert_repetitions = function(ret, eval, effect_card, _type)
	local storedeval = eval
	local dothething = next(SMODS.find_card("j_hypr_jera"))
	local wrongguy = false
	if not dothething then return insrep(ret, eval, effect_card, _type) end
    repeat
        eval.repetitions = eval.repetitions or 0
        local effect = {}
        for k,v in pairs(eval) do
			print(k,v)
            if k ~= 'extra' then 
				effect[k] = v
			end
        end
		if effect.jeracard then
			if not effect.jeracard:is_suit("Hearts") then --abort
				wrongguy = true
				sendWarnMessage("We got the wrong guy!")
				break
			end
			effect.card = effect_card
			effect.message = localize('k_again_ex')
			table.insert(ret, _type == "joker_retrigger" and effect or { retriggers = effect})
		end
        eval = eval.extra
    until not eval
	if wrongguy then return insrep(ret, storedeval, effect_card) end
end