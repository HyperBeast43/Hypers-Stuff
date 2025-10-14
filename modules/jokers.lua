--[[SMODS.Joker {
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
				{
					border_nodes = {
						{ text = "X" },
						{ ref_table = "card.ability.extra", ref_value = "xmult", retrigger_type = "exp"}
					}
				}
			}
		}
	end
}]]

--[[SMODS.Joker {
	key = 'ijh',
	config = { extra = { copied = nil } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "hypr_placeholder" }
		return { vars = { card.ability.extra.copied } }
	end,
	blueprint_compat = true,
	rarity = 3,
	atlas = 'cards',
	pos = { x = 3, y = 0 },
	cost = 10,
	calculate = function(self, card, context)
		if context.ending_shop or card.ability.extra.copied == nil then
			card.ability.extra.copied = false
			card.ability.extra.copied = SMODS.create_card {
				set = 'Joker',
				skip_materialize = true,
				no_edition = true,
				key_append = 'hypr_ijh' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
			}
			
		end
		return SMODS.blueprint_effect(card, card.ability.extra.copied, context)
	end
}]]

SMODS.Joker {
	key = 'curator',
	config = {},
	loc_vars = function(self, info_queue, card)
		return 
	end,
	rarity = 1,
	blueprint_compat = false,
	atlas = 'cards',
	pos = { x = 4, y = 0 },
	cost = 1,
	update = function(self, card, dt)
		if not(G.SETTINGS.paused) and card.edition == nil then	
			
			local bannededitions = {["e_cry_glitched"]=true,["e_cry_oversat"]=true,["e_cry_double_sided"]=true, ["e_cry_glass"]=card.ability.eternal} -- e_cry_blurred isnt banned because ://HOOK exists. also no need to check if Cryptid is installed because we're not actually referring to the editions we're referring to their ids
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
		if context.joker_main then
			return {
				chips = 0, -- this is so editions that fire upon joker trigger do something, like cryptid's Golden
				remove_default_message = true
			}
		end
	end
}
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
SMODS.Joker {
	key = 'creacher',
	config = { extra = { low = 0.9, high = 1.67 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "hypr_placeholder" }
		return { vars = { card.ability.extra.low, card.ability.extra.high } }
	end,
	rarity = 2,
	blueprint_compat = true,
	demicoloncompat = true,
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

		if (context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:is_suit("Clubs")) or context.forcetrigger then
			local random_seed = card.randomseed or "creacher"
			random_seed = (G.GAME and G.GAME.pseudorandom.seed or "") .. random_seed
			local factor = pseudorandom(pseudoseed(random_seed))
			return {
				xmult = lo + (factor * (hi-lo))
			}
		end
	end,
	joker_display_def = function(JokerDisplay) 
		---@type JDJokerDefinition
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
			reminder_text = {
				{ text = "(" },
				{ ref_table = "card.joker_display_values", ref_value = "localized_text", colour = lighten(G.C.SUITS["Clubs"], 0.35) },
				{ text = ")" }
			},
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
				for _, playing_card in ipairs(G.hand.cards) do
					if playing_hand or not playing_card.highlighted then
						if not (playing_card.facing == 'back') and not playing_card.debuff and playing_card:get_id() and playing_card:is_suit("Clubs") then
							count = count + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
						end
					end
				end
				card.joker_display_values.count = count*JokerDisplay.calculate_joker_triggers(card)
				if SMODS.find_mod('Talisman')[1] ~= nil then
					lo = Big:ensureBig(lo)
					hi = Big:ensureBig(hi) 
					card.joker_display_values.ideal = OmegaMeta.__tostring(OmegaMeta.__pow((lo:add(hi):div(Big:create(2))),Big:ensureBig(count)))
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
						):pow(Big:ensureBig(card.joker_display_values.count))
					)),4)
				else
					card.joker_display_values.ideal = ((lo+hi)/2)^count
					card.joker_display_values.precision = 100*math.pow(math.exp((hi*math.log(hi)-lo*math.log(lo)-(hi-lo))/(hi-lo))/((lo+hi)/2), card.joker_display_values.count)
				end

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
	atlas = 'cards',
	pos = { x = 0, y = 2 },
	cost = 5, --when bought, set cost to -100, thus sell price to -50
	update = function(self,card,dt)
		--calculate_reroll_cost(true)
		for _, v in pairs(G.I.CARD) do
			if v.ability then
				if v.ability.set == 'Voucher' then
					v.sell_cost = math.inf
				else
					v.sell_cost = 0.0
				end
			end
        end
	end
}]]

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
	atlas = 'cards',
	blueprint_compat = true,
	demicoloncompat = true,
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
}

--[[SMODS.Joker {
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
}]]

SMODS.Joker {
	key = 'bypass',
	config = { extra = {odds = 2}, bypassed = {}},
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.odds, 7, 'hypr_bypass')
		info_queue[#info_queue + 1] = { set = "Other", key = "hypr_placeholder" }
        return { vars = { numerator, denominator} }
    end,
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
					if not v.bypassid then v.bypassid='id'..math.random(-10000000000,10000000000) end
					SMODS.debuff_card(v,'prevent_debuff',v.bypassid)
					card.ability.bypassed[v.bypassid] = true
					bypassed = bypassed+1
				end
			end	
			for _, v in pairs(G.jokers.cards) do
				if SMODS.pseudorandom_probability(card, 'hypr_bypass', card.ability.extra.odds, 7) then
					if not v.bypassid then v.bypassid='id'..math.random(-10000000000,10000000000) end
					SMODS.debuff_card(v,'prevent_debuff',v.bypassid)
					card.ability.bypassed[v.bypassid] = true
					bypassed = bypassed+1
				end
			end	
			for _, v in pairs(G.consumeables.cards) do
				if SMODS.pseudorandom_probability(card, 'hypr_bypass', card.ability.extra.odds, 7) then
					if not v.bypassid then v.bypassid='id'..math.random(-10000000000,10000000000) end
					SMODS.debuff_card(v,'prevent_debuff',v.bypassid)
					card.ability.bypassed[v.bypassid] = true
					bypassed = bypassed+1
				end
			end	
			return { message = 'Bypassed x'..bypassed..'!'}
		end
		if context.after then
			for _, v in pairs(G.playing_cards) do
				if v.bypassid and card.ability.bypassed[v.bypassid] then
					SMODS.debuff_card(v,'reset',v.bypassid)
					SMODS.recalc_debuff(v)
					card.ability.bypassed[v.bypassid] = nil
				end
			end	
			for _, v in pairs(G.jokers.cards) do
				if v.bypassid and card.ability.bypassed[v.bypassid] then
					SMODS.debuff_card(v,'reset',v.bypassid)
					SMODS.recalc_debuff(v)
					card.ability.bypassed[v.bypassid] = nil
				end
			end	
			for _, v in pairs(G.consumeables.cards) do
				if v.bypassid and card.ability.bypassed[v.bypassid] then
					SMODS.debuff_card(v,'reset',v.bypassid)
					SMODS.recalc_debuff(v)
					card.ability.bypassed[v.bypassid] = nil
				end
			end	
		end
	end
}

where = function(t, thing)
	i=0
	for _, v in pairs(t) do
		i = i+1
		if v == thing then
			return i
		end
	end
	return nil
end



local drinks = {["Spades"]={2,3,"Spades",nil},["Hearts"]={3,3,"Hearts",nil},["Clubs"]={4,3,"Clubs",nil},["Diamonds"]={5,3,"Diamonds",nil}} 
if SMODS.find_mod('paperback')[1]~=nil then
	if PB_UTIL.config.suits_enabled then
		drinks["Stars"]={3,4,"paperback_Stars",{requires_stars = true}}
		drinks["Crowns"]={2,4,"paperback_Crowns",{requires_crowns = true}}
	end
end
--[[if SMODS.find_mod('Bunco')[1]~=nil then --bunco is still a wip
	drinks["Fleurons"]={4,4,"bunco_Fleurons",{}}
	drinks["Halberds"]={5,4,"bunco_Halberds",{}}
end]]

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



for _, datlas in pairs(drinks) do
	local drinkid = 'drink_'..string.lower(datlas[3])
	local keepatlas = {unpack(datlas)}
	SMODS.Joker {
	key = drinkid,
	config = { extra = {stored = {keepsuit,keepatlas}}},
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "hypr_devart" }
        return { vars = {localize(card.ability.extra.stored[2][3], 'suits_plural'), colours = {G.C.SUITS[card.ability.extra.stored[2][3]]}} }
    end,
	paperback = keepatlas[4],
	rarity = 2,
	atlas = 'cards',
	pos = { x = datlas[1], y = datlas[2] },
	cost = 6,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self,card,context)
		if context.selling_self or context.forcetrigger then -- not sure why you'd want to forcetrigger this but. ok
			play_sound('tarot2', 0.76, 0.4)
			local random_seed = (G.GAME and G.GAME.pseudorandom.seed or "") .. "." .. "hypr_"..drinkid
			local t = G.playing_cards
			local i = 0
			
			G.E_MANAGER:add_event(
                Event({
                    trigger = 'after',
                    delay = 0.06 * G.SETTINGS.GAMESPEED,
                    blockable = false,
                    blocking = false,
                    func = function()
						local drs = {unpack(G.hypr.suits)}
						if SMODS.find_mod('paperback') then
							if not(PB_UTIL.has_suit_in_deck('paperback_Stars', true) or PB_UTIL.spectrum_played()) then table.remove(drs,where(drs,'paperback_Stars')) end
							if not(PB_UTIL.has_suit_in_deck('paperback_Crowns', true) or PB_UTIL.spectrum_played()) then table.remove(drs,where(drs,'paperback_Crowns')) end
						end
						table.remove(drs,where(drs,card.ability.extra.stored[2][3]))
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
								table.insert(awawa,card.ability.extra.stored[2][3])
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
    end}
end



-- note: steal PB_UTIL.has_suit_in_deck()
--[[ i need more sleep
junk = {("Spades"={2,1}),("Hearts"={3,1}),("Clubs"={4,1}),("Diamonds"={5,1})} -- todo: check for paperback/bunco suits
for junksuit, junkatlas in pairs(junk) do
	local junkid = 'trinket_'..string.lower(junksuit)
	SMODS.Joker {
	key = junkid,
	config = {extra = {localdeck={}}},
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "hypr_devart" }
		color = G.C.SUITS[junksuit]
        return { vars = {junksuit, colours = {color}}} }
    end,
	rarity = 2,
	atlas = 'cards',
	pos = { x = junkatlas[1], y = junkatlas[2] },
	cost = 6,
	calculate = function(self,card,context)
		if context.before then 
			card.ability.extra.localdeck = G.deck.cards -- so it doesnt spend time recalculating G.deck.cards every trigger
		end
		if context.joker_main then
			--im too tired to implement it rn
		end
	end
	}
end]]
--[[
more ideas:
    Trick Coin (Uncommon): Selling any card duplicates it, with a 1/3 chance to destroy this joker
    ??/Unicorn Blood/Rasped Blueberry/Midas Pop(read:soda) (if Paperback,+ Stardew/Royal Jelly) (if Bunco,+ Rosewine/Battle Energy)    (Uncommon): Selling this joker turns half of your deck into [suit], and randomizes the suits of the other half ([suit] cannot be picked during randomization) exotic suits cannot be picked if not unlocked yet this run
    Colored Honey (Uncommon): $8 when (suit) is triggered for the first time after pickup, self-destructs when no suits remaining (0/4) --(Starts with the base 4 suits, additional suits give +1/+1 )
    Pliers (Rare): Selling this joker destroys a random eternal joker
    Clown Nose (Common): Selling this joker gives %playername%(flavor text:That's you!) +4 mult for the rest of this run --player scores once context.before becomes false from true, put some sort of falling-edge observer in update - unless theres an easier way to do this and i'm just blind   
]]
	