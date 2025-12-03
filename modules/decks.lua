SMODS.Back {
	key = "solar",
	atlas = 'cards', pos = { x = 0, y = 0 },
	check_for_unlock = function (self, args)
		return G.GAME.starting_params.discard_limit<=0
	end,
	unlocked = false,
	apply = function (self, back)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.7,
			func = function()
				SMODS.change_play_limit(1)
				SMODS.change_discard_limit(-1)
				return true
			end,
		}))
	end
}
if SMODS.find_mod('CardSleeves')[1]~=nil then
CardSleeves.Sleeve {
	key = "solar",
	name = "Solar Sleeve",
	atlas = "sleeves",
	pos = { x = 0, y = 0 },
	config = {},
	unlocked = false,
	unlock_condition = { deck = "b_hypr_solar", stake = "stake_red" },
	apply = function (self, back)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.7,
			func = function()
				SMODS.change_play_limit(1)
				SMODS.change_discard_limit(-1)
				return true
			end,
		}))
	end
} end