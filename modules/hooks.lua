local smcmb = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
	smcmb(obj, badges)
	if obj then if obj.original_mod==SMODS.find_mod('hypa')[1] then 
		for i = 1, #badges do
			if badges[i].nodes[1].nodes[2].config.object.string == SMODS.find_mod('hypa')[1].display_name then
				--i wanna do smth here but idk what
			end
		end
	end end
end

local pokerhandinforef = G.FUNCS.get_poker_hand_info
function G.FUNCS.get_poker_hand_info(_cards)
	local text, loc_disp_text, poker_hands, scoring_hand, disp_text = pokerhandinforef(_cards)
	if #scoring_hand and #get_X_same(2,scoring_hand)==3 then
		disp_text = "hypr-Three Pair"
		loc_disp_text = localize(disp_text, "poker_hands")
	end
	return text, loc_disp_text, poker_hands, scoring_hand, disp_text
end

if JokerDisplay then
	local jokerdispcjt = JokerDisplay.calculate_joker_triggers
	function JokerDisplay.calculate_joker_triggers(card)
		local evaltriggers = jokerdispcjt(card)
		if card.ability.hypr_fakeRed then evaltriggers = evaltriggers+1 end
		return evaltriggers
	end 
end

local gencardui = generate_card_ui
function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end)
	_c.loc_vars = _c.loc_vars or function(_,_,_) return {vars=specific_vars} end
	return gencardui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end)
end

G.hypr.scaletest=.1

SMODS.DrawStep:take_ownership('stickers', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	func = function(self, layer)
		local lscpscale = (self.config.center_key=='j_hypr_widescreen') and G.hypr.scaletest
        if self.sticker and G.shared_stickers[self.sticker] then
            G.shared_stickers[self.sticker].role.draw_major = self
            G.shared_stickers[self.sticker]:draw_shader('dissolve', nil, nil, nil, self.children.center)
            G.shared_stickers[self.sticker]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center)
        elseif (self.sticker_run and G.shared_stickers[self.sticker_run]) and G.SETTINGS.run_stake_stickers then
            G.shared_stickers[self.sticker_run].role.draw_major = self
            G.shared_stickers[self.sticker_run]:draw_shader('dissolve', nil, nil, nil, self.children.center, lscpscale)
            G.shared_stickers[self.sticker_run]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center, lscpscale)
        end
		
        for k, v in pairs(SMODS.Stickers) do
            if self.ability[v.key] then
                if v and v.draw and type(v.draw) == 'function' then
                    v:draw(self, layer, nil, nil, nil, lscpscale)
                else
                    G.shared_stickers[v.key].role.draw_major = self
                    G.shared_stickers[v.key]:draw_shader('dissolve', nil, nil, nil, self.children.center, lscpscale)
                    G.shared_stickers[v.key]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center, lscpscale)
                end
            end
        end
    end,
    },
    true -- silent | suppresses mod badge
)

--yeah fuck it ill just pull the entire thing
--[[function Card:draw(layer)
    layer = layer or 'both'

    self.hover_tilt = 1
    
    if not self.states.visible then return end
	local landscape_r = ((self.config.center_key=='j_hypr_widescreen') and math.pi/2) or 0    
	local landscape_s = ((self.config.center_key=='j_hypr_widescreen') and G.hypr.lscpscale) or 1
	
    if (layer == 'shadow' or layer == 'both') then
        self.ARGS.send_to_shader = self.ARGS.send_to_shader or {}
        self.ARGS.send_to_shader[1] = math.min(self.VT.r*3, 1) + G.TIMERS.REAL/(28) + (self.juice and self.juice.r*20 or 0) + self.tilt_var.amt
        self.ARGS.send_to_shader[2] = G.TIMERS.REAL

        for k, v in pairs(self.children) do
            v.VT.scale = self.VT.scale
        end
    end

    G.shared_shadow = self.sprite_facing == 'front' and self.children.center or self.children.back

    --Draw the shadow
    if not self.no_shadow and G.SETTINGS.GRAPHICS.shadows == 'On' and((layer == 'shadow' or layer == 'both') and (self.ability.effect ~= 'Glass Card' and not self.greyed) and ((self.area and self.area ~= G.discard and self.area.config.type ~= 'deck') or not self.area or self.states.drag.is)) then
        self.shadow_height = 0*(0.08 + 0.4*math.sqrt(self.velocity.x^2)) + ((((self.highlighted and self.area == G.play) or self.states.drag.is) and 0.35) or (self.area and self.area.config.type == 'title_2') and 0.04 or 0.1)
        G.shared_shadow:draw_shader('dissolve', self.shadow_height)
    end

    if (layer == 'card' or layer == 'both') and self.area ~= G.hand then 
        if self.children.focused_ui then self.children.focused_ui:draw() end
    end
    
    if (layer == 'card' or layer == 'both') then
        -- for all hover/tilting:
        self.tilt_var = self.tilt_var or {mx = 0, my = 0, dx = self.tilt_var.dx or 0, dy = self.tilt_var.dy or 0, amt = 0}
        local tilt_factor = 0.3
        if self.states.focus.is then
            self.tilt_var.mx, self.tilt_var.my = G.CONTROLLER.cursor_position.x + self.tilt_var.dx*self.T.w*G.TILESCALE*G.TILESIZE, G.CONTROLLER.cursor_position.y + self.tilt_var.dy*self.T.h*G.TILESCALE*G.TILESIZE
            self.tilt_var.amt = math.abs(self.hover_offset.y + self.hover_offset.x - 1 + self.tilt_var.dx + self.tilt_var.dy - 1)*tilt_factor
        elseif self.states.hover.is then
            self.tilt_var.mx, self.tilt_var.my = G.CONTROLLER.cursor_position.x, G.CONTROLLER.cursor_position.y
            self.tilt_var.amt = math.abs(self.hover_offset.y + self.hover_offset.x - 1)*tilt_factor
        elseif self.ambient_tilt then
            local tilt_angle = G.TIMERS.REAL*(1.56 + (self.ID/1.14212)%1) + self.ID/1.35122
            self.tilt_var.mx = ((0.5 + 0.5*self.ambient_tilt*math.cos(tilt_angle))*self.VT.w+self.VT.x+G.ROOM.T.x)*G.TILESIZE*G.TILESCALE
            self.tilt_var.my = ((0.5 + 0.5*self.ambient_tilt*math.sin(tilt_angle))*self.VT.h+self.VT.y+G.ROOM.T.y)*G.TILESIZE*G.TILESCALE
            self.tilt_var.amt = self.ambient_tilt*(0.5+math.cos(tilt_angle))*tilt_factor
        end
        --Any particles
        if self.children.particles then self.children.particles:draw() end

        --Draw any tags/buttons
        if self.children.price then self.children.price:draw() end
        if self.children.buy_button then
            if self.highlighted then
                self.children.buy_button.states.visible = true
                self.children.buy_button:draw()
                if self.children.buy_and_use_button then 
                    self.children.buy_and_use_button:draw()
                end
            else
                self.children.buy_button.states.visible = false
            end
        end
        if self.children.use_button and self.highlighted then self.children.use_button:draw() end

        if self.vortex then
            if self.facing == 'back' then 
                self.children.back:draw_shader('vortex')
            else
                self.children.center:draw_shader('vortex')
                if self.children.front then 
                    self.children.front:draw_shader('vortex')
                end
            end

            love.graphics.setShader()
        elseif self.sprite_facing == 'front' then 
            --Draw the main part of the card
            if (self.edition and self.edition.negative) or (self.ability.name == 'Antimatter' and (self.config.center.discovered or self.bypass_discovery_center)) then
                self.children.center:draw_shader('negative', nil, self.ARGS.send_to_shader)
                if self.children.front and self.ability.effect ~= 'Stone Card' then
                    self.children.front:draw_shader('negative', nil, self.ARGS.send_to_shader)
                end
            elseif not self.greyed then
                self.children.center:draw_shader('dissolve')
                --If the card has a front, draw that next
                if self.children.front and self.ability.effect ~= 'Stone Card' then
                    self.children.front:draw_shader('dissolve')
                end
            end

            --If the card is not yet discovered
            if not self.config.center.discovered and (self.ability.consumeable or self.config.center.unlocked) and not self.config.center.demo and not self.bypass_discovery_center then
                local shared_sprite = (self.ability.set == 'Edition' or self.ability.set == 'Joker') and G.shared_undiscovered_joker or G.shared_undiscovered_tarot
                local scale_mod = -0.05 + 0.05*math.sin(1.8*G.TIMERS.REAL)
                local rotate_mod = 0.03*math.sin(1.219*G.TIMERS.REAL)

                shared_sprite.role.draw_major = self
                shared_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center, scale_mod, rotate_mod)
            end

            if self.ability.name == 'Invisible Joker' and (self.config.center.discovered or self.bypass_discovery_center) then
                self.children.center:draw_shader('voucher', nil, self.ARGS.send_to_shader)
            end

            --If the card has any edition/seal, add that here
            if self.edition or self.seal or self.ability.eternal or self.ability.rental or self.ability.perishable or self.sticker or ((self.sticker_run and self.sticker_run ~= 'NONE') and G.SETTINGS.run_stake_stickers) or (self.ability.set == 'Spectral') or self.debuff or self.greyed or (self.ability.name == 'The Soul') or (self.ability.set == 'Voucher') or (self.ability.set == 'Booster') or self.config.center.soul_pos or self.config.center.demo then
                
                if (self.ability.set == 'Voucher' or self.config.center.demo) and (self.ability.name ~= 'Antimatter' or not (self.config.center.discovered or self.bypass_discovery_center)) then
                    self.children.center:draw_shader('voucher', nil, self.ARGS.send_to_shader)
                end
                if self.ability.set == 'Booster' or self.ability.set == 'Spectral' then
                    self.children.center:draw_shader('booster', nil, self.ARGS.send_to_shader)
                end
                if self.edition and self.edition.holo then
                    self.children.center:draw_shader('holo', nil, self.ARGS.send_to_shader)
                    if self.children.front and self.ability.effect ~= 'Stone Card' then
                        self.children.front:draw_shader('holo', nil, self.ARGS.send_to_shader)
                    end
                end
                if self.edition and self.edition.foil then
                    self.children.center:draw_shader('foil', nil, self.ARGS.send_to_shader)
                    if self.children.front and self.ability.effect ~= 'Stone Card' then
                        self.children.front:draw_shader('foil', nil, self.ARGS.send_to_shader)
                    end
                end
                if self.edition and self.edition.polychrome then
                    self.children.center:draw_shader('polychrome', nil, self.ARGS.send_to_shader)
                    if self.children.front and self.ability.effect ~= 'Stone Card' then
                        self.children.front:draw_shader('polychrome', nil, self.ARGS.send_to_shader)
                    end
                end
                if (self.edition and self.edition.negative) or (self.ability.name == 'Antimatter' and (self.config.center.discovered or self.bypass_discovery_center)) then
                    self.children.center:draw_shader('negative_shine', nil, self.ARGS.send_to_shader)
                end
                if self.seal then
                    G.shared_seals[self.seal].role.draw_major = self
                    G.shared_seals[self.seal]:draw_shader('dissolve', nil, nil, nil, self.children.center)
                    if self.seal == 'Gold' then G.shared_seals[self.seal]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center) end
                end
                if self.ability.eternal then
                    G.shared_sticker_eternal.role.draw_major = self
                    G.shared_sticker_eternal:draw_shader('dissolve', nil, nil, nil, self.children.center, landscape_s, landscape_r)
                    G.shared_sticker_eternal:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center, landscape_s, landscape_r)
                end
                if self.ability.perishable then
                    G.shared_sticker_perishable.role.draw_major = self
                    G.shared_sticker_perishable:draw_shader('dissolve', nil, nil, nil, self.children.center, landscape_s, landscape_r)
                    G.shared_sticker_perishable:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center, landscape_s, landscape_r)
                end
                if self.ability.rental then
                    G.shared_sticker_rental.role.draw_major = self
                    G.shared_sticker_rental:draw_shader('dissolve', nil, nil, nil, self.children.center, landscape_s, landscape_r)
                    G.shared_sticker_rental:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center, landscape_s, landscape_r)
                end
                if self.sticker and G.shared_stickers[self.sticker] then
                    G.shared_stickers[self.sticker].role.draw_major = self
                    G.shared_stickers[self.sticker]:draw_shader('dissolve', nil, nil, nil, self.children.center, landscape_s, landscape_r)
                    G.shared_stickers[self.sticker]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center, landscape_s, landscape_r)
                elseif (self.sticker_run and G.shared_stickers[self.sticker_run]) and G.SETTINGS.run_stake_stickers then
                    G.shared_stickers[self.sticker_run].role.draw_major = self
                    G.shared_stickers[self.sticker_run]:draw_shader('dissolve', nil, nil, nil, self.children.center, landscape_s, landscape_r)
                    G.shared_stickers[self.sticker_run]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center, landscape_s, landscape_r)
                end

                if self.ability.name == 'The Soul' and (self.config.center.discovered or self.bypass_discovery_center) then
                    local scale_mod = 0.05 + 0.05*math.sin(1.8*G.TIMERS.REAL) + 0.07*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
                    local rotate_mod = 0.1*math.sin(1.219*G.TIMERS.REAL) + 0.07*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2
    
                    G.shared_soul.role.draw_major = self
                    G.shared_soul:draw_shader('dissolve',0, nil, nil, self.children.center,scale_mod, rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
                    G.shared_soul:draw_shader('dissolve', nil, nil, nil, self.children.center, scale_mod, rotate_mod)
                end

                if self.config.center.soul_pos and (self.config.center.discovered or self.bypass_discovery_center) then
                    local scale_mod = 0.07 + 0.02*math.sin(1.8*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
                    local rotate_mod = 0.05*math.sin(1.219*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2
    
                    if self.ability.name == 'Hologram' then
                        self.hover_tilt = self.hover_tilt*1.5
                        self.children.floating_sprite:draw_shader('hologram', nil, self.ARGS.send_to_shader, nil, self.children.center, 2*scale_mod, 2*rotate_mod)
                        self.hover_tilt = self.hover_tilt/1.5
                    else
                        self.children.floating_sprite:draw_shader('dissolve',0, nil, nil, self.children.center,scale_mod, rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
                        self.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center, scale_mod, rotate_mod)
                    end
                    
                end
                if self.debuff then
                    self.children.center:draw_shader('debuff', nil, self.ARGS.send_to_shader)
                    if self.children.front and self.ability.effect ~= 'Stone Card' then
                        self.children.front:draw_shader('debuff', nil, self.ARGS.send_to_shader)
                    end
                end
                if self.greyed then
                    self.children.center:draw_shader('played', nil, self.ARGS.send_to_shader)
                    if self.children.front and self.ability.effect ~= 'Stone Card' then
                        self.children.front:draw_shader('played', nil, self.ARGS.send_to_shader)
                    end
                end
            end 
        elseif self.sprite_facing == 'back' then
            local overlay = G.C.WHITE
            if self.area and self.area.config.type == 'deck' and self.rank > 3 then
                self.back_overlay = self.back_overlay or {}
                self.back_overlay[1] = 0.5 + ((#self.area.cards - self.rank)%7)/50
                self.back_overlay[2] = 0.5 + ((#self.area.cards - self.rank)%7)/50
                self.back_overlay[3] = 0.5 + ((#self.area.cards - self.rank)%7)/50
                self.back_overlay[4] = 1
                overlay = self.back_overlay
            end

            if self.area and self.area.config.type == 'deck' then
                self.children.back:draw(overlay)
            else
                self.children.back:draw_shader('dissolve')
            end

            if self.sticker and G.shared_stickers[self.sticker] then
                G.shared_stickers[self.sticker].role.draw_major = self
                G.shared_stickers[self.sticker]:draw_shader('dissolve', nil, nil, true, self.children.center, landscape_s, landscape_r)
                if self.sticker == 'Gold' then G.shared_stickers[self.sticker]:draw_shader('voucher', nil, self.ARGS.send_to_shader, true, self.children.center, landscape_s, landscape_r) end
            end
        end

        for k, v in pairs(self.children) do
            if k ~= 'focused_ui' and k ~= "front" and k ~= "back" and k ~= "soul_parts" and k ~= "center" and k ~= 'floating_sprite' and k~= "shadow" and k~= "use_button" and k ~= 'buy_button' and k ~= 'buy_and_use_button' and k~= "debuff" and k ~= 'price' and k~= 'particles' and k ~= 'h_popup' then v:draw() end
        end

        if (layer == 'card' or layer == 'both') and self.area == G.hand then 
            if self.children.focused_ui then self.children.focused_ui:draw() end
        end

        add_to_drawhash(self)
        self:draw_boundingrect()
    end
end]]

--[[local insrep = SMODS.insert_repetitions
SMODS.insert_repetitions = function(ret, eval, effect_card, _type)
	if eval == nil then goto allow end
	print("ret", ret)
	print("eval", eval)
	if eval then for k,v in pairs(eval) do print("eval",k,v) end end
	print("effect_card", effect_card)
	print("effect_card type", type(effect_card))
	print("effect_card keys", effect_card and effect_card.key)
	print("_type", _type)
	if effect_card then
		if eval.jeracard then end
		if not((effect_card.label or nil)=="j_hypr_jera") and (eval.jeracard and eval.jeracard:is_suit("Hearts")) then
			return -- Block this repetition!
		end
	end

	-- Otherwise, allow as normal
	::allow::
	return insrep(ret, eval, effect_card, _type)
end
]]