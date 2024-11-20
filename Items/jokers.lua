
--Urborg
SMODS.Joker {
    object_type = "Joker",
  name = "mtg-urborg",
    key = "urborg",
    pos = {
        x = 3,
        y = 1
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

--Celestial dawn
SMODS.Joker {
  object_type = "Joker",
name = "mtg-celestialdawn",
  key = "celestialdawn",
  pos = {
      x = 3,
      y = 1
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

--Harbinger of the seas
SMODS.Joker {
  object_type = "Joker",
name = "mtg-harbinger",
  key = "harbinger",
  pos = {
      x = 3,
      y = 1
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

--Blood moon
SMODS.Joker {
  object_type = "Joker",
name = "mtg-bloodmoon",
  key = "bloodmoon",
  pos = {
      x = 3,
      y = 1
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

--Torbran, Thane of Red Fell
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-torbran",
	key = "torbran",
	pos = { x = 1, y = 0 },
	config = { extra = { damage_bonus = 2, damage_red = 2} },
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
                 ['Red'] = 0,
                 ['Black'] = 0
             }
             for i = 1, #context.scoring_hand do
                     if context.scoring_hand[i]:is_suit('Hearts') or context.scoring_hand[i]:is_suit('Diamonds') then suits["Red"] = suits["Red"] + 1
                  elseif context.scoring_hand[i]:is_suit('Spades') or context.scoring_hand[i]:is_suit('clubs') then suits["Black"] = suits["Black"] + 1 end
             end
              if suits["Red"] >= 1 then
                bonus_damage(card, card.ability.extra.damage_red)
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
	pos = { x = 0, y = 0 },
	config = { extra = { base_chips = 50, bonus_chips = 150} },
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
	pos = { x = 0, y = 0 },
	config = { extra = { base_mult = 8, bonus_mult = 32} },
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
	pos = { x = 0, y = 0 },
	config = { extra = { base_xmult = 1.5, bonus_xmult = 1.5} },
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

-- Lantern of Insight
-- + mult equal to value of top card
-- it tells you what the top card is
SMODS.Joker { 
	object_type = "Joker",
	name = "mtg-lantern",
	key = "lantern",
	pos = { x = 0, y = 0 },
	config = { extra = { mult_per = 2} },
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