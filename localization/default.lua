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
					"{C:blue}+1{} cards {C:blue}playable per hand{}",
					"{C:red}-1{} cards {C:red}discardable per discard{}"
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
					"{C:bunc_fleurons}Fleurons{} roll with {C:attention,E:2}advantage{}"
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
			j_hypr_ijh = {
				name = 'Insert Joke Here',
				text = {
					"Copies a {C:green}random{} compatible joker",
					"from your {C:dark_edition}Collection{}",
					"Cannot copy {C:legendary}Legendary{} or above",
					"{C:inactive}Currently copying {C:attention}#1#{}"
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
					"Before scoring, {C:red,E:2}debuffed{} cards have",
					"a {C:green}#1# in #2#{} chance to temporarily",
					"{C:attention,E:1}un-debuff{} until end of hand"
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
					"both played {C:attention}and{} held in hand",
					"{C:inactive}(Only counts the base card, its{}",
					"{C:inactive}Editions, and its Enhancements){}"
				}
			},
			j_hypr_trickcoin = {
				name = 'Trick Coin',
				text = 	{
					"Once per round, on hand played,",
					"{X:green,C:white}#1#%{} chance to {C:blue,E:1}refund used hand{}",
					"{C:inactive}(Max chance is 33.3%){}"
				}
			},
			j_hypr_coloredhoney = {
				name = 'Colored Honey',
				text = {
					"When a base suit is scored for",
					"the first time after picking up",
					"this joker, give {C:money}$#1#{}",
					"{C:red,E:2}Self destructs{} if no suits remaining"
				}
			},
			j_hypr_saltines = {
				name = 'Saltines',
				text = {
					"{X:mult,C:white}X#1#{} Mult, {C:dark_edition}^#2#{} per card scored",
					"{C:red,E:2}Self destructs{} when below {X:mult,C:white}X#3#{}"
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
			k_hypr_active_false = "Inactive"
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