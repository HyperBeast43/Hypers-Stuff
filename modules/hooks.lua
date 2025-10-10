local calrep
SMODS.calculate_repetitions = function(card, context, reps)
    if card:is_suit("Hearts") and next(SMODS.find_card("j_hypr_jera")) then
		if context.repetition_only then return end -- cancels retriggers from non-jokers
        --...now what
    end 
	