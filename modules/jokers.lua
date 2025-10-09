SMODS.Joker {
	key = 'test',
	config = { extra = { xmult = math.pi } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
	end,
	rarity = 1,
	atlas = 'placeholder',
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 0, y = 0 },
	cost = math.exp(1),
	update = function(self,card,dt)
		if card.ability.extra.mult ~= math.pi then card.ability.extra.mult = math.pi end
	end,
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then return {xmult = card.ability.extra.xmult} end
	end,
	joker_display_def = function(JokerDisplay)
        ---@type JDJokerDefinition
        return {
            text = {
				text = "wawa"
			}
        }
    end
}

--[[SMODS.Joker {
	key = 'ijh',
	config = { extra = { copied = nil } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "hypr_placeholder" }
		return { vars = { card.ability.extra.copied } }
	end,
	blueprint_compat = true
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 5, y = 0 },
	cost = 10,
	function pickfrombuffoonpack ()
		--what to do...
	end
	
	calculate = function(self, card, context)
		if context.ending_shop or card.ability.extra.copied == nil then
		{
		card.ability.extra.copied = pickfrombuffoonpack()
		}
	end
	-- and now to figure out how blueprint/brainstorm copy jokers
}
]]--
SMODS.Joker {
	key = 'curator',
	config = { extra = { mult = 0 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "hypr_placeholder" }
		return { vars = { card.ability.extra.mult } }
	end,
	rarity = 1,
	blueprint_compat = false,
	atlas = 'jokers',
	pos = { x = 4, y = 0 },
	cost = 1,
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
	end,
	joker_display_def = function(JokerDisplay) --todo: modify the display further so it's not just bloodstone
		---@type JDJokerDefinition
		return {
			text = {
				{ ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
				{ text = "x",                              scale = 0.35 },
				{
					border_nodes = {
						{ text = "X" },
						{ ref_table = "card.ability.extra", ref_value = "Xmult" }
					}
				}
			},
			reminder_text = {
				{ text = "(" },
				{ ref_table = "card.joker_display_values", ref_value = "localized_text", colour = lighten(G.C.SUITS["Clubs"], 0.35) },
				{ text = ")" }
			},
			extra = {
				{
					{ text = "(" },
					{ ref_table = "card.joker_display_values", ref_value = "odds" },
					{ text = ")" },
				}
			},
			extra_config = { colour = G.C.GREEN, scale = 0.3 },
			calc_function = function(card)
				local count = 0
				if G.play then
					local text, _, scoring_hand = JokerDisplay.evaluate_hand()
					if text ~= 'Unknown' then
						for _, scoring_card in pairs(scoring_hand) do
							if scoring_card:is_suit("Clubs") then
								count = count +
									JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
							end
						end
					end
				else
					count = 3
				end
				card.joker_display_values.count = count
				card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
				card.joker_display_values.localized_text = localize("Clubs", 'suits_plural')
			end
		}
	end
}

--[[SMODS.Joker {
	key = 'thcief',
	config = { extra = { hypr_thcief = true } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "hypr_placeholder" }
		return { vars = { card.ability.extra.a } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 3, y = 0 },
	cost = 5, --when bought, set cost to -100, thus sell price to -50
}
function hypr_thcief_call()
	for i,card in ipairs(G.jokers) do 
		if card.ability.extra.hypr_thcief then return true end
	end
end]]

SMODS.Joker {
	key = 'hypa',
	config = { extra = { a = 1.2, seven_tally = 0, guh = 2.1} },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "hypr_guest_art", vars = {"baltdev (GitHub)"} }
		return { vars = { card.ability.extra.seven_tally, card.ability.extra.a, card.ability.extra.guh } }
	end,
	locked_loc_vars = function(self, info_queue, card)
	return {
		vars = {
			localize("joker_locked_legendary"),
		},
	}
	end,
	unlock_condition = {type = '', extra = '', hidden = true},
	unlocked = false, discovered = false,
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
	end,

}

--[[SMODS.Joker {
	key = 'jera',
	config = {},
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 3, y = 0 },
	cost = 6,
	-- all hearts are retriggered exactly once
	update = function(self,card,context)
	
	end
	calculate = function(self, card, context)
	
	end
end
}

SMODS.Joker {
	key = 'bypass',
	config = { extra = {odds = 2}},
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.odds} }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 3, y = 0 },
	cost = 6,
	-- debuffed cards have a 2 in 7 chance to trigger anyway
	update = function(self,card,context)
	
	end
	calculate = function(self, card, context)
	
	end
end
}
]]