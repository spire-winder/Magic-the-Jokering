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
    if context.individual and not context.repetition then
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

--etherium sculptor
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-etheriumsculptor",
	key = "etheriumsculptor",
	pos = { x = 11, y = 5 },
	config = { extra = { chips = 50} },
  order = 10,
	rarity = 2,
	cost = 4,
	atlas = "mtg_atlas",
  enhancement_gate = 'm_steel',
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.chips } }
	end,
	calculate = function(self, card, context)
    if context.individual and not context.repetition then
      if context.cardarea == G.play then
        if context.other_card.ability.name == 'Steel Card' then
          return {
            chips = card.ability.extra.chips,
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
    info_queue[#info_queue + 1] = { key = "r_mtg_slumber", set = "Other", config = { extra = 1 } }
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
  elseif context.individual and not context.repetition then
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

--Laboratory Maniac
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-labman",
	key = "labman",
	pos = { x = 9, y = 5 },
	config = { extra = {multi = 10}},
  order = 4,
	rarity = 3,
	cost = 6,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.multi}}
	end,
	calculate = function(self, card, context)
    if context.joker_main then
      if #G.deck.cards == 0 then
        return {
            message = localize{type='variable',key='a_xmult',vars={card.ability.extra.multi}},
            Xmult_mod = card.ability.extra.multi, 
            colour = G.C.Mult
        }
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
    if context.individual and not context.repetition then
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
    info_queue[#info_queue + 1] = { key = "r_mtg_relentless", set = "Other", config = { extra = 1 } }
		return { vars = { center.ability.extra.base_mult} }
	end,
	calculate = function(self, card, context)
    if context.joker_main then
      local mult = (card.ability.extra.base_mult * #SMODS.find_card("j_mtg_relentlessrats")) or 0
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

--Waste not, gives you money, cards, or +mult when you discard cards
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-wastenot",
	key = "wastenot",
	pos = { x = 7, y = 5 },
	config = { extra = {money = 2, damage = 2, cards = 2}},
  order = 17,
	rarity = 2,
	cost = 6,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
    info_queue[#info_queue + 1] = { key = "r_mtg_damage_blind", set = "Other", config = {extra = 1}, vars = { current_blind_life() or "?"}}
		return { vars = {center.ability.extra.money, center.ability.extra.damage, center.ability.extra.cards}}
	end,
	calculate = function(self, card, context)
    if context.pre_discard then
      local total_faces = 0
      for key, value in pairs(context.full_hand) do
        if not value.debuff and value:is_face() then total_faces = total_faces + 1 end
      end
      if total_faces > 0 then
        damage_blind(card, card.ability.extra.damage, total_faces)
      end
    elseif context.discard then
      if not context.other_card.debuff then
        if context.other_card:get_id() == 14 then
          ease_dollars(card.ability.extra.money)
          return {
            message = localize('$')..card.ability.extra.money,
            colour = G.C.MONEY,
            card = card
          }
        elseif not context.other_card:is_face() then
          G.FUNCS.draw_from_deck_to_hand(card.ability.extra.cards)
        end
      end
    end
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

--Fiery Emancipation
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-emancipation",
	key = "emancipation",
	pos = { x = 11, y = 4 },
	config = { extra = { damage_mult = 3} },
  order = 10,
	rarity = 3,
	cost = 8,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
		return { vars = { } }
	end,
	calculate = function(self, card, context)
    end
}

--Reckless bushwacker
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-bushwacker",
	key = "bushwacker",
	pos = { x = 8, y = 6 },
	config = { extra = { x_mult = 1.25} },
  order = 10,
	rarity = 1,
	cost = 3,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.x_mult } }
	end,
	calculate = function(self, card, context)
    if context.individual and not context.repetition then
      if context.cardarea == G.play then
        if G.GAME.current_round.hands_played == 0 then
          card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("mtg_haste_ex"), colour = G.C.RED})
          return {
            x_mult = card.ability.extra.x_mult,
            card = card
          }
        end
      end
    end
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
    info_queue[#info_queue + 1] = { key = "r_mtg_damage_blind", set = "Other", config = {extra = 1}, vars = { current_blind_life() or "?"}}
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
    info_queue[#info_queue + 1] = { key = "r_mtg_damage_blind", set = "Other", config = {extra = 1}, vars = { current_blind_life() or "?"}}
		return { vars = { center.ability.extra.damage_red, center.ability.extra.damage_bonus} }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
          local hearts_total = 0
             for i = 1, #context.scoring_hand do
                     if context.scoring_hand[i]:is_suit('Hearts') then hearts_total = hearts_total + 1 end
             end
              if hearts_total >= 1 then
                bonus_damage(card, card.ability.extra.damage_red)
              end
        end
    end
}

--[[Baru
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
}]]

--beastmaster
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-beastmaster",
	key = "beastmaster",
	pos = { x = 5, y = 2 },
	config = { extra = {quest = 0, required = 7, chips = 5, mult = 5}},
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
  elseif context.individual and not context.repetition then
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

--Doubling Season
SMODS.Joker {
  object_type = "Joker",
	name = "mtg-doublingseason",
	key = "doublingseason",
	pos = { x = 1, y = 6 },
  order = 12,
	rarity = 2,
	cost = 6,
	atlas = "mtg_atlas",
  config = { extra = { repetitions = 1 } },
  calculate = function(self, card, context)
    -- Checks that the current cardarea is G.play, or the cards that have been played, then checks to see if it's time to check for repetition.
    -- The "not context.repetition_only" is there to keep it separate from seals.
    if context.cardarea == G.play and context.repetition and not context.repetition_only then
      -- context.other_card is something that's used when either context.individual or context.repetition is true
      -- It is each card 1 by 1, but in other cases, you'd need to iterate over the scoring hand to check which cards are there.
      if context.other_card:is_suit(suit_clovers.key) then
        return {
          message = localize("k_again_ex"),
          repetitions = card.ability.extra.repetitions,
          -- The card the repetitions are applying to is context.other_card
          card = card
        }
      end
    end
  end
}

--ivy lane denizen
--Played cards with Clover suit give +3 Mult when scored
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-ivylanedenizen",
	key = "ivylanedenizen",
	pos = { x = 8, y = 4 },
	config = { extra = {bonus_mult = 3} },
  order = 5,
	rarity = 1,
	cost = 5,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.bonus_mult, center.ability.extra.neg_mult} }
	end,
	calculate = function(self, card, context)
    if context.individual and not context.repetition then
      if context.cardarea == G.play then
        if context.other_card:is_suit(suit_clovers.key) then
          return {
            mult = card.ability.extra.bonus_mult,
            card = card
          }
        end
      end
    end
  end
}

--primalcrux
--Played cards with Clover suit give +3 Mult when scored
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-primalcrux",
	key = "primalcrux",
	pos = { x = 10, y = 4 },
	config = { extra = {extra = 0.05, x_mult = 1} },
  order = 5,
	rarity = 2,
	cost = 7,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.extra, center.ability.extra.x_mult} }
	end,
	calculate = function(self, card, context)
		if
			context.cardarea == G.jokers
			and (card.ability.extra.x_mult > 1)
			and not context.before
			and not context.after
		then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
				Xmult_mod = card.ability.extra.x_mult,
			}
		end
		if context.cardarea == G.play and context.individual and not context.blueprint and not context.repetition then
      if context.other_card:is_suit(suit_clovers.key) then
        card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.extra
        return {
          extra = { focus = card, message = localize("k_upgrade_ex") },
          card = card,
          colour = G.C.MULT,
        }
      end
		end
	end,
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

--[[Yorvo, Lord of Garenbrig
--Starts at +4 mult, gets +2 mult whenever you play a hand with a clover
SMODS.Joker {
	object_type = "Joker",
	name = "mtg-yorvo",
	key = "yorvo",
	pos = { x = 3, y = 5 },
	config = { mult = 4, extra = {bonus_mult = 2} },
  order = 5,
	rarity = 2,
	cost = 6,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.bonus_mult, center.ability.mult} }
	end,
	calculate = function(self, card, context)
    if context.joker_main then
      if card.ability.mult > 0 then
        return {
            message = localize{type='variable',key='a_mult',vars={card.ability.mult}},
            mult_mod = card.ability.mult
        }
      end
  elseif context.before then
        if not context.blueprint then
          local clovers_total = 0
         for i = 1, #context.scoring_hand do
                 if context.scoring_hand[i]:is_suit(suit_clovers.key) then clovers_total = clovers_total + 1 end
         end
          if clovers_total >= 1 then
            card.ability.mult = card.ability.mult + card.ability.extra.bonus_mult
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED,
                card = card
            }
          end
            
        end
      end
  end
}]]

--Goblin Anarchomancer
--Played cards with Clover or Heart suit give x1.25 Mult when scored
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-anarchomancer",
	key = "anarchomancer",
	pos = { x = 10, y = 5 },
	config = { extra = {bonus_x_mult = 1.2} },
  order = 5,
	rarity = 1,
	cost = 5,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.bonus_x_mult} }
	end,
	calculate = function(self, card, context)
    if context.individual and not context.repetition then
      if context.cardarea == G.play then
        if context.other_card:is_suit(suit_clovers.key) or context.other_card:is_suit("Hearts") then
          return {
            x_mult = card.ability.extra.bonus_x_mult,
            card = card
          }
        end
      end
    end
  end
}

--knotvine mystic
-- X3 mult if all cards held in hand are diamonds, hearts, or clovers
SMODS.Joker {
	object_type = "Joker",
	name = "mtg-knotvine",
	key = "knotvine",
	pos = { x = 5, y = 5 },
	config = { extra = {x_mult_modifier = 2.5} },
  order = 5,
	rarity = 2,
	cost = 6,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.x_mult_modifier} }
	end,
	calculate = function(self, card, context)
    if context.joker_main then
      local naya_suits, all_cards = 0, 0
        for k, v in ipairs(G.hand.cards) do
          all_cards = all_cards + 1
          if v:is_suit('Diamonds', nil, true) or v:is_suit('Hearts', nil, true) or v:is_suit(suit_clovers.key, nil, true) then
            naya_suits = naya_suits + 1
          end
        end
        if naya_suits == all_cards then 
        return {
          message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult_modifier}},
          Xmult_mod = card.ability.extra.x_mult_modifier
        }
      end
    end
  end
}

--chromatic lantern
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-chromaticlantern",
	key = "chromaticlantern",
	pos = { x = 4, y = 5 },
	config = { extra = {bonus_mult = 0.5, suits = {}}},
	rarity = 3,
  order = 14,
	cost = 8,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.bonus_mult, center.ability.x_mult}}
	end,
	calculate = function(self, card, context)
    if context.individual and not context.repetition then
      if context.cardarea == G.play then
        if not context.other_card.debuff and not context.blueprint then
          local do_message = false
          for key, value in pairs(SMODS.Suits) do
            if context.other_card:is_suit(key) then
              if not card.ability.extra.suits[key] then
                card.ability.x_mult = card.ability.x_mult + card.ability.extra.bonus_mult
                card.ability.extra.suits[key] = 1
                do_message = true
              end
            end
          end
          if do_message then
            card_eval_status_text(card, 'extra', nil, nil, nil, {
              message = localize{type='variable',key='a_xmult',vars={card.ability.x_mult}},
                  colour = G.C.RED,
                  delay = 0.45
          })
          end
        end
      end
    elseif context.end_of_round and not context.blueprint then
      card.ability.extra.suits = {}
      if card.ability.x_mult > 1 then
        card.ability.x_mult = 1
        return {
            message = localize('k_reset'),
            colour = G.C.RED
        }
    end
  end
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
    if context.individual and not context.repetition then
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
                                    card = card,
                                }
                            else
                              G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.15,
                                func = function()
                                  destroy_card(smallest, true)
                                return true
                                end}))
                              
                                return {
                                  message = localize('mtg_sacrifice_ex'),
                                    card = card
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

--[[mightstone
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-mightstone",
	key = "mightstone",
	pos = { x = 11, y = 4 },
	config = { extra = { mult = 2} },
  order = 10,
	rarity = 1,
	cost = 4,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
    if context.individual then
      if context.cardarea == G.play then
        return {
          mult = card.ability.extra.mult,
          card = card
        }
      end
    end
  end
}]]

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
  elseif context.pre_discard then
      if G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1 then
        local _card = context.full_hand[1]
        buff_card(_card, card.ability.extra.buff, 1, "random")
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
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
	config = { extra = { base_chips = 50, bonus_chips = 200} },
  order = 18,
	rarity = 1,
	cost = 4,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.base_chips, center.ability.extra.bonus_chips} }
	end,
	calculate = function(self, card, context)
    if context.joker_main then
			local active = next(SMODS.find_card("j_mtg_urzapower")) and next(SMODS.find_card("j_mtg_urzatower"))
      local chip
      if active then
        chip = card.ability.extra.bonus_chips
      else
        chip = card.ability.extra.base_chips
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
	config = { extra = { base_mult = 6, bonus_mult = 36} },
  order = 19,
	rarity = 1,
	cost = 4,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.base_mult, center.ability.extra.bonus_mult} }
	end,
	calculate = function(self, card, context)
    if context.joker_main then
			local active = next(SMODS.find_card("j_mtg_urzamine")) and next(SMODS.find_card("j_mtg_urzatower"))
      local mult
      if active then
        mult = card.ability.extra.bonus_mult
      else
        mult = card.ability.extra.base_mult
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
	config = { extra = { base_xmult = 1.5, bonus_xmult = 3} },
  order = 20,
	rarity = 1,
	cost = 4,
	atlas = "mtg_atlas",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.base_xmult, center.ability.extra.bonus_xmult} }
	end,
	calculate = function(self, card, context)
    if context.joker_main then
			local active = next(SMODS.find_card("j_mtg_urzapower")) and next(SMODS.find_card("j_mtg_urzamine"))
      local xmult
      if active then
        xmult = card.ability.extra.bonus_xmult
      else
        xmult = card.ability.extra.base_xmult
      end
      return {
        Xmult_mod = xmult,
        message = localize({ type = "variable", key = "a_xmult", vars = { xmult } })
      }
		end
	end
}
