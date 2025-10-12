local hascryptid = SMODS.find_mod('Cryptid')[1] ~= nil

addifmod = function(always,varying,mod)
	if not next(SMODS.find_mod(mod)) then return always end
	local i = #always
	for _, v in ipairs(varying) do
		i = i+1
        always[i] = v
    end
	return always
end

SMODS.Challenge {
    key = 'no7',
    rules = {
        custom = {
            { id = 'no_shop_jokers' },
        },
        modifiers = {
            { id = 'joker_slots', value = 0 },
        }
    },
    jokers = (function()
		local j = {
			{id = 'j_hypr_hypa'},
			{id = 'j_blueprint', pinned = true}
		}
		for _, v in ipairs(j) do
            if next(SMODS.find_mod('Cryptid')) then
                v.stickers = { "cry_absolute" }
            else
                v.eternal = true
            end
			print(v)
        end
		return j
	end)(),
	vouchers = {
		{ id = 'v_magic_trick' }
	},
    restrictions = {
        banned_cards = addifmod({
            { id = 'c_judgement' },
			{ id = 'c_chariot' },
            { id = 'c_wraith' },
            { id = 'c_soul' },
            { id = 'v_antimatter' },
            { id = 'p_buffoon_normal_1', ids = {
                'p_buffoon_normal_1', 'p_buffoon_normal_2', 'p_buffoon_jumbo_1', 'p_buffoon_mega_1',
				}
            }
		},{
			{ id = 'c_cry_variable' },
			{ id = 'c_cry_commit' },
			{ id = 'c_cry_spaghetti' },
			{ id = 'c_cry_hook' },
			{ id = 'c_cry_quantify' },
			{ id = 'c_cry_rework' },
			{ id = 'c_cry_summoning' },
			{ id = 'c_cry_meld' },
			{ id = 'c_cry_gateway' },
			{ id = 'c_cry_analog' },
			{ id = 'c_cry_adversary' },
			{ id = 'v_cry_fabric' },
			{ id = 'v_cry_pairing' },
			{ id = 'v_cry_repair_man' },
			{ id = 'v_cry_pairamount_plus' }
		},'Cryptid'),
        banned_tags = addifmod({
			{ id = 'tag_uncommon' },
			{ id = 'tag_rare' },
			{ id = 'tag_negative' },
			{ id = 'tag_foil' },
			{ id = 'tag_holographic' },
			{ id = 'tag_polychrome' },
			{ id = 'tag_buffoon' },
			{ id = 'tag_top_up' }
		},{
			{ id = 'tag_cry_gambler' },
			{ id = 'tag_cry_epic' },
			{ id = 'tag_cry_double_m' },
			{ id = 'tag_cry_empowered' },
			{ id = 'tag_cry_schematic' },
			{ id = 'tag_cry_glitched' },
			{ id = 'tag_cry_oversat' },
			{ id = 'tag_cry_mosaic' },
			{ id = 'tag_cry_gold' },
			{ id = 'tag_cry_glass' },
			{ id = 'tag_cry_blur' },
			{ id = 'tag_cry_astral' },
			{ id = 'tag_cry_m' },
			{ id = 'tag_cry_banana' },
			{ id = 'tag_cry_loss' },
			{ id = 'tag_cry_gourmand' }, -- im sorry gourm but i have to
			{ id = 'tag_cry_bettertop_up' },
			{ id = 'tag_cry_rework' }
		}, 'Cryptid'),
        banned_other = addifmod({
            { id = 'bl_final_heart', type = 'blind' },
            { id = 'bl_final_leaf',  type = 'blind' },
            { id = 'bl_final_acorn', type = 'blind' }
		},{
			{ id = 'bl_cry_trophy', type='blind' },
			{ id = 'bl_cry_vermillion_virus', type='blind' },
			{ id = 'bl_cry_landlord', type='blind' },
			{ id = 'bl_cry_windmill', type='blind' },
			{ id = 'bl_cry_decision', type='blind' },
			{ id = 'bl_cry_pin', type='blind' },
			{ id = 'bl_cry_box', type='blind' },
			{ id = 'bl_cry_repulsor', type='blind' },
			{ id = 'bl_cry_striker', type='blind' },
			{ id = 'bl_cry_oldfish', type='blind' }
        },'Cryptid')
    },
	deck = {
        type = 'Challenge Deck',
        no_ranks = { ['7'] = true } 
	}
}