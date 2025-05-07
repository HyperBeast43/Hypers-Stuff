--[[SMODS.Joker {
	key = 'test1',
	loc_txt = {
		name = 'Test Joker',
		text = {
			"{C:mult}+#1# {} Mult"
		}
	},
	config = { extra = { mult = 7 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	rarity = 1,
	atlas = 'placeholder',
	pos = { x = 0, y = 0 },
	cost = 1,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult_mod = card.ability.extra.mult,
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
			}
		end
	end
}]]

SMODS.Joker {
	key = 'creacher',
	loc_txt = {
		name = 'Creature Feature',
		text = {
			"{C:clubs}Clubs{} held in hand give",
			"a random value from",
			"{X:mult,C:white}X#1#{} up to {X:mult,C:white}X#2#{} Mult"
		}
	},
	config = { extra = { low = 0.9, high = 1.33 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.low, card.ability.extra.high } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 2, y = 0 },
	cost = 5,
	calculate = function(self, card, context)
		if cmp(card.ability.extra.low,card.ability.extra.high) == 1 then -- this is for if cryptid or smth messes with the values
			local temp = card.ability.extra.low
			card.ability.extra.low = card.ability.extra.high
			card.ability.extra.high = temp
		end
		if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:is_suit("Clubs") then
			local random_seed = card.randomseed or "creacher"
			random_seed = (G.GAME and G.GAME.pseudorandom.seed or "") .. random_seed
			local factor = pseudorandom(pseudoseed(random_seed))
			return {
				xmult = card.ability.extra.low + (factor * (card.ability.extra.high-card.ability.extra.low))
			}
		end
	end
}
--[[
SMODS.Joker {
	key = 'thcief',
	loc_txt = {
		name = 'Five-Finger Discount',
		text = {
			"Everything is {C:attention,E:1}free{}, but",
			"{C:green}rerolls{} are {C:red}disabled{}" -- always eternal
		}
	},
	config = { extra = { a = true } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.a } }
	end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 3, y = 0 },
	cost = 5,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				
			}
		end
	end
}
]]

SMODS.Joker {
	key = 'hypa',
	loc_txt = {
		name = 'Hyper',
		text = {
			"Every {C:attention}7{} in your",
			"{C:attention}full deck{} gives {X:mult,C:white}X-#2#{} Mult",
			"{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)"
		}
	},
	config = { extra = { a = 1.5, seven_tally = 0, guh = 5.0625} },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.seven_tally, card.ability.extra.a, card.ability.extra.guh } }
	end,
	rarity = 4,
	atlas = 'jokers',
	blueprint_compat = true,
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	cost = 40,
	calculate = function(self, card, context)
		if card.ability.seven_tally then card.ability.extra.guh = (-card.ability.extra.a)^card.ability.seven_tally end
		if not context.joker_main then
			card.ability.seven_tally = 0
			for k, v in pairs(G.playing_cards) do
				if v:get_id() == 7 then card.ability.seven_tally = card.ability.seven_tally+1 end
			end
		elseif not context.end_of_round then
			return {
				xmult = card.ability.extra.guh
			}
		end
	end
}
