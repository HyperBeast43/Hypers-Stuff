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

local gencardui = generate_card_ui
function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end)
	_c.loc_vars = _c.loc_vars or function(_,_,_) return {vars=specific_vars} end
	return gencardui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end)
end

G.hypr.scaletest=.1

SMODS.DrawStep:take_ownership('stickers', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	func = function(self, layer)
		local lscpscale = (self.config.center_key=='j_hypr_widescreen') and G.hypr.scaletest
        if self.sticker and G.shared_stickers[self.sticker] then
            G.shared_stickers[self.sticker].role.draw_major = self
            G.shared_stickers[self.sticker]:draw_shader('dissolve', nil, nil, nil, self.children.center)
            G.shared_stickers[self.sticker]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center)
        elseif (self.sticker_run and G.shared_stickers[self.sticker_run]) and G.SETTINGS.run_stake_stickers then
            G.shared_stickers[self.sticker_run].role.draw_major = self
            G.shared_stickers[self.sticker_run]:draw_shader('dissolve', nil, nil, nil, self.children.center, lscpscale)
            G.shared_stickers[self.sticker_run]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center, lscpscale)
        end
		
        for k, v in pairs(SMODS.Stickers) do
            if self.ability[v.key] then
                if v and v.draw and type(v.draw) == 'function' then
                    v:draw(self, layer, nil, nil, nil, lscpscale)
                else
                    G.shared_stickers[v.key].role.draw_major = self
                    G.shared_stickers[v.key]:draw_shader('dissolve', nil, nil, nil, self.children.center, lscpscale)
                    G.shared_stickers[v.key]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center, lscpscale)
                end
            end
        end
    end,
    },
    true -- silent | suppresses mod badge
)

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