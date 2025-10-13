SMODS.Back {
	key = "solar",
	atlas = 'cards', pos = { x = 5, y = 0 },
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