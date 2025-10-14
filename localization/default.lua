local drinktxt = {
	"When sold, randomly turns", -- given we're using pairs and not ipairs it's effectively random
	"{C:attention}half{} of your deck into {V:1}#1#{},",
	" and the other half into",
	"{C:attention}every other suit{} evenly"
}
local junktxt = {
	"Triggers a random {V:1}#1#{} card",
	"from your {C:attention}remaining deck{} as",
	"both played {C:attention}and{} held in hand"
}

return {
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
                name="Solar Deck",
                text={
					"{C:blue}+1{} cards {C:blue}playable per hand{}",
					"{C:red}-1{} cards {C:red}discardable per discard{}"
                },
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
					"that can show up in {C:attention}Buffoon Packs{},",
					"{C:green}Rerolls{} at end of shop",
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
					"{C:G.C.ATTENTION,E:1}un-debuff{} until end of hand"
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
			j_hypr_drink_bunco_fleurons = {
				name = 'Rosewine',
				text = drinktxt
			},
			j_hypr_drink_bunco_halberds = {
				name = 'Battle Energy',
				text = drinktxt
			},
			--junkdrawer
			j_hypr_junk_spades = {
				name = 'Thumbtack',
				text = junktxt
			},
			j_hypr_junk_hearts = {
				name = 'Lipstick',
				text = junktxt
			},
			j_hypr_junk_clubs = {
				name = 'Golf Ball',
				text = junktxt
			},
			j_hypr_junk_diamonds = {
				name = 'Arcade Token',
				text = junktxt
			},
			j_hypr_junk_paperback_stars = {
				name = 'Lightbulb',
				text = junktxt
			},
			j_hypr_junk_paperback_crowns = {
				name = 'Headband',
				text = junktxt
			},
			j_hypr_junk_bunco_fleurons = {
				name = 'Pressed Clover',
				text = junktxt
			},
			j_hypr_junk_bunco_halberds = {
				name = 'Pocket Knife',
				text = junktxt
			},
			--
		}
	},
	misc = {
		challenge_names = {
			c_hypr_no7 = "Point's On"
		}
	}
}