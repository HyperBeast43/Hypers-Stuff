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
			}
		}
	},
	misc = {
		challenge_names = {
			c_hypr_no7 = "Point's On"
		}
	}
}
