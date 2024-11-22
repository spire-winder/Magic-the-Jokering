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
        return { vars = { self.config.extra.max, suit_text, colours = {suit_color}} }

	end]]

token_squirrel = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "squirrel",
	atlas = "mtg_atlas",
	pos = { x = 0, y = 6 },
	config = { extra = {max = 6}},
    overrides_base_rank = true,
    weight = 0,
	loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.max} }
	end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition then
            effect.mult = pseudorandom_i_range(pseudoseed("mtg-squirrel"), 1, card.ability.extra.max)
        end
    end
}
token_squirrel.force_value = "2"
token_squirrel.force_suit = suit_clovers.key

token_goblin = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "goblin",
	atlas = "mtg_atlas",
	pos = { x = 3, y = 6 },
	config = { extra = {mult=1}},
    overrides_base_rank = true,
    weight = 0,
	loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.mult}}

	end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition then
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
	config = { extra = {current_mult = 4, bonus_mult = 2} },
    overrides_base_rank = true,
    force_suit = suit_clovers,
    weight = 50,
	loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.bonus_mult} }

	end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition then
            local clovers_total = 0
            for k,v in pairs(context.scoring_hand) do
                if v ~= card and v:is_suit(suit_clovers.key) then clovers_total = clovers_total + 1 end
            end
            if clovers_total >= 1 then
                card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.bonus_mult
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
            end
            effect.mult = card.ability.extra.current_mult
        end
    end
}
yorvo.force_value = "King"
yorvo.force_suit = suit_clovers.key

tinybones = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "tinybones",
	atlas = "mtg_atlas",
	pos = { x = 2, y = 6 },
	config = { extra = {money = 3}},
    overrides_base_rank = true,
    force_suit = G.C.SUITS.Spades,
    weight = 50,
	loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.money} }

	end,
    calculate = function(self, card, context, effect)
        if context.pre_discard then
            if G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1 then
          ease_dollars(card.ability.extra.money)
          card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('$')..card.ability.extra.money})
          end
          end
    end
}
tinybones.force_value = "Jack"
tinybones.force_suit = "Spades"

baru = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "baru",
	atlas = "mtg_atlas",
	pos = { x = 7, y = 2 },
	config = { extra = {strength = 1} },
    overrides_base_rank = true,
    force_suit = suit_clovers,
    weight = 50,
	loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.strength} }

	end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition then
            local clovers = 0
            for k, v in ipairs(context.scoring_hand) do
              if v ~= card and v:is_suit(suit_clovers.key) then 
                clovers = clovers + 1
                G.E_MANAGER:add_event(Event({
                  trigger = 'after',
                  delay = 0.1,
                  func = function()
                    buff_card(v, card.ability.extra.strength)
                    return true
                  end
              }))
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

shivan = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "shivan",
	atlas = "mtg_atlas",
	pos = { x = 4, y = 6 },
	config = { extra = {mult = 5, damage_per = 1} },
    overrides_base_rank = true,
    force_suit = G.C.SUITS.Hearts,
    weight = 50,
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "r_mtg_damage_blind", set = "Other", config = {extra = 1}, vars = { current_blind_life() or "?"}}
        return { vars = { self.config.extra.mult, self.config.extra.damage_per} }

	end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition then
            bonus_damage(card, card.ability.extra.damage_per, 1)
          effect.mult = card.ability.extra.mult
        end
    end
}
shivan.force_value = "5"
shivan.force_suit = "Hearts"

--[[serra_angel = SMODS.Enhancement {
	object_type = "Enhancement",
	key = "serraangel",
	atlas = "mtg_atlas",
	pos = { x = 4, y = 6 },
	config = { extra = {mult = 4} },
    overrides_base_rank = true,
    force_suit = G.C.SUITS.Hearts,
    weight = 50,
	loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.mult} }

	end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition then
            bonus_damage(card, card.ability.extra.damage_per, 1)
          effect.mult = card.ability.extra.mult
        end
    end
}
shivan.force_value = "5"
shivan.force_suit = "Diamonds"]]