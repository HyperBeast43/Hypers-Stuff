local smcmb = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
	smcmb(obj, badges)
	if obj then if obj.original_mod==SMODS.find_mod('hypa')[1] then 
		for i = 1, #badges do
			if badges[i].nodes[1].nodes[2].config.object.string == SMODS.find_mod('hypa')[1].display_name then
				--i wanna do smth here but idk what
			end
		end
	end end
end

--[[local insrep = SMODS.insert_repetitions
SMODS.insert_repetitions = function(ret, eval, effect_card, _type)
    if eval == nil then goto allow end
	print("ret", ret)
	print("eval", eval)
	if eval then for k,v in pairs(eval) do print("eval",k,v) end end
	print("effect_card", effect_card)
	print("effect_card type", type(effect_card))
	print("effect_card keys", effect_card and effect_card.key)
	print("_type", _type)
    if effect_card then
		if eval.jeracard then end
        if not((effect_card.label or nil)=="j_hypr_jera") and (eval.jeracard and eval.jeracard:is_suit("Hearts")) then
            return -- Block this repetition!
        end
    end

    -- Otherwise, allow as normal
	::allow::
    return insrep(ret, eval, effect_card, _type)
end
]]