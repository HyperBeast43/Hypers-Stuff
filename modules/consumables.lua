SMODS.Consumable {
	key = 'recursion',
	set = 'Spectral',
	atlas = 'cards',
	pos = { x = 2, y = 3 },
	config = { extra = { seal = 'Red'}, discard_cut = 1},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
		return { vars = { self.config.discard_cut } }
	end,
	can_use = function(self, card) 
		if G.GAME.starting_params.discard_limit<self.config.discard_cut then return end 
		for _,v in pairs(G.jokers.cards) do
			if not v.ability.hypr_fakeRed then return true end
		end
	end,
	use = function(self, card, area, copier)
		local availablejokers = {}
		for _,v in pairs(G.jokers.cards) do
			if not v.ability.hypr_fakeRed then availablejokers[#availablejokers+1]=v end
		end
		if availablejokers then 
			local conv_card = pseudorandom_element(availablejokers)
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound('tarot1')
					return true
				end
			}))
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					conv_card.ability.hypr_fakeRed = true
					card:juice_up(0.4, 0.3)
					play_sound('gold_seal', 1.2, 0.4) -- the seal sound is called that because only gold seals existed in the demo
					assert(type(self.config.discard_cut)=='number',"damn you talisman (type(self.config.discard_cut)~='number')")
					SMODS.change_discard_limit(-1*self.config.discard_cut)
					return true
				end
			}))
		end
	end
}

SMODS.Sticker {
	key = 'fakeRed',
	should_apply = false, --dont show up naturally
	atlas = 'cards',
	no_collection = true,
	no_sticker_sheet = true, -- cryptid
	pos = { x = 3, y = 3 },
	sets = {},
	config = {},
	badge_colour = G.C.RED,
	calculate = function(self, card, context)
		if context.retrigger_joker_check and context.other_card==card then
			return {repetitions = 1, message = localize('k_again_ex')}
		end
	end,
	draw = function(self, card) -- thank you metanite64 from the cryptid discord
		G.shared_stickers[self.key].role.draw_major = card
		G.shared_stickers[self.key]:draw_shader('dissolve', nil, nil, nil, card.children.center)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = 1, key = "red_seal" }
	end
}

