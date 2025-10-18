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

local pokerhandinforef = G.FUNCS.get_poker_hand_info
function G.FUNCS.get_poker_hand_info(_cards)
	local text, loc_disp_text, poker_hands, scoring_hand, disp_text = pokerhandinforef(_cards)
	if #scoring_hand and #get_X_same(2,scoring_hand)==3 then
		disp_text = "hypr-Three Pair"
		loc_disp_text = localize(disp_text, "poker_hands")
	end
	return text, loc_disp_text, poker_hands, scoring_hand, disp_text
end

if JokerDisplay then
	local jokerdispcjt = JokerDisplay.calculate_joker_triggers
	function JokerDisplay.calculate_joker_triggers(card)
		local evaltriggers = jokerdispcjt(card)
		if card.ability.hypr_fakeRed then evaltriggers = evaltriggers+1 end
		return evaltriggers
	end 
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