--[[SMODS.Joker {
	key = 'test1',
	config = { extra = { mult = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	rarity = 1,
	atlas = 'placeholder',
	pos = { x = 0, y = 0 },
	cost = 0,
	update = function(self, card, dt)
		
	end
}]]

SMODS.Joker {
	key = 'curator',
	config = { extra = { mult = 0 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "hypr_placeholder" }
		return { vars = { card.ability.extra.mult } }
	end,
	rarity = 1,
	atlas = 'jokers',
	pos = { x = 4, y = 0 },
	cost = 0,
	update = function(self, card, dt)
		if not(G.SETTINGS.paused) and card.edition == nil then card:set_edition(poll_edition('curator', nil, nil, true)) end
	end
}

SMODS.Joker {
	key = 'creacher',
	config = { extra = { low = 0.9, high = 1.33 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "hypr_placeholder" }
		return { vars = { card.ability.extra.low, card.ability.extra.high } }
	end,
	rarity = 2,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = 'jokers',
	pos = { x = 2, y = 0 },
	cost = 5,
	calculate = function(self, card, context)
		if cmp(card.ability.extra.low,card.ability.extra.high) == 1 then -- this is for if cryptid or smth messes with the values
			local temp = card.ability.extra.low
			card.ability.extra.low = card.ability.extra.high
			card.ability.extra.high = temp
		end
		if (context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:is_suit("Clubs")) or context.forcetrigger then
			local random_seed = card.randomseed or "creacher"
			random_seed = (G.GAME and G.GAME.pseudorandom.seed or "") .. random_seed
			local factor = pseudorandom(pseudoseed(random_seed))
			return {
				xmult = card.ability.extra.low + (factor * (card.ability.extra.high-card.ability.extra.low))
			}
		end
	end
}

--[[SMODS.Joker {
	key = 'thcief',
	config = { extra = { hypr_thcief = true } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "hypr_placeholder" }
		return { vars = { card.ability.extra.a } }
	end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 3, y = 0 },
	cost = 5,
	set_ability = function(self, card, initial, delay_sprites)	
		card.ability.eternal = true
	end
}
function hypr_thcief_call()
	for i,card in ipairs(G.jokers) do 
		if card.ability.extra.hypr_thcief then return true end
	end
end]]

SMODS.Joker {
	key = 'hypa',
	config = { extra = { a = 1.4, seven_tally = 0, guh = 3.8} },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "hypr_guest_art", vars = {"baltdev (GitHub)"} }
		return { vars = { card.ability.extra.seven_tally, card.ability.extra.a, card.ability.extra.guh } }
	end,
	rarity = 4,
	atlas = 'jokers',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	cost = 20,
	calculate = function(self, card, context)
		if card.ability.seven_tally then card.ability.extra.guh = (card.ability.extra.a)^card.ability.seven_tally end
		if not context.joker_main then
			card.ability.seven_tally = 0
			for k, v in pairs(G.playing_cards) do
				if v:get_id() == 7 then card.ability.seven_tally = card.ability.seven_tally+1 end
			end
		elseif context.joker_main or context.forcetrigger then
			return {
				xmult = card.ability.extra.guh
			}
		end
	end
}
