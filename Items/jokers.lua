--Celestial dawn
SMODS.Joker {
  object_type = "Joker",
name = "mtg-celestialdawn",
  key = "celestialdawn",
  pos = {
      x = 4,
      y = 4
  },
  atlas = 'mtg_atlas',
cost = 8,
order = 1,
rarity = 3,
  config = {},
  loc_vars = function(self, info_queue, card)
    return { }
  end
}

--Light from Within
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-lightfromwithin",
	key = "lightfromwithin",
	pos = { x = 0, y = 3 },
	config = { },
  order = 2,
	rarity = 2,
	cost = 7,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
		return { }
	end,
	calculate = function(self, card, context)
    if context.individual then
      if context.cardarea == G.play then
        if context.other_card:is_suit('Diamonds') then
          return {
            mult = context.other_card.base.nominal,
            card = card
          }
        end
      end
    end
	end
}

--Harbinger of the seas
SMODS.Joker {
  object_type = "Joker",
name = "mtg-harbinger",
  key = "harbinger",
  pos = {
      x = 3,
      y = 4
  },
  atlas = 'mtg_atlas',
cost = 8,
order = 3,
rarity = 3,
  config = {},
  loc_vars = function(self, info_queue, card)
    return { }
  end
}

--Jokulmorder
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-jokulmorder",
	key = "jokulmorder",
	pos = { x = 6, y = 2 },
	config = { extra = {awoken = false, required = 5, power = 2}},
  order = 4,
	rarity = 2,
	cost = 7,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.required, center.ability.extra.power}}
	end,
	calculate = function(self, card, context)
  if context.pre_discard then
    local suits = {
      ['Clubs'] = 0
  }
  for k, v in ipairs(context.full_hand) do
    if v:is_suit('Clubs') then suits["Clubs"] = suits["Clubs"] + 1 end
  end
   if suits["Clubs"] >= card.ability.extra.required then
    card.ability.extra.awoken = true
    local eval = function() return not G.RESET_JIGGLES end
    juice_card_until(card, eval, true)
    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('mtg_awoken_ex')})
   end
  elseif context.individual then
      if context.cardarea == G.play then
        if context.other_card:is_suit('Clubs') and card.ability.extra.awoken then
          return {
					colour = G.C.RED,
            x_mult = card.ability.extra.power,
            card = card
          }
        end
      end
    elseif context.end_of_round then
      if not context.blueprint then
          if card.ability.extra.awoken then
            card.ability.extra.awoken = false
              return {
                  message = localize('mtg_slumber_ex')
              }
          end
        end
    end
	end
}

--ascendant evincar
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-evincar",
	key = "evincar",
	pos = { x = 4, y = 3 },
	config = { extra = {bonus_mult = 10, neg_mult = 10} },
  order = 5,
	rarity = 2,
	cost = 8,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.bonus_mult, center.ability.extra.neg_mult} }
	end,
	calculate = function(self, card, context)
    if context.individual then
      if context.cardarea == G.play then
        if context.other_card:is_suit('Spades') then
          return {
            mult = card.ability.extra.bonus_mult,
            card = card
          }
        else
          return {
            mult = -1 * card.ability.extra.neg_mult,
            card = card
          }
        end
      end
    end
  end
}

--relentless rats
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-relentlessrats",
	key = "relentlessrats",
	pos = { x = 1, y = 3 },
	config = { extra = { base_mult = 5} },
  order = 6,
	rarity = 1,
	cost = 3,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.base_mult} }
	end,
	calculate = function(self, card, context)
    if context.joker_main then
      local mult = (card.ability.extra.base_mult * #find_joker("mtg-relentlessrats")) or 0
      return {
        mult_mod = mult,
        message = localize({ type = "variable", key = "a_mult", vars = { mult } })
      }
		end
	end,
  in_pool = function(self)
    return true, { allow_duplicates = true }
  end
}

--Urborg
SMODS.Joker {
    object_type = "Joker",
  name = "mtg-urborg",
    key = "urborg",
    pos = {
        x = 5,
        y = 3
    },
    atlas = 'mtg_atlas',
  cost = 8,
  order = 7,
  rarity = 3,
    config = {},
    loc_vars = function(self, info_queue, card)
      return { }
    end
}

--Blood moon
SMODS.Joker {
  object_type = "Joker",
name = "mtg-bloodmoon",
  key = "bloodmoon",
  pos = {
      x = 5,
      y = 4
  },
  atlas = 'mtg_atlas',
cost = 8,
order = 8,
rarity = 3,
  config = {},
  loc_vars = function(self, info_queue, card)
    return { }
  end
}

--vortex
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-vortex",
	key = "vortex",
	pos = { x = 4, y = 2 },
	config = { extra = {damage_blind = 2, damage_hand = 2}},
  order = 9,
	rarity = 2,
	cost = 6,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
    info_queue[#info_queue + 1] = { key = "r_mtg_damage_blind", set = "Other", config = { extra = 1 } }
    info_queue[#info_queue + 1] = { key = "r_mtg_damage_card", set = "Other", config = { extra = 1 } }
		return { vars = {center.ability.extra.damage_blind, center.ability.extra.damage_hand}}
	end,
	calculate = function(self, card, context)
    if context.before then
      bonus_damage(card, card.ability.extra.damage_blind)
      local target = pseudorandom_element(G.hand.cards, pseudoseed('mtg-vortex'))
      if target then damage_card(target, card.ability.extra.damage_hand) end
    end
end
}

--Torbran, Thane of Red Fell
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-torbran",
	key = "torbran",
	pos = { x = 2, y = 4 },
	config = { extra = { damage_bonus = 2, damage_red = 2} },
  order = 10,
	rarity = 2,
	cost = 6,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
    info_queue[#info_queue + 1] = { key = "r_mtg_damage_blind", set = "Other", config = { extra = 1 } }
		return { vars = { center.ability.extra.damage_red, center.ability.extra.damage_bonus} }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
              local suits = {
                 ['Hearts'] = 0
             }
             for i = 1, #context.scoring_hand do
                     if context.scoring_hand[i]:is_suit('Hearts') then suits["Hearts"] = suits["Hearts"] + 1 end
             end
              if suits["Hearts"] >= 1 then
                bonus_damage(card, card.ability.extra.damage_red)
              end
        end
    end
}

--Baru
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-baru",
	key = "baru",
	pos = { x = 7, y = 2 },
	config = { extra = {strength = 1} },
  order = 11,
	rarity = 2,
	cost = 7,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.strength} }
	end,
	calculate = function(self, card, context)
    if context.before then
      local clovers = 0
      for k, v in ipairs(context.scoring_hand) do
        if v:is_suit(suit_clovers.key) then 
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

--beastmaster
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-beastmaster",
	key = "beastmaster",
	pos = { x = 5, y = 2 },
	config = { extra = {quest = 0, required = 7, chips = 25, mult = 5}},
  order = 12,
	rarity = 1,
	cost = 4,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.required, center.ability.extra.chips, center.ability.extra.mult, center.ability.extra.quest}}
	end,
	calculate = function(self, card, context)
    if context.joker_main then
      if card.ability.extra.quest < card.ability.extra.required then
        card.ability.extra.quest = card.ability.extra.quest + 1
        if card.ability.extra.quest >= card.ability.extra.required then
          local eval = function() return card.ability.extra.quest >= card.ability.extra.required end
          juice_card_until(card, eval, true)
          card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('mtg_complete_ex')})
        else
          card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('mtg_quest_ex')})
        end
      end
  elseif context.individual then
      if context.cardarea == G.play then
        if card.ability.extra.quest >= card.ability.extra.required then
          return {
					colour = G.C.GREEN,
          chips = card.ability.extra.chips,
            mult = card.ability.extra.mult,
            card = card
          }
        end
      end
	end
end
}

--yavimaya
SMODS.Joker {
  object_type = "Joker",
name = "mtg-yavimaya",
  key = "yavimaya",
  pos = {
      x = 3,
      y = 3
  },
  atlas = 'mtg_atlas',
cost = 8,
order = 13,
rarity = 3,
  config = {},
  loc_vars = function(self, info_queue, card)
    return { }
  end
}

--eldrazimonument
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-eldrazimonument",
	key = "eldrazimonument",
	pos = { x = 1, y = 5 },
	config = { extra = {bonus_mult = 3}},
	rarity = 2,
  order = 14,
	cost = 6,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.bonus_mult}}
	end,
	calculate = function(self, card, context)
    if context.individual then
      if context.cardarea == G.play then
        return {
            mult = card.ability.extra.bonus_mult,
            card = card
          }
      end
  elseif context.joker_main then
    if #G.hand.cards then
    local temp_ID = G.hand.cards[1].base.id
    local smallest = G.hand.cards[1]
                        for i=1, #G.hand.cards do
                            if temp_ID >= G.hand.cards[i].base.id and G.hand.cards[i].ability.effect ~= 'Stone Card' then temp_ID = G.hand.cards[i].base.id; smallest = G.hand.cards[i] end
                        end
                        if smallest.debuff then
                                return {
                                    message = localize('k_debuffed'),
                                    colour = G.C.RED,
                                    card = self,
                                }
                            else
                              G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.15,
                                func = function()
                                  if smallest.ability.name == "Glass Card" then
                                    smallest:shatter()
                                else
                                  smallest:start_dissolve(nil, true)
                                end
                                return true
                                end}))
                              
                                return {
                                  message = localize('mtg_sacrifice_ex'),
                                    card = self
                                }
                            end
                      end
  end
  end
}

--helmofawakening
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-helmofawakening",
	key = "helmofawakening",
	pos = { x = 2, y = 5 },
	config = { extra = {discount = 1}},
  order = 15,
	rarity = 2,
	cost = 6,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.discount}}
	end,
  add_to_deck = function(self, card, from_debuff)
		for k, v in pairs(G.I.CARD) do
      if v.set_cost then v:set_cost() end
    end
	end,
	remove_from_deck = function(self, card, from_debuff)
		for k, v in pairs(G.I.CARD) do
      if v.set_cost then v:set_cost() end
    end
	end,
	calculate = function(self, card, context)
end
}

-- Lantern of Insight
-- + mult equal to value of top card
-- it tells you what the top card is
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-lantern",
	key = "lantern",
	pos = { x = 2, y = 3},
	config = { extra = { mult_per = 2} },
  order = 16,
	rarity = 1,
	cost = 4,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
    local current_value = G.deck and G.deck.cards[#G.deck.cards].base.nominal * center.ability.extra.mult_per or "?"
    local suit_prefix = (G.deck and G.deck.cards[#G.deck.cards].base.id or "?")
    local rank_suffix = (G.deck and G.deck.cards[#G.deck.cards].base.suit:sub(1,1) or '?')
		return { vars = { center.ability.extra.mult_per, current_value, suit_prefix..rank_suffix }}
	end,
	calculate = function(self, card, context)
    if context.joker_main then
			local top_card = G.deck.cards[#G.deck.cards]
      return {
        mult_mod = top_card.ability.t_chips * card.ability.extra.mult_per,
        message = localize({ type = "variable", key = "a_mult", vars = { top_card.base.nominal * card.ability.extra.mult_per } })
      }
		end
	end
}

--power matrix
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-powermatrix",
	key = "powermatrix",
	pos = { x = 0, y = 5 },
	config = { extra = {buff = 1}},
  order = 17,
	rarity = 2,
	cost = 6,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.buff}}
	end,
	calculate = function(self, card, context)
  if context.first_hand_drawn then
    local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES end
        juice_card_until(card, eval, true)
  elseif context.discard then
      if G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1 then
        local _card = context.full_hand[1]
        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.15,
          func = function()
            _card:flip(); play_sound('card1', 1.15); _card:juice_up(0.3,
                  0.3); return true
          end
      }))
        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.1,
          func = function()
            local cen_pool = {}
            for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
              if v.key ~= 'm_stone' and not v.overrides_base_rank then
                cen_pool[#cen_pool + 1] = v
              end
            end
            local enhancement = pseudorandom_element(cen_pool, pseudoseed("mtg-powermatrix"))
            _card:set_ability(enhancement, nil, true)
            buff_card(_card, card.ability.extra.buff)
            return true
          end
      }))
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          _card:flip(); play_sound('tarot2', 0.85, 0.6); _card:juice_up(0.3, 0.3); return true
        end
    }))
        return {
            message = localize('mtg_buff_ex'),
            card = card
        }
    end
    end
end
}

--Urza's Mine
-- +50 chips, additional +150 chips if you have all
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-urzamine",
	key = "urzamine",
	pos = { x = 0, y = 4 },
	config = { extra = { base_chips = 50, bonus_chips = 150} },
  order = 18,
	rarity = 1,
	cost = 4,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.base_chips, center.ability.extra.bonus_chips} }
	end,
	calculate = function(self, card, context)
    if context.joker_main then
			local active = next(find_joker("mtg-urzapower")) and next(find_joker("mtg-urzatower"))
      local chip = card.ability.extra.base_chips
      if active then
        chip = chip + card.ability.extra.bonus_chips
      end
      return {
        chip_mod = chip,
        message = localize({ type = "variable", key = "a_chips", vars = { chip } })
      }
		end
	end
}

--Urza's Power-Plant
-- +8 mult, additional +32 mult if you have all
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-urzapower",
	key = "urzapower",
	pos = { x = 6, y = 3 },
	config = { extra = { base_mult = 8, bonus_mult = 32} },
  order = 19,
	rarity = 1,
	cost = 4,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.base_mult, center.ability.extra.bonus_mult} }
	end,
	calculate = function(self, card, context)
    if context.joker_main then
			local active = next(find_joker("mtg-urzamine")) and next(find_joker("mtg-urzatower"))
      local mult = card.ability.extra.base_mult
      if active then
        mult = mult + card.ability.extra.bonus_mult
      end
      return {
        mult_mod = mult,
        message = localize({ type = "variable", key = "a_mult", vars = { mult } })
      }
		end
	end
}

--Urza's Tower
-- x1.5 mult, additional x1.5 mult if you have all
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-urzatower",
	key = "urzatower",
	pos = { x = 7, y = 3 },
	config = { extra = { base_xmult = 1.5, bonus_xmult = 1.5} },
  order = 20,
	rarity = 1,
	cost = 4,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.base_xmult, center.ability.extra.bonus_xmult} }
	end,
	calculate = function(self, card, context)
    if context.joker_main then
			local active = next(find_joker("mtg-urzapower")) and next(find_joker("mtg-urzamine"))
      local xmult = card.ability.extra.base_xmult
      if active then
        xmult = xmult + card.ability.extra.bonus_xmult
      end
      return {
        Xmult_mod = xmult,
        message = localize({ type = "variable", key = "a_xmult", vars = { xmult } })
      }
		end
	end
}
