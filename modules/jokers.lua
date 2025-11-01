local jkrs = {}

local function addjkr(joker)
	jkrs[#jkrs+1]=joker
end


--[[addjkr( {
	key = 'test',
	config = { extra = { xmult = math.pi } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
	end,
	rarity = 1,
	atlas = 'placeholder',
	blueprint_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
	eternal_compat = true,
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
				{
					border_nodes = {
						{ text = "X" },
						{ ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp"}
					}
				}
			}
		}
	end
})]]


addjkr( {
	key = 'curator',
	config = {},
	loc_vars = function(self, info_queue, card)
		return 
	end,
	rarity = 1,
	blueprint_compat = false,
	perishable_compat = false,
	demicoloncompat = true,
	eternal_compat = true,
	atlas = 'cards',
	pos = { x = 4, y = 0 },
	cost = 1,
	update = function(self, card, dt)
		if not(G.SETTINGS.paused) and card.edition == nil then	
			
			local bannededitions = {["e_cry_glitched"]=true,["e_cry_oversat"]=true,["e_cry_double_sided"]=true, ["e_cry_glass"]=card.ability.eternal, ["e_bunc_fluorescent"]=true} -- e_cry_blurred isnt banned because ://HOOK exists. also no need to check if Cryptid is installed because we're not actually referring to the editions we're referring to their ids
			local curatoredition = "nil"
			::retry::
			curatoredition = poll_edition('curator', nil, nil, true)
			if bannededitions[curatoredition] then 
				goto retry
			end
			card:set_edition(curatoredition)
		end
	end,
	calculate = function(self,card,context)
		if context.joker_main or context.forcetrigger then
			return {
				chips = 0, -- this is so editions that fire upon joker trigger do something, like cryptid's Golden
				remove_default_message = true
			}
		end
	end
})
if SMODS.find_mod('Talisman')[1] ~= nil then trimsci = function(s,b)
  local t = {}
  local i = 0
  local sci
  for chr in string.gmatch(s,".") do
	i = i+1 
	if i==2 and chr=="." and b==2 then b=1 end
	if chr == "e" then 
	  sci=true 
		local i2 = b
		while i2~=0 do
		  if t[i2]=="0" or t[i2]=="." then
			b = math.max(b-1,3)
			i2 = i2-1
		  else
			i2 = 0 
		  end
		end
	  break end
	t[i] = chr
  end
  if not sci and (not d or t[1]=="0") and i>b then
	return trimsci(string.format("%e", s),b)
  end
  s = string.sub(table.concat(t),1,b)..(((i ~= #s) and (string.sub(s,i))) or "")
  i = 0
  t = {}
  for chr in string.gmatch(s,".") do
	if chr ~= "+" and not (chr=="0" and (t[i]=="e" or t[i]=="-")) and not (chr=="." and s.sub(i+2,i+2)=="e") then
	  i = i+1
	  t[i]=chr
	end
  end
  return table.concat(t)
end end

addjkr( {
	key = 'creacher',
	config = { extra = { low = 0.9, high = 1.66666666666667 } },
	loc_vars = function(self, info_queue, card)
		table.insert(info_queue,{ set = "Other", key = "hypr_devart" })
		local c
		local suffix = ''
		if SMODS.find_mod('Bunco')[1] then 
			c = G.C.SUITS["bunc_Fleurons"] 
			table.insert(info_queue,{ set = "Other", key = "hypr_advantage" })
			suffix = '_exotic'
		else c = {.7,0,.7,1} end-- shouldnt show w/o bunco
		return { vars = { card.ability.extra.low, card.ability.extra.high }, colours = {unpack(c)}, key=self.key..suffix }
	end,
	rarity = 2,
	blueprint_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
	eternal_compat = true,
	atlas = 'cards',
	pos = { x = 2, y = 0 },
	cost = 5,
	calculate = function(self, card, context)
		local lo = card.ability.extra.low
		local hi = card.ability.extra.high
		if cmp(lo,hi) == 1 then -- this is for if cryptid or smth messes with the values
			local temp = lo
			lo = hi
			hi = temp
		end

		if (context.individual and context.cardarea == G.hand and not context.end_of_round) or context.forcetrigger then
			local random_seed = card.randomseed or "creacher"
			random_seed = (G.GAME and G.GAME.pseudorandom.seed or "") .. random_seed
			local factor = pseudorandom(pseudoseed(random_seed))
			if context.other_card then -- forcetrigger doesnt have context.other_card afaik
				if not (context.other_card:is_suit("Clubs") or context.other_card:is_suit("bunc_Fleurons")) then return end
				if context.other_card:is_suit("bunc_Fleurons") then
					factor = math.sqrt(factor) -- sqrt(rand) statistically equals max(rand,rand)
				end
			end
			return {
				xmult = lo + (factor * (hi-lo))
			}
		end
	end,
	joker_display_def = function(JokerDisplay) 
		---@type JDJokerDefinition
		local jdrem = {{ text = "(" }}
		table.insert(jdrem,{ text = localize("Clubs", 'suits_plural')})
		if SMODS.find_mod('Bunco')[1] then
			if BUNCOMOD.funcs.exotic_in_pool then
				table.insert(jdrem,{ text = ", "})
				table.insert(jdrem,{ text = localize("bunc_Fleurons", 'suits_plural')})
			end
		end
		table.insert(jdrem,{ text = ")" })
		return {
			text = {
				{ text = "~",colour=G.C.GREEN,scale = 0.35 },
				{
					border_nodes = {
						{ text = "X" },
						{ ref_table = "card.joker_display_values", ref_value = "ideal", retrigger_type = "exp"}
					}
				}
			},
			reminder_text = jdrem,
			extra = {
				{
					{ text = "(Precision: " },
					{ ref_table = "card.joker_display_values", ref_value = "precision"},
					{ text = "%)" }
				}
			},
			extra_config = { colour = G.C.GREEN, scale = 0.3 },
			calc_function = function(card)
				local lo = card.ability.extra.low
				local hi = card.ability.extra.high
				local playing_hand = next(G.play.cards)
				local count = 0
				local count2 = 0
				for _, playing_card in ipairs(G.hand.cards) do
					if playing_hand or not playing_card.highlighted then
						if not (playing_card.facing == 'back') and not playing_card.debuff and playing_card:get_id() then
							if playing_card:is_suit("Clubs") then
								count = count + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
							elseif playing_card:is_suit("bunc_Fleurons") then
								count2 = count2 + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
							end
						end
					end
				end
				card.joker_display_values.count = count*JokerDisplay.calculate_joker_triggers(card)
				card.joker_display_values.count2 = count2*JokerDisplay.calculate_joker_triggers(card)
				if SMODS.find_mod('Talisman')[1] ~= nil then
					lo = Big:ensureBig(lo)
					hi = Big:ensureBig(hi) 
					card.joker_display_values.ideal = OmegaMeta.__tostring(OmegaMeta.__pow((lo:add(hi):div(Big:create(2))),Big:ensureBig(count)):mul(OmegaMeta.__pow(hi,Big:ensureBig(count2))))
					card.joker_display_values.precision = trimsci(OmegaMeta.__tostring(Big:create(100):mul(
						(
							Big:create(B.E):pow(
								hi:mul(hi:ln())
								  :sub(lo:mul(lo:ln()))
								  :sub(hi:sub(lo))
								  :div(hi:sub(lo))
							)
							:div(
								(lo:add(hi)):div(Big:create(2))
							)
						):pow(Big:ensureBig(card.joker_display_values.count+(card.joker_display_values.count2/2)))
					)),4)
				else
					card.joker_display_values.ideal = (((lo+hi)/2)^count)*(hi^count2)
					card.joker_display_values.precision = 100*math.pow(math.exp((hi*math.log(hi)-lo*math.log(lo)-(hi-lo))/(hi-lo))/((lo+hi)/2), (card.joker_display_values.count+(2*card.joker_display_values.count2)))
				end
			end
		}
	end
})

--[[addjkr( {
	key = 'thcief',
	config = { extra = { hypr_thcief = true } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "hypr_placeholder" }
		return { vars = { card.ability.extra.a } }
	end,
	rarity = 2,
	atlas = 'cards',
	blueprint_compat = false,
	perishable_compat = false,
	demicoloncompat = false,
	eternal_compat = false,
	pos = { x = 0, y = 2 },
	cost = 5, --when bought, set cost to -100, thus sell price to -50
	update = function(self,card,dt)
		--calculate_reroll_cost(true)
		for _, v in pairs(G.I.CARD) do
			if v.ability then
				v.tcsell_cost = v.sell_cost
				if v.ability.set == 'Voucher' then
					v.sell_cost = math.inf
				else
					v.sell_cost = 0.0
				end
			end
		end
	end
	calculate = function(self,card,context)
		if context.selling_self then -- does this also apply when destroyed other ways
		for _, v in pairs(G.I.CARD) do
			if v.tcsell_cost then
				v.sell_cost = v.tcsell_cost
			end
		end
	end
})]]

addjkr( {
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
	atlas = 'cards',
	blueprint_compat = true,
	perishable_compat = false,
	demicoloncompat = true,
	eternal_compat = true,
	pos = { x = 1, y = 0 },
	soul_pos = { x = 1, y = 1 },
	cost = 20,
	update = function(self,card,dt)
		if G.playing_cards then
			local tally = 0
			for k, v in pairs(G.playing_cards) do
				if v:get_id() == 7 then tally = tally+1 end
			end
			card.ability.seven_tally = tally
		end
	end,
	calculate = function(self, card, context)
		if card.ability.seven_tally then card.ability.extra.guh = (card.ability.extra.a)^card.ability.seven_tally end
		if context.joker_main or context.forcetrigger then
			return {
				xmult = card.ability.extra.guh
			}
		end
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{
					border_nodes = {
						{ text = "X" },
						{ ref_table = "card.ability.extra", ref_value = "guh", retrigger_type = "exp"}
					}
				}
			}
		}
	end
})

--[[addjkr( {
	key = 'jera',
	config = {},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "hypr_placeholder" }
		return { vars = {} }
	end,
	rarity = 2,
	atlas = 'cards',
	pos = { x = 5, y = 0 },
	cost = 6,
	jeracheck = true,
	-- all hearts are retriggered exactly once
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			local rept = 0 -- smods doesnt like this but w/e
			if context.other_card:is_suit("Hearts") then rept = 1 end
			return {
				repetitions = rept,
				jeracard = context.other_card
			}
		end
	end,
	retrigger_function = function(playing_card, scoring_hand, _, joker_card)
		return playing_card:is_suit("Hearts") and 1 or 0
	end
})]]


G.hypr.ijhjokers = {}
for k,v in pairs(G.P_CENTER_POOLS.Joker) do
	if 
		v.inpool ~= false and 
		v.rarity <= 3 and 
		v.key ~= 'j_hypr_ijh' and
		v.blueprint_compat and
		not v.perishable_compat and
		v.eternal_compat
	then 
		G.hypr.ijhjokers[k]=v
	end
end

local ijhmanage = function(modcard,tokey) -- this was written interely in the DebugPlus console
	local modkey = assert(modcard,'ijhmanage called with nil modcard!').config.center_key
	local modabil = SMODS.shallow_copy(modcard.ability)
	assert(modabil.hypr_ijh, 'Tried to call ijhmanage on a card without hypr_ijh!')
	if modkey == tokey then return false end
	local ens = function(t) return t or {} end
	modabil.extra = ens(modabil.extra)
	modcard.ijhstored = ens(modcard.ijhstored)
	local abil = modcard.ijhstored[tokey]
	modcard:set_ability(tokey)
	if abil then modcard.ability = abil else modcard.ijhstored[modkey] = modabil end
	modcard.ability.extra = ens(modcard.ability.extra)
	return true
end

SMODS.Sticker {
	key = 'ijh',
	should_apply = false, --dont show up naturally
	atlas = 'cards',
	no_collection = true,
	no_sticker_sheet = true, -- cryptid
	pos = { x = 3, y = 0 },
	sets = {},
	badge_colour = G.C.UI.TEXT_DARK,
	loc_vars = function(self, info_queue, card)
		local a
		if type(card.config.center.loc_vars)=='function' then
			a = card.config.center.loc_vars(self, info_queue, card)
		elseif type(card.config.center.loc_vars)=='table' then -- oh god my spaghetti code is cathing up to me
			a = card.config.center.loc_vars
		end
	end,
	calculate = function (self,card,context)
		if context.ending_shop then
			play_sound('tarot1')
			card:flip()
			G.E_MANAGER:add_event(Event({
				trigger = 'after', delay=1,
				func = function()
					ijhmanage(card,pseudorandom_element(G.hypr.ijhjokers).key)
					play_sound('tarot2')
					card:flip()
					return true
				end
			}))
		end
	end,
	draw = function(self, card) -- thank you metanite64 from the cryptid discord
		G.shared_stickers[self.key].role.draw_major = card
		G.shared_stickers[self.key]:draw_shader('dissolve', nil, nil, nil, card.children.center)
	end,
}

addjkr( {
	key = 'ijh',
	config = {},
	loc_vars = {},
	blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = false,
	rarity = 2,
	atlas = 'cards',
	pos = {x=1,y=4},
	cost = 7,
	calculate = function(self,card,context)
		if not context.ending_shop then return end
		card.ability.hypr_ijh = true
		key = pseudorandom_element(G.hypr.ijhjokers).key
		play_sound('tarot1')
			card:flip()
			G.E_MANAGER:add_event(Event({
				trigger = 'after', delay=1,
				func = function()
					ijhmanage(card,pseudorandom_element(G.hypr.ijhjokers).key)
					play_sound('tarot2')
					card:flip()
					return true
				end
			}))
	end
})

drinks = {{2,1,"Spades",nil,true},{3,1,"Hearts",nil,true},{4,1,"Clubs",nil,true},{5,1,"Diamonds",nil,true}} 
if SMODS.find_mod('paperback')[1]~=nil then
	if PB_UTIL.config.suits_enabled then
		table.insert(drinks,{3,2,"paperback_Stars",{requires_stars = true},true})
		table.insert(drinks,{2,2,"paperback_Crowns",{requires_crowns = true},true})
	end
end
if SMODS.find_mod('Bunco')[1]~=nil then 
	table.insert(drinks,{4,2,"bunc_Fleurons",nil,BUNCOMOD.funcs.exotic_in_pool})
	table.insert(drinks,{5,2,"bunc_Halberds",nil,BUNCOMOD.funcs.exotic_in_pool})
end

function shuffle(t)
	for i = #t, 2, -1 do
		local j = math.random(i)
		t[i], t[j] = t[j], t[i]
	end
end

local d_joi = 0
G.hypr["suits"] = {}
for _ , d_j in pairs(drinks) do
	d_joi = d_joi+1
	G.hypr.suits[d_joi] = d_j[3]
end





for _, datlas in ipairs(drinks) do
	local drinkid = 'drink_'..string.lower(datlas[3])
	local keepatlas = {unpack(datlas)}
	addjkr( {
	key = drinkid,
	config = { extra = {stored = keepatlas}},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "hypr_placeholder" }
		return { vars = {localize(card.ability.extra.stored[3], 'suits_plural'), colours = {G.C.SUITS[card.ability.extra.stored[3] ]}} }
	end,
	paperback = keepatlas[4],
	rarity = 2,
	atlas = 'cards',
	pos = { x = datlas[1], y = datlas[2] },
	cost = 6,
	blueprint_compat = false,
	perishable_compat = false,
	demicoloncompat = true,
	eternal_compat = false,
	inpool = keepatlas[5],
	calculate = function(self,card,context)
		if context.selling_self or context.forcetrigger then -- not sure why you'd want to forcetrigger this but. ok
			play_sound('tarot2', 0.76, 0.4)
			local t = G.playing_cards
			local i = 0
			
			G.E_MANAGER:add_event(
				Event({
					trigger = 'after',
					delay = 0.06 * G.SETTINGS.GAMESPEED,
					blockable = false,
					blocking = false,
					func = function()
						local drs = {}
						for k,v in ipairs(G.hypr.suits) do
							drs[k]=v
						end
						if SMODS.find_mod('paperback')[1] then
							if not(PB_UTIL.has_suit_in_deck('paperback_Stars', true) or PB_UTIL.spectrum_played() or card.ability.extra.stored[3]=='paperback_Stars') then table.remove(drs,where(drs,'paperback_Stars')) end
							if not(PB_UTIL.has_suit_in_deck('paperback_Crowns', true) or PB_UTIL.spectrum_played() or card.ability.extra.stored[3]=='paperback_Crowns') then table.remove(drs,where(drs,'paperback_Crowns')) end
						end
						if SMODS.find_mod('Bunco')[1] then
							if not (BUNCOMOD.funcs.exotic_in_pool() or card.ability.extra.stored[3]=='bunc_Fleurons') then table.remove(drs,where(drs,'bunc_Fleurons')) end
							if not (BUNCOMOD.funcs.exotic_in_pool() or card.ability.extra.stored[3]=='bunc_Halberds') then table.remove(drs,where(drs,'bunc_Halberds')) end
						end
						table.remove(drs,where(drs,card.ability.extra.stored[3]))
						local awawa = {}
						local ababa = {}
						for bi=1,#G.playing_cards do
							G.playing_cards[bi]:flip()
							G.playing_cards[bi]:juice_up(0.3, 0.4)
							table.insert(ababa, bi) 
							shuffle(ababa) -- never enough shuffling >:3
						end
						for qp=1,#G.playing_cards do
							k = ababa[qp]
							if k<math.ceil(#G.playing_cards/2) then
								table.insert(awawa,card.ability.extra.stored[3])
							else
								local bucket = math.max(math.ceil(((2*k*#drs)/#G.playing_cards)-#drs),1)
								table.insert(awawa,drs[bucket])
							end
						end
						for k,v in pairs(G.playing_cards) do
							SMODS.change_base(v,awawa[k],nil)
							v:flip()
						end
						play_sound('tarot1', 0.76, 0.4)
						return true
					end
				})
			)
		end
	end})
end



addjkr( {
	key = 'junkdrawer',
	config = {extra={}},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "hypr_placeholder" }
		return {}
	end,
	eternal_compat = true,
	perishable_compat = true,
	blueprint_compat = true,
	demicoloncompat = true,
	rarity = 2,
	atlas = 'cards',
	pos = { x = 0, y = 2 },
	cost = 6,
	calculate = function(self,card,context)
		if context.joker_main or context.forcetrigger then
			if #G.deck.cards==0 then return { message = G.localization.misc.dictionary['k_hypr_empty']} end -- def a better way to do that but idc
			local ctx = { -- taken from paperback's Nichola
				cardarea = G.play,
				full_hand = G.play.cards,
				scoring_hand = context.scoring_hand,
				scoring_name = context.scoring_name,
				poker_hands = context.poker_hands
			}
			local random_seed = (G.GAME and G.GAME.pseudorandom.seed or "") .. "." .. "hypr_junkdrawer"
			local triggercard = pseudorandom_element(G.deck.cards, random_seed)
			if triggercard:can_calculate() then
				local val = triggercard.base.value
				for i=1,string.len(val) do
					if string.sub(val,i,i)=='_' then
						val = string.sub(val,i+1,-1)
						break
					end
				end
				local ret = {message = val..' of '..localize(triggercard.base.suit, 'suits_plural')}
				SMODS.score_card(triggercard, ctx)
				ctx.cardarea = G.hand
				SMODS.score_card(triggercard, ctx)
				return ret
			else 
				return({message=localize('k_hypr_jddebuffed'), colour=G.C.RED})
			end
		end
	end
})

addjkr( {
	key = 'trickcoin',
	config = {extra={ chance = 1000, used=false}},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "hypr_placeholder" }
		roll, _ = SMODS.get_probability_vars(card, card.ability.extra.chance, 0) 
		return { vars = {math.min(roll/100,100/3)}}
	end,
	eternal_compat = true,
	perishable_compat = true,
	blueprint_compat = false,
	demicoloncompat = false,
	rarity = 2,
	atlas = 'cards',
	pos = { x = 1, y = 2 },
	cost = 6,
	update = function(self,card,dt)
		card.ability.extra.chance=math.min(card.ability.extra.chance,10000/3)
	end,
	calculate = function(self,card,context)
		if context.before and not card.ability.extra.used then
			local random_seed = (G.GAME and G.GAME.pseudorandom.seed or "") .. "." .. "hypr_trickcoin"
			local a,_ = SMODS.get_probability_vars(card, card.ability.extra.chance, 0) 
			a = math.min(a,10000/3)
			if SMODS.pseudorandom_probability(card, 'hypr_trickcoin', a, 10000) then
			card.ability.extra.used = true
			
			return {message = G.localization.misc.dictionary['k_hypr_addhand'], func = function() ease_hands_played(1) end }
			end
		end
		if context.end_of_round then
			card.ability.extra.used = false
			if context.beat_boss then
				card.ability.extra.chance = card.ability.extra.chance + 100
			end
		end
	end
})

addjkr( {
	key = 'bypass',
	config = { extra = {odds = 2}, bypassed = {}},
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.odds, 7, 'hypr_bypass')
		info_queue[#info_queue + 1] = { set = "Other", key = "hypr_placeholder" }
		return { vars = { numerator, denominator} }
	end,
	blueprint_compat = true,
	perishable_compat = true,
	demicoloncompat = false,
	eternal_compat = true,
	rarity = 2,
	atlas = 'cards',
	pos = { x = 0, y = 1 },
	cost = 6,
	-- debuffed cards have a 2 in 7 chance to trigger anyway
	calculate = function(self, card, context)
		local bypassed = 0
		if context.before then
			for _, v in pairs(G.playing_cards) do
				if SMODS.pseudorandom_probability(card, 'hypr_bypass', card.ability.extra.odds, 7) then
					SMODS.debuff_card(v,'prevent_debuff',v.unique_val)
					card.ability.bypassed[v.unique_val] = true
					bypassed = bypassed+1
				end
			end	
			for _, v in pairs(G.jokers.cards) do
				if SMODS.pseudorandom_probability(card, 'hypr_bypass', card.ability.extra.odds, 7) then
					SMODS.debuff_card(v,'prevent_debuff',v.unique_val)
					card.ability.bypassed[v.unique_val] = true
					bypassed = bypassed+1
				end
			end	
			for _, v in pairs(G.consumeables.cards) do
				if SMODS.pseudorandom_probability(card, 'hypr_bypass', card.ability.extra.odds, 7) then
					SMODS.debuff_card(v,'prevent_debuff',v.unique_val)
					card.ability.bypassed[v.unique_val] = true
					bypassed = bypassed+1
				end
			end	
			return { message = 'Bypassed x'..bypassed..'!'}
		end
		if context.after then
			for _, v in pairs(G.playing_cards) do
				if card.ability.bypassed[v.unique_val] then
					SMODS.debuff_card(v,'reset',v.unique_val)
					SMODS.recalc_debuff(v)
					card.ability.bypassed[v.unique_val] = nil
				end
			end	
			for _, v in pairs(G.jokers.cards) do
				if card.ability.bypassed[v.unique_val] then
					SMODS.debuff_card(v,'reset',v.unique_val)
					SMODS.recalc_debuff(v)
					card.ability.bypassed[v.unique_val] = nil
				end
			end	
			for _, v in pairs(G.consumeables.cards) do
				if card.ability.bypassed[v.unique_val] then
					SMODS.debuff_card(v,'reset',v.unique_val)
					SMODS.recalc_debuff(v)
					card.ability.bypassed[v.unique_val] = nil
				end
			end	
		end
	end
})

local function expire_joker(card, key, sound, color) -- taken from Jimbotomy
	card_eval_status_text(card, 'extra', nil, nil, nil, { sound = sound, message = localize(key), colour = color })
	--card:juice_up(0.3, 0.4)
	G.E_MANAGER:add_event(
		Event({
			trigger = 'after',
			delay = 0.2,
			func = function()
				card.T.r = -0.2
				card.states.drag.is = true
				card.children.center.pinch.x = true
				return true;
			end
		})
	)
	G.E_MANAGER:add_event(
		Event({
			trigger = 'after',
			delay = 0.6,
			func = function()
				G.jokers:remove_card(card)
				card:remove()
				return true;
			end
		})
	)
end

addjkr( {
	key = 'coloredhoney',
	config = { extra = { dollars = 2, suits = {'Spades', 'Hearts', 'Clubs', 'Diamonds'}, other = {} ,eaten=false} },
	loc_vars = function(self, info_queue, card)
		table.insert(info_queue,{ set = "Other", key = "hypr_placeholder" })
		local col = {}
		local var = {}
		for _, v in ipairs(card.ability.extra.suits) do
			col[#col+1]=G.C.SUITS[v]
			var[#var+1]=localize(v,'suits_plural')
		end
		if card.ability.extra.other then
			for _, v in ipairs(card.ability.extra.other) do
				col[#col+1]=G.C.SUITS[v]
				var[#var+1]='-'..localize(v,'suits_plural')
			end
		end
		var['colours']=col
		if var then table.insert(info_queue,{ set = "Other", key = "hypr_suitsremaining"..tostring(#card.ability.extra.suits+#card.ability.extra.other), vars = SMODS.shallow_copy(var) }) end
		return { vars = {card.ability.extra.dollars}}
	end,
	rarity = 2,
	atlas = 'cards',
	blueprint_compat = true,
	perishable_compat = true,
	demicoloncompat = false,
	eternal_compat = false,
	pos = { x = 0, y = 3 },
	cost = 4,
	pools = { ["Food"] = true },
	calculate = function(self, card, context)
		if context.before then 
			if not scoring_hand then return end -- cryptid 'None' handling 
			local basesuits = {'Spades', 'Hearts', 'Clubs', 'Diamonds'}
			local effects = {}
			for i=1,#scoring_hand do
				local other_card=scoring_hand[i]
				if where(card.ability.extra.suits,other_card.base.suit) then
					if card.joker_display_values then 
						if not card.joker_display_values.rmtable then card.joker_display_values.rmtable = {other_card.base.suit} goto break1 end
						if card.joker_display_values.rmtable and not where(card.joker_display_values.rmtable,other_card.base.suit) then
							table.insert(card.joker_display_values.rmtable,other_card.base.suit)
						end
						::break1::
					end
					table.remove(card.ability.extra.suits,where(card.ability.extra.suits,other_card.base.suit))
					table.insert(effects, {
						dollars = card.ability.extra.dollars,
						message_card = other_card
					} )
				elseif not where(card.ability.extra.other,other_card.base.suit) and not where(basesuits,other_card.base.suit) then
					if card.joker_display_values then 
						if not card.joker_display_values.rmtable then card.joker_display_values.rmtable = {other_card.base.suit} goto break2 end
						if not where(card.joker_display_values.rmtable,other_card.base.suit) then
							table.insert(card.joker_display_values.rmtable,other_card.base.suit)
						end
						::break2::
					end
					table.insert(card.ability.extra.other,other_card.base.suit)
					table.insert(effects, {
						dollars = card.ability.extra.dollars,
						message_card = other_card
					} )
				end
			end
			return SMODS.merge_effects(effects)
		end
		if #card.ability.extra.suits==0 and not card.ability.extra.eaten then 
			card.ability.extra.eaten=true
			expire_joker(card,'k_eaten_ex','tarot1',G.C.RED)
		end
	end,
	update = function(self,card,dt)
		if not card.joker_display_values then card.joker_display_values = {remsuits = ''} end
		local var = {}
		if not card.joker_display_values.rmtable then card.joker_display_values.remsuits = 'None' return end
		for _, v in ipairs(card.joker_display_values.rmtable) do
			var[#var+1]=string.sub(localize(v,'suits_plural'),1,2)
		end
		card.joker_display_values.remsuits = table.concat(var,',')
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{ text = "$"},
				{ ref_table = "card.ability.extra", ref_value = "dollars"}
			},
			text_config = {
				colour = G.C.MONEY
			},
			reminder_text = {
				{ text = "Used: "},
				{ ref_table = "card.joker_display_values", ref_value = "remsuits"}
			},
			reminder_text_config = {
				scale = 0.3
			}
		}
	end
})

addjkr( {
	key = 'saltines',
	config = { extra = { xmult = 1.5, exp = 0.95, min=1.2} },
	loc_vars = function(self, info_queue, card)
		table.insert(info_queue,{ set = "Other", key = "hypr_placeholder" })
		return { vars = { card.ability.extra.xmult, card.ability.extra.exp, card.ability.extra.min } }
	end,
	rarity = 1,
	atlas = 'cards',
	blueprint_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
	eternal_compat = false,
	pos = { x = 1, y = 3 },
	cost = 3,
	pools = { ["Food"] = true },
	update = function(self,card,dt)
		if not card.ability.extra.init then
			card.ability.extra.init = card.ability.extra.xmult 
		end
		if card.ability.extra.exp > 0.99 then card.ability.extra.exp = 0.99 end
	end,
	calculate = function(self, card, context)
		if (context.before or context.end_of_round or context.drawing_cards) and card.joker_display_values then
			card.joker_display_values.storedxmult = card.ability.extra.xmult
		end
		if context.individual and context.cardarea == G.play then
			card.ability.extra.xmult = card.ability.extra.xmult^card.ability.extra.exp
		end
		if context.joker_main or context.forcetrigger then 
			if card.ability.extra.xmult<(card.ability.extra.min) and not card.ability.extra.eaten then 
				card.ability.extra.eaten=true
			end
			return {xmult = card.ability.extra.xmult, func = function() if card.ability.extra.eaten==true then expire_joker(card,'k_eaten_ex','tarot1',G.C.RED) card.ability.extra.eaten='sent' end end } 
		end
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			calc_function = function(card)
				local _,_,cards = JokerDisplay.evaluate_hand(JokerDisplay.current_hand,true) 
				local count = 0
				if not playing_hand then 
					for _,v in ipairs(cards) do
						count = count + JokerDisplay.calculate_card_triggers(v)
					end
				end
				if playing_hand then count = 0 end 
				if not card.joker_display_values.storedxmult then card.joker_display_values.storedxmult=card.ability.extra.xmult end
				
				local notalis = not SMODS.find_mod('Talisman')[1]
				if notalis then card.joker_display_values.calcmult = card.joker_display_values.storedxmult^(card.ability.extra.exp^count)
				else card.joker_display_values.calcmult = Big:ensureBig(card.joker_display_values.storedxmult):pow(Big:ensureBig(card.ability.extra.exp):pow(count))
				end
				local maximum = function(x,y)
					if notalis then return math.max(x,y)
					else return Big:ensureBig(x):max(y) end
				end
				local ln = function(x) if notalis then return math.log(x) else return Big:ensureBig(x):ln() end end
				local tfloor = function(x) if notalis then return math.floor(x) else return Big:ensureBig(x):floor() end end
				local tsucc = function(x) if notalis then return x+1 else return Big:ensureBig(x):add(Big:create(1)) end end --it's called that because it's the succession operator
				local tdiv = function(x,y) if notalis then return x/y else return Big:ensureBig(x):div(y) end end
				local talistr = function(x) if notalis then return tostring(x) else return OmegaMeta.__tostring(x) end end
				local f = function(a,b,c) return tsucc(tfloor(tdiv(ln(tdiv(ln(c),ln(a))),ln(b)))) end
				card.joker_display_values.fullamt = talistr(f(card.ability.extra.init,card.ability.extra.exp,card.ability.extra.min))
				card.joker_display_values.remamt = talistr(maximum(0,f(card.joker_display_values.calcmult,card.ability.extra.exp,card.ability.extra.min)))
			end,
			text = {
				{
					border_nodes = {
						{ text = "X" },
						{ ref_table = "card.joker_display_values", ref_value = "calcmult", retrigger_type = "exp"}
					}
				}
			},
			reminder_text = {
				{ text = "(" },
				{ ref_table = "card.joker_display_values", ref_value = "remamt"},
				{ text = "/" },
				{ ref_table = "card.joker_display_values", ref_value = "fullamt"},
				{ text = ")" }
			}
		}
	end
})


if Cryptid or PB_UTIL then
addjkr( {
	key = '',
	config = { extra = { xmult = 1, scale = .5, immutable = {base = 1, lastknown = 0}} },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.scale, card.ability.extra.xmult } }
	end,
	rarity = (Cryptid and 3) or 2, -- ://DELETE is way more common than 9 of Swords
	atlas = 'cards',
	blueprint_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
	eternal_compat = true,
	pos = { x = 4, y = 3 },
	cost = 5,
	update = function(self,card,dt)
		local i = 0
		if G.GAME.paperback then if G.GAME.paperback.banned_run_keys then
			for _,_ in pairs(G.GAME.paperback.banned_run_keys) do 
				i = i+1
			end
		end end
		if G.GAME.cry_banished_keys then
			for _,_ in pairs(G.GAME.cry_banished_keys) do -- because #G.GAME.cry_banished_keys isn't working somehow
				i = i+1
			end
		end
		card.ability.extra.xmult = card.ability.extra.immutable.base + card.ability.extra.scale*i
		if card.ability.extra.immutable.lastknown ~= i then
			card.ability.extra.immutable.lastknown = i
			if not(G.SETTINGS.paused) then
				card_eval_status_text(card,'extra',nil,nil,nil,{
				message = localize('k_upgrade_ex'),
				delay = 0.1
				})
			end
		end
	end,
	calculate = function(self,card,context)
		if context.joker_main or context.forcetrigger then
			return {xmult = card.ability.extra.xmult}
		end
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{
					border_nodes = {
						{ text = "X" },
						{ ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp"}
					}
				}
			}
		}
	end
})
end
if SMODS.find_mod('Cryptid')[1] then
addjkr( {
	key = 'tedium',
	config = { extra = { emult = 1, scale = .2, immutable ={base = 1,rounds = 0,interacted = true,lasthighlighted = false} } },
	dependencies = {
		items = {
			"set_cry_epic",
		},
	},
	loc_vars = function(self, info_queue, card)
		--table.insert(info_queue,{ set = "Other", key = "hypr_devart" }) --you know what no this works
		return { vars = { card.ability.extra.scale, card.ability.extra.emult } }
	end,
	rarity = 'cry_epic',
	atlas = 'placeholder',
	blueprint_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
	eternal_compat = true,
	pos = { x = 0, y = 0 },
	cost = 5,
	update = function(self,card,dt)
		if card.ability.extra.immutable.lasthighlighted ~= card.highlighted then
			card.ability.extra.immutable.lasthighlighted = card.highlighted
			card.ability.extra.immutable.interacted = true
		end
	end,
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.extra.emult = card.ability.extra.immutable.base
	end,
	calculate = function(self,card,context)
		if context.joker_main or context.forcetrigger then
			if card.ability.extra.emult==1 then return end
			return {
				message = localize({
					type = "variable",
					key = "a_powmult",
					vars = {
						number_format(card.ability.extra.emult),
					},
				}),
				Emult_mod = lenient_bignum(card.ability.extra.emult),
				colour = G.C.DARK_EDITION,
			}
		end
		if context.end_of_round and context.cardarea == G.jokers then
			if not card.ability.extra.immutable.interacted then
				card.ability.extra.emult = card.ability.extra.immutable.base
				return {message = localize('k_reset')}
			else
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "emult",
					scalar_value = "scale",
				})
				card.ability.extra.immutable.interacted = false
				--[[
				SMODS.scale_card(card, {
					ref_table = card.ability.extra, -- the table that has the value you are changing in
					ref_value = "chips", -- the key to the value in the ref_table
					scalar_value = "change", -- the key to the value to scale by, in the ref_table by default
				})
				]]
			end
		end
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{
					border_nodes = {
						{ text = "^" },
						{
							ref_table = "card.ability.extra",
							ref_value = "emult",
							retrigger_type = function(number, triggers)
								local num = number
								for i = 1, triggers - 1 do
									num = num ^ number
								end
								return num
							end,
						}
					},
					border_colour = G.C.DARK_EDITION
				}
			}
		}
	end
}) end



addjkr( {
	key = 'melatonin',
	config = { extra = { active = false, chips = 0, inc_chips = 3 } },
	loc_vars = function(self, info_queue, card)
		local suffix = ''
		if PB_UTIL and not G.hypr.forcenopb then -- G.hypr.forcenopb is set manually in DebugPlus with eval. it's a debugging feature i don't need a proper config for it
			suffix = '_pb'
		    info_queue[#info_queue + 1] = PB_UTIL.suit_tooltip('light')
			info_queue[#info_queue + 1] = PB_UTIL.suit_tooltip('dark')
		end
        card.melatonin_ui = card.melatonin_ui or ''
        return {
			key = self.key..suffix,
            vars = { card.ability.extra.inc_chips, card.ability.extra.chips, localize('k_hypr_active_'..tostring(card.ability.extra.active)), colours = {mix_colours((card.ability.extra.active and G.C.GREEN) or G.C.RED,G.C.JOKER_GREY, 0.8),mix_colours(G.C.RED,G.C.JOKER_GREY, 0.8),mix_colours(G.C.GREEN,G.C.JOKER_GREY, 0.8)} },
        }
	end,
	rarity = 2,
	atlas = 'cards',
	blueprint_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
	eternal_compat = true,
	pos = { x = 5, y = 3 },
	cost = 3,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.end_of_round then
			local lite = false
			local dark = false
			if PB_UTIL then
				lite = PB_UTIL.is_suit(context.other_card, 'light')
				dark = PB_UTIL.is_suit(context.other_card, 'dark')
			else
				lite = context.other_card:is_suit('Hearts') or context.other_card:is_suit('Diamonds')
				dark = context.other_card:is_suit('Spades') or context.other_card:is_suit('Clubs')
			end
			if card.ability.extra.active then
				if lite then
					card.ability.extra.active = false
					card.ability.extra.chips = 0
					return {message = localize('k_reset'), message_card=card}
				end
			else
				if dark then
					card.ability.extra.active = true
				elseif lite then
					card.ability.extra.chips = card.ability.extra.chips+card.ability.extra.inc_chips
				end
			end
			return
		end
		if (context.joker_main or context.forcetrigger) and card.ability.extra.active then return {chips = card.ability.extra.chips} end
		if context.forcetrigger and not card.ability.extra.active then return {message=localize('k_hypr_active_false'..'...'),colour=G.C.JOKER_GREY} end
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		local ret = {
			calc_function = function(card)
				card.joker_display_values.stored = card.ability.extra.chips
				if next(G.play.cards) then return end
				local active = card.ability.extra.active
				local text,_,cards = JokerDisplay.evaluate_hand(JokerDisplay.current_hand,true) 
				if text == 'Unknown' then card.joker_display_values.stored = '???' return end
				local brightness = function(card)
					local lite
					local dark
					if PB_UTIL then
						lite = PB_UTIL.is_suit(card, 'light')
						dark = PB_UTIL.is_suit(card, 'dark')
					else
						lite = card:is_suit('Hearts') or card:is_suit('Diamonds')
						dark = card:is_suit('Spades') or card:is_suit('Clubs')
					end
					return lite,dark
				end
				for _,playing_card in ipairs(cards) do
					if not (playing_card.facing == 'back') and not playing_card.debuff and playing_card:get_id() then
						local lite, dark = brightness(playing_card)
						if dark then 
							active = true
						end
						if lite then 
							if active then
								active = false 
								card.joker_display_values.stored = 0 
							else
								card.joker_display_values.stored = card.joker_display_values.stored + JokerDisplay.calculate_card_triggers(playing_card, nil, true)*card.ability.extra.inc_chips
							end
						end
					end
				end
				card.joker_display_values.active = active
			end,
			style_function = function(card, text, reminder_text, extra)
				if text and text.children[1] and text.children[2] then
					text.children[1].config.colour = card.joker_display_values.active and G.C.CHIPS or mix_colours(G.C.JOKER_GREY,G.C.UI.TEXT_INACTIVE,0.5)
					text.children[2].config.colour = card.joker_display_values.active and G.C.CHIPS or mix_colours(G.C.JOKER_GREY,G.C.UI.TEXT_INACTIVE,0.5)
				end
				return false
			end,
			text = {
				{ text = "+" },
				{ ref_table = "card.joker_display_values", ref_value = "stored", retrigger_type = "mult" },
			}
		}
		return ret
	end
})

addjkr( {
	key = 'rhapsody', -- thank you Squid Joker aka engineer2006 from the Balatro Discord for giving me an idea in #The Sheet Suggestions to springboard off of
	config = { extra = { chips = 0,  incchips = 12 } },
	loc_vars = function(self, info_queue, card)
		table.insert(info_queue,{ set = "Other", key = "hypr_placeholder" })
		local suffix = ''
		if G.GAME.modifiers.enable_perishables_in_shop or BUNCOMOD then -- because bunco adds The Depths
			table.insert(info_queue,{key = 'perishable', set = 'Other', vars = {G.GAME.perishable_rounds or 1, G.GAME.perishable_rounds or G.GAME.perishable_rounds}})
			suffix = '_perishable'
		end
		return { 
			key = self.key..suffix,
			vars = {
				card.ability.extra.incchips,
				card.ability.extra.chips,
				colours = {G.C.PERISHABLE}
			}
		}
	end,
	rarity = 3,
	atlas = 'cards',
	blueprint_compat = true,
	perishable_compat = false, -- because the tooltip would get confusing
	demicoloncompat = true,
	eternal_compat = true,
	pos = { x = 0, y = 4 },
	cost = 10,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.end_of_round then
			if context.other_card:get_id()==12 and not context.blueprint then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra, 
					ref_value = "chips", 
					scalar_value = "incchips", 
				})
			end
		end
		if (context.before or context.end_of_round or context.drawing_cards) and card.joker_display_values then
			card.joker_display_values.storedchips = card.ability.extra.chips
		end
		if context.selling_card and context.card.ability.set == 'Joker' then
			if context.card.ability.perish_tally~=0 then
				card.ability.extra.chips = 0
				if card.joker_display_values.chips then card.joker_display_values.chips=0 end
				return {message = localize('k_reset'), message_card=card}
			end
		end
		if context.joker_main or context.forcetrigger then return {chips = card.ability.extra.chips} end
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{ text = "+" },
				{ ref_table = "card.joker_display_values", ref_value = "calcchips", retrigger_type = "mult" }
			},
			text_config = { colour = G.C.CHIPS },
			reminder_text = {
				{ text = "(" },
				{
					ref_table = "card.joker_display_values",
					ref_value = "localized_text",
					colour = G.C.ORANGE
				},
				{ text = ")" },
			},
			calc_function = function(card)
				local _,_,cards = JokerDisplay.evaluate_hand(JokerDisplay.current_hand,true) 
				local count = 0
				if not playing_hand then
					if text ~= 'Unknown' then
						for _, scoring_card in pairs(cards) do
							if scoring_card:get_id()==12 then
								count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
							end
						end
					end
				end
				if playing_hand then count = 0 end 
				if not card.joker_display_values.storedchips then card.joker_display_values.storedchips=card.ability.extra.chips end
				card.joker_display_values.calcchips = card.joker_display_values.storedchips+(card.ability.extra.incchips*count)
				

				--[[
				card.joker_display_values.storedxchips^(card.ability.extra.exp^count)
				]]
				card.joker_display_values.localized_text = localize('Queen','ranks')
			end
		}
	end
})

local make_sideways = function(self, card, dt) -- taken from Balt's Warehouse
	if card and card.children then
		if not card.config.center.discovered then return end
		if card.children.center then
			card.children.center.sideways = true
		end
		if card.children.back then
			card.children.back.sideways = true
		end
	end
end

--[[
addjkr( {
	key = 'widescreen', -- todo: figure out what it would do
	config = { extra = { mult = 4 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	rarity = 1,
	atlas = 'cards',
	blueprint_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
	eternal_compat = true,
	pixel_size = { w = 95, h = 71 },
	no_collection = false,
	pos = { x = 5, y = 0 },
	cost = 2,
	update = make_sideways,
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then return {mult = card.ability.extra.mult} end
	end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{ text = "+" },
				{ ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult"}
			},
			text_config = {
				colour = G.C.MULT
			}
		}
	end
})
]]

local rarities = {
	1,
	2,
	3,
	'cry_epic',
	4,
	'cry_exotic'
}	

for _,v in pairs(jkrs) do
	assert(where(rarities,v.rarity), 'Rarity '..tostring(v.rarity)..' not found in rarity table!')
end

for i=1,#rarities do
	for _,v in ipairs(jkrs) do
		if v.rarity == rarities[i] then
			SMODS.Joker(v)
		end
	end
end

--[[
more ideas:
	Pliers (Rare,$10): Selling this joker destroys a random joker, prioritizes Eternals
	Clown Nose (Common): Selling this joker gives %playername%(flavor text:That's you!) +4 mult for the rest of this run --player scores in context.before, i somehow need to spoof a joker
	Melatonin:
	--unlock something by reducing discard size to 0
	The Heap - all played hands must contain a 3oak
	The Reflection - Beat your highest scoring round this run
	The Chisel - Chips cannot exceed Mult², and vice versa
]]
	