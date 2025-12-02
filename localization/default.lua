local drinktxt = {
	"When sold, randomly turns",
	"{C:attention}half{} of your deck into {V:1}#1#{},",
	" and the other half into",
	"{C:attention}every other suit{} evenly"
}



loc = {
	descriptions = {
		Other = {
			hypr_placeholder = {
				name = "Placeholder Art",
				text = {
					"The art for this card is unfinished,",
					"It may or may not stay that way"
				}
			},
			hypr_devart = {
				name = "Programmer Art",
				text = {
					"The art for this card is unfinished,",
					"It will hopefully be updated soon"
				}
			},
			hypr_guest_art = {
				name = "Guest Art",
				text = {
					"Art by {C:attention}#1#{}"
				}
			},
			hypr_advantage = {
				name = "Advantage",
				text = {
					"Roll twice, pick",
					"the {C:green}higher{} number"
				}
			},
			hypr_disadvantage = {
				name = "Disdvantage",
				text = {
					"Roll twice, pick",
					"the {C:red}lower{} number"
				}
			},
			hypr_suitsremaining0 = {
				name = "Remaining Suits",
				text = {"None!"}
			},
			fakeRed={
				name="Red Seal",
				text={"this text should never show up"}
			},
			hypr_ijh = {
				name = 'Insert Joke Here',
				text = {
					"At end of shop, turns into a {C:green}random{}",
					"compatible joker from your {C:dark_edition}Collection{}",
					"Cannot copy rarities above {C:rare}Rare{}",
					"{C:inactive,s:0.8}(Keeps any scaling if a scaled joker is rolled again)"
				}
			},
		},
		Spectral = {
			c_hypr_recursion = {
				name = "Recursion",
				text = {
					"Add a {C:red}Red Seal{}",
					"to a random {C:attention}Joker,{}",
					"{C:red}-#1#{} discard size{}"
				}
			}
		},
		Back = {
			b_hypr_solar={
				name="Solar Deck",
				text={
					"{C:blue}+1{} cards {C:blue}playable per hand{}",
					"{C:red}-1{} cards {C:red}discardable per discard{}"
				},
			}
		},
		Sleeve = {
			sleeve_hypr_solar={
				name="Solar Sleeve",
				text={
					"{C:blue}+1{} cards {C:blue}per hand{}",
					"{C:red}-1{} cards {C:red}per discard{}"
				},
			}
		},
		Blind = {
			b_hypr_dice={
				name="The Dice",
				text={
					"All probabilities",
					"roll with disadvantage"
				}
			}
		},
		Joker = {
			j_hypr_hypa = {
				name = 'Hyper',
				text = {
					"Every {C:attention}7{} in your",
					"{C:attention}full deck{} gives {X:mult,C:white}X#2#{} Mult,",
					"stacking {C:attention}multiplicatively{}",
					"{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)"
				}
			},
			j_hypr_creacher = {
				name = 'Creature Feature',
				text = {
					"{C:clubs}Clubs{} held in hand give",
					"a random value from",
					"{X:mult,C:white}X#1#{} up to {X:mult,C:white}X#2#{} Mult"
				}
			},
			j_hypr_creacher_exotic = {
				name = 'Creature Feature',
				text = {
					"{C:clubs}Clubs{} and {C:bunc_fleurons}Fleurons{} held in hand",
					"give a random value from",
					"{X:mult,C:white}X#1#{} up to {X:mult,C:white}X#2#{} Mult",
					"{C:bunc_fleurons}Fleurons{} roll with {C:attention,E:hypr_2}advantage{}"
				}
			},
			j_hypr_curator = {
				name = 'Curator',
				text = {
					"Does nothing, but {C:attention}always{} has an edition"
				}
			},
			j_hypr_test = {
				name = 'Blank Joker',
				text = {
					"Does nothing, and should never show up.",
					"If it does somehow, there's a problem..."
				}
			},
			j_hypr_thcief = {
				name = 'Five-Finger Discount',
				text = {
					"Everything is {C:attention,E:1}free{}, but",
					"{C:green}rerolls{} are {C:red}disabled{}"
				}
			},
			j_hypr_jera = {
				name = 'Runic Ruby',
				text = {
					"All {C:hearts}Hearts{} are retriggered",
					"{C:attention}exactly once{}"
				}
			},
			j_hypr_bypass = {
				name = 'Bypass',
				text = {
					"Before scoring, anything {C:red,E:hypr_2}debuffed{} has",
					"a {C:green}#1# in #2#{} chance to temporarily",
					"{C:attention,E:1}un-debuff{} until end of hand"
				}
			},
			j_hypr_ = {
				name = ' ',
				text = {
					"For every {C:attention}banished{}",
					"card, give {X:mult,C:white}X#1#{} Mult",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
				}
			},
			j_hypr_ijh = {
				name = 'Insert Joke Here',
				text = {
					"At end of shop, turns into a {C:green}random{}",
					"compatible joker from your {C:dark_edition}Collection{}",
					"{C:attention}Keeps this ability once transformed{}",
					"Cannot copy rarities above {C:rare}Rare{}",
					"{C:inactive,s:0.8}(Keeps any scaling if a scaled joker is rolled again)",
				}
			},
			j_hypr_tedium = {
				name = 'Tedium',
				text = {
					"Every round, gain {X:dark_edition,C:white}^#1#{} Mult",
					"{C:red}Resets{} if not {C:attention}clicked{} during a round",
					"{C:inactive}(Currently {X:dark_edition,C:white}^#2#{C:inactive} Mult)"
				}
			},
			j_hypr_missingno = {
				name = 'MissingNo.',
				text = {
					"{X:red,C:white}X#1#{} Mult, {C:green}#2# in #3#{} chance to",
					"{C:red,E:hypr_tremble}crash the game{} instead",
					"Outcome based on {C:attention}Round{} and {C:dark_edition}Run Seed{}",
					"{C:inactive}(If it crashes once, it'll keep doing so)"
				}
			},
			j_hypr_plane = {
				name = 'Paper Airplane?',
				text = { --
					"{C:green}#3# in #4#{} chance for +{C:chips}#1#{} Chips",
					--"{C:red}Disables{} skipping scoring animations",
					"Creates a {C:attention}#2#{}",
					"{C:red,E:hypr_2}Destroying one destroys the rest"
				}
			},
			j_hypr_planefake = {
				name = 'Paper Airplane?',
				text = { --
					"{C:green}#3# in #4#{} chance for +{C:chips}#1#{} Chips",
					--"{C:red}Disables{} skipping scoring animations",
					"Creates a {C:attention}#2#{}",
					"{C:red,E:hypr_2}Destroying one destroys the rest"
				}
			},
			--drinks
				j_hypr_drink_spades = {
					name = 'PhD Pepper',
					text = drinktxt
				},
				j_hypr_drink_hearts = {
					name = 'Unicorn Blood',
					text = drinktxt
				},
				j_hypr_drink_clubs = {
					name = 'Rasped Blueberry',
					text = drinktxt
				},
				j_hypr_drink_diamonds = {
					name = 'Midas Pop',
					text = drinktxt
				},
				j_hypr_drink_paperback_stars = {
					name = 'Stardew',
					text = drinktxt
				},
				j_hypr_drink_paperback_crowns = {
					name = 'Royal Mead',
					text = drinktxt
				},
				j_hypr_drink_bunc_fleurons = {
					name = 'Rosewine',
					text = drinktxt
				},
				j_hypr_drink_bunc_halberds = {
					name = 'Battle Energy',
					text = drinktxt
				},
			j_hypr_junkdrawer = {
				name = 'Junk Drawer',
				text = 	{
					"Triggers a random card",
					"from your {C:attention}remaining deck{} as",
					"both played {C:attention}and{} held in hand"
				}
			},
			j_hypr_trickcoin = {
				name = 'Trick Coin',
				text = 	{
					"Once per round, on hand played,",
					"{X:green,C:white}#1#%{} chance to {C:blue,E:1}refund used hand{}",
					"+{X:green,C:white}#2#%{} after defeating a {C:attention}Boss Blind{}",
					"{C:inactive}(Max chance is 33.3%){}"
				}
			},
			j_hypr_coloredhoney = {
				name = 'Colored Honey',
				text = {
					"When a suit is scored for the first time",
					"after picking up this joker, give {C:money}$#1#{}",
					"{C:red,E:hypr_2}Self destructs{} if no suits remaining"
				}
			},
			j_hypr_saltines = {
				name = 'Saltines',
				text = {
					"{X:mult,C:white}X#1#{} Mult, {C:dark_edition}^#2#{} per card scored",
					"{C:red,E:hypr_2}Self destructs{} when below {X:mult,C:white}X#3#{}"
				}
			},
			j_hypr_melatonin = {
				name = 'Lights Out',
				text = {
					"Gains {C:chips}+#1#{} Chips if a {C:hearts}Heart{} or {C:diamonds}Diamond{} is scored while {V:2}inactive{}",
					"{C:red,E:hypr_2}Resets{} if a {C:hearts}Heart{} or {C:diamonds}Diamond{} is scored while {V:3}active{}",
					"{V:3}Activates{} if a {C:spades}Spade{} or {C:clubs}Club{} is scored",
					"Only triggers while {V:3}active{}",
					"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips, {B:1,C:white}#3#{C:inactive}){}"
				}
			},
			j_hypr_melatonin_pb = {
				name = 'Lights Out',
				text = {
					"Gains {C:chips}+#1#{} Chips if a {C:paperback_light_suit}light suit{} is scored while {V:2}inactive{}",
					"{C:red,E:hypr_2}Resets{} if a {C:paperback_light_suit}light suit{} is scored while {V:3}active{}",
					"{V:3}Activates{} if a {C:paperback_dark_suit}dark suit{} is scored",
					"Only triggers while {V:3}active{}",
					"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips, {B:1,C:white}#3#{C:inactive}){}"
				}
			},
			j_hypr_rhapsody = {
				name = 'Bohemian Joker',
				text = {
					"When a {C:attention}Queen{} is scored, gain {C:chips}+#1#{} Chips",
					"{C:red}Resets{} when a Joker is {C:money,E:hypr_2}sold{}",
					"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips){}"
				}
			},
			j_hypr_rhapsody_perishable = {
				name = 'Bohemian Joker',
				text = {
					"When a {C:attention}Queen{} is scored, gain {C:chips}+#1#{} Chips",
					"{C:red}Resets{} when a Joker is {C:money,E:hypr_2}sold{} without",
					"it being debuffed by {V:1,E:hypr_circle}Perishable{}",
					"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips){}"
				}
			},
			j_hypr_widescreen = {
				name = 'Landscape Joker',
				text = {
					"{C:red}+#1#{} Mult"
				}
			}
		}
	},
	misc = {
		challenge_names = {
			c_hypr_no7 = "Point's On"
		},
		dictionary = {
			k_hypr_empty = "Empty Deck!",
			k_hypr_failsafe = "Failsafe?!",
			k_hypr_addhand = "+1 Hand",
			k_hypr_active_true = "Active",
			k_hypr_active_false = "Inactive",
			k_hypr_jddebuffed = 'Card Debuffed!',
			--000crash starts at 2 because 1 would be a localization error, which fits too
			k_hypr_000crash2 = 'dVKqPAKobgO6', -- hey since you're looking through the code, might as well tell you:
			k_hypr_000crash3 = '1001100010101101110', -- every crash text is an encrypted message
			k_hypr_000crash4 = 'Bcq/5F*&OK@;^0uA0>u4+D>>&Du', -- i don't remember how i encrypted them so. good luck
			k_hypr_000crash5 = 'b6g5g4g5g4d5g5d3g1g4g5g1h5a3d3g1a2b4a3g1a7g1c5g4h1f7a3g1a3h4g5g1c5f3g1c5f4f4' -- (except this one i remember how i did this one)
			
		},
		poker_hands = {
			['hypr-Three Pair'] = "Three Pair"
		},
		labels = {
			hypr_fakeRed = "Red Seal",
			hypr_ijh = 'Insert Joke Here'
		}
	}
}

for k,_ in pairs(G.hypr.suits) do
	loc.descriptions.Other['hypr_suitsremaining'..tostring(k)] = {
		name = "Remaining Suits",
		text = {}
	}
	local t = {}
	for i=1,k do
		t[i]='{V:'..i..'}#'..i..'#{}'
	end
	loc.descriptions.Other['hypr_suitsremaining'..tostring(k)].text = {table.concat(t,', ')}
end

return loc