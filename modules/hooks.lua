local calrep = SMODS.calculate_repetitions 
SMODS.calculate_repetitions = function(card, context, reps) -- original function at https://github.com/Steamodded/smods/blob/ce1d61c4d49c3288c1f4b13e75ba021f32363a67/src/utils.lua#L1505
    if card:is_suit("Hearts") and next(SMODS.find_card("j_hypr_jera")) then
		if context.repetition_only then return end -- cancels retriggers from non-jokers
        --...now how do i cancel retriggers from jokers that aren't hypr_jera
    else return calrep
    end 
	