--[[loc_vars = function(self, info_queue, card)
        local suit_text = "Clover"
        local suit_color = HEX('3dad2f')
        if G.C.SUITS[card.base.suit] then
            suit_text = localize(card.base.suit, 'suits_singular')
            suit_color = G.C.SUITS[card.base.suit]
        else
            suit_text = localize(self.force_suit, 'suits_singular')
            suit_color = G.C.SUITS[self.force_suit]
        end
        return { vars = { self.config.extra.max,  suit_text, colours = {suit_color}} }

end]]

odric = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "odric",
	atlas = "mtg_atlas",
	pos = { x = 11, y = 3 },
	config = { extra = {base_mult = 1, mult_per = 0.25}},
    overrides_base_rank = true,
    weight = 5,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_per, card.ability.extra.base_mult} }
	end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.hand and not context.repetition and not card.debuff then
            local diamond_count = 0
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit("Diamonds") then diamond_count = diamond_count + 1 end
            end
            if diamond_count > 0 then
                effect.x_mult = card.ability.extra.base_mult + diamond_count * card.ability.extra.mult_per
            end
        end
    end
}
odric.force_value = "King"
odric.force_suit = "Diamonds"

akroma = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "akroma",
	atlas = "mtg_atlas",
	pos = { x = 11, y = 2 },
	config = { extra = {mult_x = 2}},
    overrides_base_rank = true,
    weight = 5,
	loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.mult_x} }
	end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition and not card.debuff then
            if G.GAME.current_round.hands_played == 0 then
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("mtg_haste_ex"), colour = G.ARGS.LOC_COLOURS.diamond})
                effect.x_mult = card.ability.extra.mult_x
            end
        end
    end
}
akroma.force_value = "Queen"
akroma.force_suit = "Diamonds"

sublime = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "sublime",
	atlas = "mtg_atlas",
	pos = { x = 8, y = 5 },
	config = { extra = {mult_solo = 2}},
    overrides_base_rank = true,
    weight = 5,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_solo} }
	end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.hand and not context.repetition and not card.debuff then
            if #context.full_hand == 1 then
                effect.x_mult = card.ability.extra.mult_solo
            end
        end
    end
}
sublime.force_value = "Jack"
sublime.force_suit = "Diamonds"

token_soldier = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "soldier",
	atlas = "mtg_atlas",
	pos = { x = 8, y = 1 },
	config = { extra = {mult_per = 2}},
    overrides_base_rank = true,
    weight = 0,
    in_pool = function() return false end,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_per} }
	end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition and not card.debuff then
            local diamond_count = 0
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit("Diamonds") then diamond_count = diamond_count + 1 end
            end
            effect.mult = diamond_count * card.ability.extra.mult_per
        end
    end
}
token_soldier.force_value = "2"
token_soldier.force_suit = "Diamonds"

urza = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "urza",
	atlas = "mtg_atlas",
	pos = { x = 10, y = 0 },
	config = { },
    overrides_base_rank = true,
    force_suit = G.C.SUITS.Spades,
    weight = 5,
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_steel
        return {  }

	end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition and not card.debuff then
            local non_steel_cards = {}
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].config.center_key ~= "m_steel" then non_steel_cards[#non_steel_cards+1] = G.hand.cards[i] end
            end
            if #non_steel_cards > 0 then
                local card_to_enhance = pseudorandom_element(non_steel_cards, pseudoseed('urza'))
                G.FUNCS.buff_cards({card_to_enhance},0, 0, "m_steel")
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("mtg_steel_ex"), colour = G.ARGS.LOC_COLOURS.club})
            end
        end
    end
}
urza.force_value = "King"
urza.force_suit = "Clubs"

kiora = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "kiora",
	atlas = "mtg_atlas",
	pos = { x = 9, y = 3 },
	config = {extra = {requried_discards = 8, current_discards = 0}},
    overrides_base_rank = true,
    weight = 5,
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "r_mtg_octopus", set = "Other", config = { extra = 1 } , vars = { 8 } }
        return { vars = { card.ability.extra.requried_discards, card.ability.extra.current_discards} }
	end,
    calculate = function(self, card, context, effect)
        if context.pre_discard and not card.debuff then
            card.ability.extra.current_discards = card.ability.extra.current_discards + #context.full_hand
            if card.ability.extra.current_discards >= card.ability.extra.requried_discards then
                card.ability.extra.current_discards = 0
                G.E_MANAGER:add_event(Event({func = function()
                    local _suit, _rank = SMODS.Suits["Clubs"].card_key, "8"
                    local octopus = create_playing_card({front = G.P_CARDS[_suit..'_'.._rank], center = token_octopus}, G.hand, nil, i ~= 1, {G.C.SECONDARY_SET.Magic})
                    G.hand:sort()
                    --Originally, she was also going to give it a random edition
                    --local selected_edition = poll_edition("aura", nil, true, false)
                    --octopus.set_edition(octopus, selected_edition)
                    return true end }))
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("mtg_octopus_ex"), colour = G.ARGS.LOC_COLOURS.club})
            end
        end
    end
}
kiora.force_value = "Queen"
kiora.force_suit = "Clubs"

stormcrow = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "stormcrow",
	atlas = "mtg_atlas",
	pos = { x = 6, y = 6 },
	config = { },
    overrides_base_rank = true,
    weight = 5,
	loc_vars = function(self, info_queue, card)
        return {  }

	end,
    calculate = function(self, card, context, effect)
        if context.pre_discard and not card.debuff then
            if G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1 then
                if context.full_hand[1] and context.full_hand[1]:is_suit("Clubs") then
                    destroy_cards({context.full_hand[1]})
                    G.hand:unhighlight_all()
                    if G.GAME.blind and ((not G.GAME.blind.disabled) and (G.GAME.blind:get_type() == 'Boss')) then 
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_nope_ex'), colour = G.ARGS.LOC_COLOURS.club})
                        G.GAME.blind:disable()
                    else
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("mtg_sacrifice_ex"), colour = G.ARGS.LOC_COLOURS.club})
                    end
                    
                end
            end
        end
    end
}
stormcrow.force_value = "Jack"
stormcrow.force_suit = "Clubs"

token_octopus = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "octopus",
	atlas = "mtg_atlas",
	pos = { x = 8, y = 3 },
	config = {extra = {mult = 8}},
    overrides_base_rank = true,
    weight = 0,
    in_pool = function() return false end,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult} }
	end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition and not card.debuff then
            effect.mult = card.ability.extra.mult
        end
    end
}
token_octopus.force_value = "8"
token_octopus.force_suit = "Clubs"

--YAWGMOTH : His ability triggers before everything else because it doesn't make an event, maybe look at this?
yawgmoth = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "yawgmoth",
	atlas = "mtg_atlas",
	pos = { x = 9, y = 0 },
	config = { extra = {current_mult = 0, mult_per = 5}},
    overrides_base_rank = true,
    weight = 5,
	loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.current_mult, card.ability.extra.mult_per} }
	end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition and not card.debuff then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    if #G.hand.cards then
                        local temp_ID = G.hand.cards[1].base.id
                        local smallest = G.hand.cards[1]
                        for i=1, #G.hand.cards do
                            if temp_ID >= G.hand.cards[i].base.id and G.hand.cards[i].ability.effect ~= 'Stone Card' then temp_ID = G.hand.cards[i].base.id; smallest = G.hand.cards[i] end
                        end
                        if smallest.debuff then
                            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_debuffed'),colour = G.C.RED})
                        else
                            destroy_cards({smallest})
                        end
                    end
                    return true
                end}))
                card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.mult_per
                effect.mult = card.ability.extra.current_mult
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('mtg_sacrifice_ex'), colour = G.ARGS.LOC_COLOURS.spade})
            
        end
    end
}
yawgmoth.force_value = "King"
yawgmoth.force_suit = "Spades"

sheoldred = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "sheoldred",
	atlas = "mtg_atlas",
	pos = { x = 10, y = 3 },
	config = { },
    overrides_base_rank = true,
    weight = 5,
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "r_mtg_reanimate", set = "Other", config = {extra = 1}}
        return {  }
	end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition and not card.debuff then
                if (G.GAME.jokers_sold and #G.GAME.jokers_sold) and (#G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers) then
                    G.E_MANAGER:add_event(Event({func = function()
                        play_sound('timpani')
                        reanimate()
                        card:juice_up(0.3, 0.5)
                        return true end }))
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("mtg_reanimate_ex"), colour = G.ARGS.LOC_COLOURS.spade})
                end
            end
    end
}
sheoldred.force_value = "Queen"
sheoldred.force_suit = "Spades"

tinybones = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "tinybones",
	atlas = "tiny",
	pos = { x = 0, y = 0 },
	config = { extra = {money = 3}},
    overrides_base_rank = true,
    force_suit = G.C.SUITS.Spades,
    weight = 5,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money} }

	end,
    calculate = function(self, card, context, effect)
        if context.pre_discard and not card.debuff then
            if G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1 then
          ease_dollars(card.ability.extra.money)
          card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('mtg_tinybones_ex'), colour = G.ARGS.LOC_COLOURS.spade})
          end
          end
    end
}
tinybones.force_value = "Jack"
tinybones.force_suit = "Spades"

token_demon = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "demon",
	atlas = "mtg_atlas",
	pos = { x = 10, y = 1 },
	config = { extra = {x_mult = 2}},
    overrides_base_rank = true,
    weight = 0,
    in_pool = function() return false end,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult} }
	end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition and not card.debuff then
            effect.x_mult = card.ability.extra.x_mult
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    if #G.hand.cards then
                        local temp_ID = G.hand.cards[1].base.id
                        local smallest = G.hand.cards[1]
                        for i=1, #G.hand.cards do
                            if temp_ID >= G.hand.cards[i].base.id and G.hand.cards[i].ability.effect ~= 'Stone Card' then temp_ID = G.hand.cards[i].base.id; smallest = G.hand.cards[i] end
                        end
                        if smallest.debuff then
                            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_debuffed'),colour = G.C.RED})
                        else
                            destroy_cards({smallest})
                            --[[G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.15,
                                func = function()
                                    destroy_cards({smallest})
                                    return true
                                end}))]]
                        end
                    end
                    return true
                end}))
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('mtg_sacrifice_ex'), colour = G.ARGS.LOC_COLOURS.spade})
            
        end
    end
}
token_demon.force_value = "6"
token_demon.force_suit = "Spades"

kikijiki = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "kikijiki",
	atlas = "kiki",
	pos = { x = 0, y = 0 },
	config = { },
    overrides_base_rank = true,
    weight = 5,
	loc_vars = function(self, info_queue, card)
        return {  }

	end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.hand and not context.repetition and not card.debuff then
            if G.GAME.current_round.hands_played == 0 and #context.full_hand == 1 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        local _card = copy_card(context.full_hand[1], nil, nil, G.playing_card)
                        _card:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, _card)
                        G.hand:emplace(_card)
                        _card.states.visible = nil
                        _card:start_materialize()
                        playing_card_joker_effects({true})
                        return true
                    end
                }))
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("k_copied_ex"), colour = G.ARGS.LOC_COLOURS.heart})
            end
        end
    end
}
kikijiki.force_value = "King"
kikijiki.force_suit = "Hearts"

ashling = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "ashling",
	atlas = "mtg_atlas",
	pos = { x = 11, y = 0 },
	config = { extra = {damage_per = 1}},
    overrides_base_rank = true,
    weight = 5,
	loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.damage_per} }

	end,
    calculate = function(self, card, context, effect)
        if context.pre_discard and not card.debuff then
            local heart_count = 0
            for i = 1, #context.full_hand do
                if context.full_hand[i]:is_suit("Hearts") then heart_count = heart_count + 1 end
            end
            if heart_count > 0 then
                damage_blind(card, card.ability.extra.damage_per, heart_count)
            end
        end
    end
}
ashling.force_value = "Queen"
ashling.force_suit = "Hearts"

shivan = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "shivan",
	atlas = "mtg_atlas",
	pos = { x = 4, y = 6 },
	config = { extra = {mult = 5, damage_per = 1} },
    overrides_base_rank = true,
    force_suit = G.C.SUITS.Hearts,
    weight = 5,
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "r_mtg_damage_blind", set = "Other", config = {extra = 1}, vars = { current_blind_life() or "?"}}
        return { vars = { card.ability.extra.mult, card.ability.extra.damage_per} }

	end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition and not card.debuff then
            bonus_damage(card, card.ability.extra.damage_per, 1)
          effect.mult = card.ability.extra.mult
        end
    end
}
shivan.force_value = "Jack"
shivan.force_suit = "Hearts"

token_goblin = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "goblin",
	atlas = "mtg_atlas",
	pos = { x = 3, y = 6 },
	config = { extra = {mult=1}},
    overrides_base_rank = true,
    weight = 0,
    in_pool = function() return false end,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult}}

	end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition and not card.debuff then
            effect.mult = card.ability.extra.mult
        end
    end
}
token_goblin.force_value = "2"
token_goblin.force_suit = "Hearts"

yorvo = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "yorvo",
	atlas = "mtg_atlas",
	pos = { x = 3, y = 5 },
	config = { extra = {current_mult = 0, bonus_mult = 2} },
    overrides_base_rank = true,
    force_suit = suit_clovers,
    weight = 5,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.bonus_mult, card.ability.extra.current_mult} }

	end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition and not card.debuff then
            local clovers_total = 0
            for k,v in pairs(context.scoring_hand) do
                if v ~= card and v:is_suit(suit_clovers.key) then clovers_total = clovers_total + 1 end
            end
            if clovers_total >= 1 then
                card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.bonus_mult
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), colour = G.ARGS.LOC_COLOURS.clover})
            end
            effect.mult = card.ability.extra.current_mult
        end
    end
}
yorvo.force_value = "King"
yorvo.force_suit = suit_clovers.key

nissa = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "nissa",
	atlas = "mtg_atlas",
	pos = { x = 10, y = 2 },
	config = { extra = {strength = 1}},
    overrides_base_rank = true,
    weight = 5,
	loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.strength} }

	end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition and not card.debuff then
            if #G.hand.cards then
                local temp_ID = G.hand.cards[1].base.id
                local smallest = G.hand.cards[1]
                for i=1, #G.hand.cards do
                    if temp_ID >= G.hand.cards[i].base.id and G.hand.cards[i].ability.effect ~= 'Stone Card' then temp_ID = G.hand.cards[i].base.id; smallest = G.hand.cards[i] end
                end
                if smallest.debuff then
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_debuffed'),colour = G.C.RED})
                else
                    G.FUNCS.buff_cards({smallest},card.ability.extra.strength, 1)
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("mtg_buff_ex"), colour = G.ARGS.LOC_COLOURS.clover})
                end
            end
        end
    end
}
nissa.force_value = "Queen"
nissa.force_suit = suit_clovers.key

baru = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "baru",
	atlas = "mtg_atlas",
	pos = { x = 7, y = 2 },
	config = { extra = {strength = 1} },
    overrides_base_rank = true,
    force_suit = suit_clovers,
    weight = 5,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.strength} }

	end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition and not card.debuff then
            local clovers = 0
            for k, v in ipairs(context.scoring_hand) do
              if v ~= card and v:is_suit(suit_clovers.key) then 
                clovers = clovers + 1
                G.FUNCS.buff_cards({v}, card.ability.extra.strength, 1)
                delay(0.1)
              end
      
          end
          if clovers > 0 then 
              card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('mtg_buff_ex')})
            end
          end
    end
}
baru.force_value = "Jack"
baru.force_suit = suit_clovers.key

token_squirrel = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "squirrel",
	atlas = "mtg_atlas",
	pos = { x = 0, y = 6 },
	config = { extra = {max = 6}},
    overrides_base_rank = true,
    weight = 0,
    in_pool = function() return false end,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max} }
	end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition and not card.debuff then
            effect.mult = pseudorandom_i_range(pseudoseed("mtg-squirrel"), 1, card.ability.extra.max)
        end
    end
}
token_squirrel.force_value = "2"
token_squirrel.force_suit = suit_clovers.key

--dominaria
SMODS.Booster {
    object_type = "Booster",
    key = "enhancement_pack_1",
    atlas = "pack",
    pos = { x = 1, y = 1 },
    config = {extra = 2, choose = 1 },
    cost = 4,
    order = 1,
    weight = 0.96,
    create_card = function(self, card)
        local _edition = poll_edition('mtg_edition'..G.GAME.round_resets.ante, 2, true)
        local _seal = SMODS.poll_seal({mod = 10})
        return {set = "Enhanced" , edition = _edition, seal = _seal, area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "sta"}
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SET.Magic)
        ease_background_colour({ new_colour = G.C.SET.Magic, special_colour = G.C.BLACK, contrast = 2 })
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.config.center.config.choose, card.ability.extra } }
    end,
    group_key = "k_mtg_enhancement_pack",
  }
