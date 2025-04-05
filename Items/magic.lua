SMODS.ConsumableType {
    object_type = "ConsumableType",
    key = 'Magic',
    default = 'c_mtg_obliterate',
    collection_rows = { 3,4 },
    primary_colour = HEX("321d0e"),
    secondary_colour = HEX("97572b"),
    loc_txt = {
        collection = 'Magic Cards',
        name = 'Magic',
        label = 'Magic',
        undiscovered = {
            name = "Not Discovered",
            text = {
                "Purchase or use",
                "this card in an",
                "unseeded run to",
                "learn what it does"
            },
        },
    },
}

SMODS.UndiscoveredSprite {
    object_type = "UndiscoveredSprite",
    key = "Magic",
    atlas = "mtg_back",
    pos = {
        x = 0,
        y = 0,
    }
}

--Astral Steel
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-astralsteel",
  key = "astralsteel",
  pos = {
      x = 3,
      y = 1
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 1,
  config = {extra = {strength = 2, targets = 1}},
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "r_mtg_storm_count", set = "Other", config = {extra = 1}, vars = { G.GAME.mtg_storm_count or "?"}}
    return { vars = {card.ability.extra.targets, card.ability.extra.strength} }
  end,
can_use = function(self, card)
    return #G.hand.highlighted <= card.ability.extra.targets and #G.hand.highlighted > 0
end,
use = function(self, card, area, copier)
  local used_tarot = copier or card
  G.E_MANAGER:add_event(Event({
  trigger = 'after',
  delay = 0.4,
  func = function()
      play_sound('tarot1')
      used_tarot:juice_up(0.3, 0.5)
      return true
  end
}))
  G.FUNCS.buff_cards(G.hand.highlighted, card.ability.extra.strength, G.GAME.mtg_storm_count)
G.E_MANAGER:add_event(Event({
  trigger = 'after',
  delay = 0.2,
  func = function()
      G.hand:unhighlight_all(); return true
  end
}))
delay(0.5)
end,
}

--defiant strike
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-defiantstrike",
  key = "defiantstrike",
  pos = {
      x = 12,
      y = 0
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 1,
  config = {extra = {targets = 1, buff = 1, cards = 1}},
  loc_vars = function(self, info_queue, card)
    return { vars = {card.ability.extra.targets, card.ability.extra.buff, card.ability.extra.cards} }
  end,
can_use = function(self, card)
    local num_highlighted = #G.hand.highlighted
    return num_highlighted <= card.ability.extra.targets and num_highlighted > 0
end,
use = function(self, card, area, copier)
  local used_tarot = copier or card
  G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    used_tarot:juice_up(0.3, 0.5)
                    return true
                end
            }))
              G.FUNCS.buff_cards(G.hand.highlighted, card.ability.extra.buff, 1)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all(); return true
                end
            }))
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
              
              G.FUNCS.draw_from_deck_to_hand(card.ability.extra.cards)
            return true end }))
            card_eval_status_text(copier or card, 'extra', nil, nil, nil, {message = localize('mtg_draw_ex')})
end
}

--Fell the Mighty
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-fellthemighty",
  key = "fellthemighty",
  pos = {
      x = 15,
      y = 0
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 1,
  config = {extra = {targets = 1}},
  loc_vars = function(self, info_queue, card)
    return { vars = {card.ability.extra.targets} }
  end,
can_use = function(self, card)
    local num_highlighted = #G.hand.highlighted
    return num_highlighted <= card.ability.extra.targets and num_highlighted > 0
end,
use = function(self, card, area, copier)
  local used_tarot = copier or card
  G.E_MANAGER:add_event(Event({
  trigger = 'after',
  delay = 0.4,
  func = function()
      play_sound('tarot1')
      used_tarot:juice_up(0.3, 0.5)
      return true
  end
}))
local temp_hand = {}
            for k, v in ipairs(G.hand.cards) do
                if not v.ability.eternal and v.base.id > G.hand.highlighted[1].base.id then
                    temp_hand[#temp_hand + 1] = v
                end
            end
              
            G.E_MANAGER:add_event(Event({
              trigger = "after",
              delay = 0.1,
              func = function()
                      destroy_cards(temp_hand)
                  return true
              end,
            }))
end
}

--raise the alarm
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-raisethealarm",
  key = "raisethealarm",
  pos = {
      x = 9,
      y = 1
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 19,
  config = { extra = {guys = 2}},
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "r_mtg_soldier", set = "Other", config = { extra = 1 } , vars = { 2 } }
    return { vars = {card.ability.extra.guys}}
  end,
can_use = function(self, card)
    return #G.hand.cards > 0
end,
use = function(self, card, area, copier)
  local used_tarot = card or copier
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        play_sound('tarot1')
        used_tarot:juice_up(0.3, 0.5)
        return true end }))
          G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4,func = function()
            local _suit, _rank = SMODS.Suits["Diamonds"].card_key, "2"
            for i=1,card.ability.extra.guys do
              create_playing_card({front = G.P_CARDS[_suit..'_'.._rank], center = token_soldier}, G.hand, nil, i ~= 1, {G.C.SECONDARY_SET.Magic})
              G.hand:sort()
            end
            return true end }))
end,
}

--Wrath of God
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-wrathofgod",
  key = "wrathofgod",
  pos = {
      x = 5,
      y = 1
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 2,
  config = {},
  loc_vars = function(self, info_queue, card)
    return {}
  end,
can_use = function(self, card)
    return #G.hand.cards > 0
end,
use = function(self, card, area, copier)
  local used_tarot = card or copier
            local temp_hand = {}
            for k, v in ipairs(G.hand.cards) do
                if not v.ability.eternal then
                    temp_hand[#temp_hand + 1] = v
                end
            end
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    if used_tarot and used_tarot.juice_up then
                        used_tarot:juice_up(0.3, 0.5)
                    end
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                        destroy_cards(temp_hand)
                    return true
                end,
            }))
end,
}

--Ancestral Recall
SMODS.Consumable ({
    object_type = "Consumable",
    set = "Magic",
    name = "mtg-ancestral",
    key = "ancestral",
    pos = {
        x = 3,
        y = 2
    },
    atlas = 'mtg_atlas',
    cost = 3,
    order = 3,
      config = { extra = { cards = 3} },
      loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards } }
      end,
    can_use = function(self, card)
        return #G.hand.cards > 0
    end,
    use = function(self, card, area, copier)
      local used_tarot = card or copier
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        play_sound('tarot1')
        used_tarot:juice_up(0.3, 0.5)
        return true end }))
          G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            G.FUNCS.draw_from_deck_to_hand(card.ability.extra.cards)
        return true end }))
        
        card_eval_status_text(copier or card, 'extra', nil, nil, nil, {message = localize('mtg_draw_ex')})
    end,
})

--clone legion
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-clonelegion",
  key = "clonelegion",
  pos = {
      x = 13,
      y = 0
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 2,
  config = {},
  loc_vars = function(self, info_queue, card)
    return {}
  end,
can_use = function(self, card)
    return #G.hand.cards > 0
end,
use = function(self, card, area, copier)
  local used_tarot = card or copier
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    if used_tarot and used_tarot.juice_up then
                        used_tarot:juice_up(0.3, 0.5)
                    end
                    return true
                end,
            }))
            for i=1,#G.hand.cards do
              G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay=0.1,
                func = function()
                    G.hand.cards[i]:juice_up(0.3, 0.5)
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local _card = copy_card(G.hand.cards[i], nil, nil, G.playing_card)
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
          end
end,
}

--mind's desire
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-mindsdesire",
  key = "mindsdesire",
  pos = {
      x = 2,
      y = 1
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 4,
  config = { extra = {num_tarot = 1}},
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "r_mtg_storm_count", set = "Other", config = {extra = 1}, vars = { G.GAME.mtg_storm_count or "?"}}
    return { vars = {card.ability.extra.num_tarot, G.GAME.mtg_storm_count}}
  end,
can_use = function(self, card)
    return true
end,
use = function(self, card, area, copier)
  local used_tarot = card or copier
  for i=1, G.GAME.mtg_storm_count do
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4 / i, func = function()
      play_sound('tarot1')
      used_tarot:juice_up(0.3, 0.5)
      return true end }))
    G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4 / i,
			func = function()
        for i=1,card.ability.extra.num_tarot do
          play_sound('timpani')
          local card = create_card('Magic', G.consumeables, nil, nil, nil, nil, nil, "mtg-mindsdesire")
          card:set_edition({negative = true}, true)
          card:add_to_deck()
          G.consumeables:emplace(card)
          return true
        end
			end,
		}))
  end
end,
}

--Negate
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-negate",
  key = "negate",
  pos = {
      x = 0,
      y = 2
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 5,
  config = {},
  loc_vars = function(self, info_queue, card)
    return { }
  end,
can_use = function(self, card)
    return G.GAME.blind and ((not G.GAME.blind.disabled) and (G.GAME.blind:get_type() == 'Boss'))
end,
use = function(self, card, area, copier)
  local used_tarot = card or copier
G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
    play_sound('tarot1')
    used_tarot:juice_up(0.3, 0.5)
    return true end }))
  if G.GAME.blind and ((not G.GAME.blind.disabled) and (G.GAME.blind:get_type() == 'Boss')) then 
    card_eval_status_text(card or copier, 'extra', nil, nil, nil, {message = localize('k_nope_ex')})
    G.GAME.blind:disable()
end
end,
}

--Bloodsoaked Altar
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-bloodsoakedaltar",
  key = "bloodsoakedaltar",
  pos = {
      x = 11,
      y = 1
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 10,
  config = {extra = { targets = 1}},
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "r_mtg_demon", set = "Other", config = { extra = 1 } , vars = { 2 } }
    return { vars = { card.ability.extra.targets} }
  end,
can_use = function(self, card)
    return #G.hand.highlighted <= card.ability.extra.targets and #G.hand.highlighted > 0
end,
use = function(self, card, area, copier)
  destroyed_cards = {}
  local used_tarot = card or copier
  for i=#G.hand.highlighted, 1, -1 do
    destroyed_cards[#destroyed_cards+1] = G.hand.highlighted[i]
end
G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
    play_sound('tarot1')
    used_tarot:juice_up(0.3, 0.5)
    return true end }))
G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = 0.2,
    func = function() 
        destroy_cards(G.hand.highlighted)
        return true end }))
  G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            local _suit, _rank = SMODS.Suits["Spades"].card_key, "6"
    create_playing_card({front = G.P_CARDS[_suit..'_'.._rank], center = token_demon}, G.hand, nil, i ~= 1, {G.C.SECONDARY_SET.Magic})
    G.hand:sort()
    return true
  end
  }))
end,
}

--Booster Tutor
SMODS.Consumable {
	object_type = "Consumable",
	set = "Magic",
	name = "mtg-boostertutor",
	key = "boostertutor",
	pos = { x = 1, y = 4 },
  cost=6,
	order = 6,
	atlas = "mtg_atlas",
	can_use = function(self, card)
		return true
	end,
  config = { extra = {}},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { set = "Other", key = "p_mtg_magic_pack", specific_vars = { 1, 4 } }
	  return { vars = {  } }
	end,
	use = function(self, card, area, copier)
    local used_tarot = card or copier
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
      play_sound('timpani')
      used_tarot:juice_up(0.3, 0.5)
      return true end }))
		delay(0.6)
    add_tag(Tag('tag_mtg_bigmagictag'))
	end,
}

--One With Nothing
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-onewithnothing",
  key = "onewithnothing",
  pos = {
      x = 2,
      y = 2
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 7,
  config = {},
  loc_vars = function(self, info_queue, card)
    return {}
  end,
can_use = function(self, card)
    return #G.hand.cards > 0
end,
use = function(self, card, area, copier)
  local used_tarot = card or copier
G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
    play_sound('tarot1')
    used_tarot:juice_up(0.3, 0.5)
    return true end }))
  G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
    G.FUNCS.draw_from_hand_to_discard()
return true end }))
return true
end,
}

--Reanimate
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-reanimate",
  key = "reanimate",
  pos = {
      x = 7,
      y = 4
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 8,
  config = { },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "r_mtg_reanimate", set = "Other", config = {extra = 1}}
    return { vars = {} }
  end,
can_use = function(self, card)
    return (G.GAME.jokers_sold and #G.GAME.jokers_sold) and (#G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers)
end,
use = function(self, card, area, copier)
  local used_tarot = copier or card
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
              play_sound('timpani')
              reanimate()
              used_tarot:juice_up(0.3, 0.5)
              return true end }))
              card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("mtg_reanimate_ex"), colour = G.C.BLACK})
end,
}

--Reaping the Graves
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-reaping",
  key = "reaping",
  pos = {
      x = 1,
      y = 1
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 9,
  config = {},
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "r_mtg_storm_count", set = "Other", config = {extra = 1}, vars = { G.GAME.mtg_storm_count or "?"}}
    return { vars = {G.GAME.mtg_storm_count}}
  end,
can_use = function(self, card)
    return #G.hand.cards > 0
end,
use = function(self, card, area, copier)
  local used_tarot = card or copier
  for i=1, G.GAME.mtg_storm_count do
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4 / i, func = function()
      play_sound('tarot1')
      used_tarot:juice_up(0.3, 0.5)
      return true end }))
    G.FUNCS.draw_from_discard_to_hand(1)
    delay(0.4 / i)
  end
end,
}

--Village Rites
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-villagerites",
  key = "villagerites",
  pos = {
      x = 7,
      y = 1
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 10,
  config = {extra = { targets = 1, cards = 2}},
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.targets, card.ability.extra.cards } }
  end,
can_use = function(self, card)
    return #G.hand.highlighted <= card.ability.extra.targets and #G.hand.highlighted > 0
end,
use = function(self, card, area, copier)
  destroyed_cards = {}
  local used_tarot = card or copier
  for i=#G.hand.highlighted, 1, -1 do
    destroyed_cards[#destroyed_cards+1] = G.hand.highlighted[i]
end
G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
    play_sound('tarot1')
    used_tarot:juice_up(0.3, 0.5)
    return true end }))
G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = 0.2,
    func = function()
            destroy_cards(G.hand.highlighted)
        return true end }))
  G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
    G.FUNCS.draw_from_deck_to_hand(card.ability.extra.cards)
    return true
  end
  }))
end,
}

--Anger of the gods
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-angerofthegods",
  key = "angerofthegods",
  pos = {
      x = 4,
      y = 0
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 11,
  config = {extra = {damage = 3}},
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "r_mtg_damage_card", set = "Other", config = { extra = 1 } }
    return { vars = { card.ability.extra.damage } }
  end,
can_use = function(self, card)
    return #G.hand.cards > 0
end,
use = function(self, card, area, copier)
  local used_tarot = card or copier
  G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
    play_sound('tarot1')
    used_tarot:juice_up(0.3, 0.5)
    return true end }))
    for i=1, #G.hand.cards do
        damage_card(G.hand.cards[i], card.ability.extra.damage)
    end
end,
}

--empty the warrens
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-emptythewarrens",
  key = "emptythewarrens",
  pos = {
      x = 9,
      y = 4
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 19,
  config = { extra = {gobbos = 2}},
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "r_mtg_storm_count", set = "Other", config = {extra = 1}, vars = { G.GAME.mtg_storm_count or "?"}}
    info_queue[#info_queue + 1] = { key = "r_mtg_goblin", set = "Other", config = { extra = 1 } , vars = { 1 } }
    return { vars = {card.ability.extra.gobbos}}
  end,
can_use = function(self, card)
    return #G.hand.cards > 0
end,
use = function(self, card, area, copier)
  local used_tarot = card or copier
  for i=1, G.GAME.mtg_storm_count do
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4 / i, func = function()
        play_sound('tarot1')
        used_tarot:juice_up(0.3, 0.5)
        return true end }))
          G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4 / i,func = function()
            local _suit, _rank = SMODS.Suits["Hearts"].card_key, "2"
            for i=1,card.ability.extra.gobbos do
              create_playing_card({front = G.P_CARDS[_suit..'_'.._rank], center = token_goblin}, G.hand, nil, i ~= 1, {G.C.SECONDARY_SET.Magic})
              G.hand:sort()
            end
            return true end }))
          end
  return true
end,
}

--Flame Slash
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-flameslash",
  key = "flameslash",
  pos = {
      x = 3,
      y = 0
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 12,
  config = {extra = {damage = 4, targets = 1}},
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "r_mtg_damage_card", set = "Other", config = { extra = 1 } }
    return { vars = { card.ability.extra.damage, card.ability.extra.targets } }
  end,
can_use = function(self, card)
    return (#G.hand.highlighted > 0) and #G.hand.highlighted <= card.ability.extra.targets
end,
use = function(self, card, area, copier)
  local used_tarot = card or copier
  G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
    play_sound('tarot1')
    used_tarot:juice_up(0.3, 0.5)
    return true end }))
    for i=1, #G.hand.highlighted do
        damage_card(G.hand.highlighted[i], card.ability.extra.damage)
    end
end,
}

--Grapeshot
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-grapeshot",
  key = "grapeshot",
  pos = {
      x = 1,
      y = 0
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 13,
  config = {extra = {damage = 1, targets = 1}},
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "r_mtg_storm_count", set = "Other", config = {extra = 1}, vars = { G.GAME.mtg_storm_count or "?"}}
    info_queue[#info_queue + 1] = { key = "r_mtg_any_target", set = "Other", config = { extra = 1 } }
    info_queue[#info_queue + 1] = { key = "r_mtg_damage_blind", set = "Other", config = {extra = 1}, vars = { current_blind_life() or "?"}}
    info_queue[#info_queue + 1] = { key = "r_mtg_damage_card", set = "Other", config = { extra = 1 } }
    return { vars = { card.ability.extra.damage,  card.ability.extra.targets} }
  end,
can_use = function(self, card)
    return (G.STATE == G.STATES.SELECTING_HAND or #G.hand.highlighted > 0) and #G.hand.highlighted <= card.ability.extra.targets
end,
use = function(self, card, area, copier)
  local used_tarot = card or copier
      G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        play_sound('tarot1')
        used_tarot:juice_up(0.3, 0.5)
        return true end }))
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
          if #G.hand.highlighted < 1 then
            damage_blind(card, card.ability.extra.damage, G.GAME.mtg_storm_count)
          else
            for i=1, #G.hand.highlighted do
              damage_card(G.hand.highlighted[i], card.ability.extra.damage, G.GAME.mtg_storm_count)
          end
        end
          return true end }))
    
end,
}

--Lava Axe
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-lavaaxe",
  key = "lavaaxe",
  pos = {
      x = 5,
      y = 0
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 14,
  config = {extra = {damage = 5}},
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "r_mtg_damage_blind", set = "Other", config = {extra = 1}, vars = { current_blind_life() or "?"}}
    return { vars = { card.ability.extra.damage } }
  end,
can_use = function(self, card)
    return (G.STATE == G.STATES.SELECTING_HAND)
end,
use = function(self, card, area, copier)
  local used_tarot = card or copier
  G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
    play_sound('tarot1')
    used_tarot:juice_up(0.3, 0.5)
    return true end }))
    damage_blind(card, card.ability.extra.damage)
end,
}

--Lightning Bolt
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-lightningbolt",
  key = "lightningbolt",
  pos = {
      x = 2,
      y = 0
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 15,
  config = {extra = {damage = 3, targets = 1}},
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "r_mtg_any_target", set = "Other", config = { extra = 1 } }
    info_queue[#info_queue + 1] = { key = "r_mtg_damage_blind", set = "Other", config = {extra = 1}, vars = { current_blind_life() or "?"}}
    info_queue[#info_queue + 1] = { key = "r_mtg_damage_card", set = "Other", config = { extra = 1 } }
    return { vars = { card.ability.extra.damage, card.ability.extra.targets } }
  end,
can_use = function(self, card)
    return (G.STATE == G.STATES.SELECTING_HAND or #G.hand.highlighted > 0) and #G.hand.highlighted <= card.ability.extra.targets
end,
use = function(self, card, area, copier)
  local used_tarot = card or copier
  G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
    play_sound('tarot1')
    used_tarot:juice_up(0.3, 0.5)
    return true end }))
    if #G.hand.highlighted < 1 then
      damage_blind(card, card.ability.extra.damage)
    else
      for i=1, #G.hand.highlighted do
        damage_card(G.hand.highlighted[i], card.ability.extra.damage)
    end
    end
end,
}

--Obliterate
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-obliterate",
  key = "obliterate",
  pos = {
      x = 6,
      y = 1
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 16,
  config = {},
  loc_vars = function(self, info_queue, card)
    return {}
  end,
can_use = function(self, card)
    return G.STATE == G.STATES.SELECTING_HAND
end,
use = function(self, card, area, copier)
  local used_tarot = card or copier
            local temp_hand = {}
            for k, v in ipairs(G.hand.cards) do
                if not v.ability.eternal then
                    temp_hand[#temp_hand + 1] = v
                end
            end
            for k, v in ipairs(G.jokers.cards) do
              if not v.ability.eternal then
                  temp_hand[#temp_hand + 1] = v
              end
          end
          for k, v in ipairs(G.consumeables.cards) do
            if not v.ability.eternal then
                temp_hand[#temp_hand + 1] = v
            end
        end
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    if used_tarot and used_tarot.juice_up then
                        used_tarot:juice_up(0.3, 0.5)
                    end
                    return true
                end,
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    destroy_cards(temp_hand)
                    return true
                end,
            }))
            instant_win()
end,
}

--Transmogrify
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-transmogrify",
  key = "transmogrify",
  pos = {
      x = 7,
      y = 0
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 17,
  config = { extra = {targets = 1}},
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.targets } }
  end,
can_use = function(self, card)
    return #G.hand.highlighted <= card.ability.extra.targets and #G.hand.highlighted > 0 and #G.deck.cards > 0
end,
use = function(self, card, area, copier)
  destroyed_cards = {}
  local used_tarot = card or copier
  for i=#G.hand.highlighted, 1, -1 do
    destroyed_cards[#destroyed_cards+1] = G.hand.highlighted[i]
end
G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
    play_sound('tarot1')
    used_tarot:juice_up(0.3, 0.5)
    return true end }))
G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = 0.2,
    func = function() 
        destroy_cards(G.hand.highlighted)
        return true end }))
        if G.deck.cards[1] then
          G.E_MANAGER:add_event(Event({
            trigger = "before",
            delay = 0.4,
            func = function()
              card:juice_up(0.3, 0.4)
              G.playing_card = (G.playing_card and G.playing_card + 1) or 1
              local _c = copy_card(G.deck.cards[#G.deck.cards], nil, nil, G.playing_card)
              _c:start_materialize()
              _c:add_to_deck()
              G.deck.config.card_limit = G.deck.config.card_limit + 1
              table.insert(G.playing_cards, _c)
              G.hand:emplace(_c)
              playing_card_joker_effects({ _c })
              return true
            end,
          }))
        end
end,
}

--Aspect of hydra
if MagicTheJokering.config.include_clover_suit then
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-aspecthydra",
  key = "aspecthydra",
  pos = {
      x = 6,
      y = 4
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 18,
  config = {extra = {strength = 1, targets = 1}},
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.targets, card.ability.extra.strength } }
  end,
can_use = function(self, card)
    return #G.hand.highlighted <= card.ability.extra.targets and #G.hand.highlighted > 0
end,
use = function(self, card, area, copier)
  local used_tarot = copier or card
  G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = 0.4,
    func = function()
      play_sound('tarot1')
      used_tarot:juice_up(0.3, 0.5)
      return true
    end
  }))
  local clover_count = 0
  for i = 1, #G.hand.cards do
    if G.hand.cards[i]:is_suit(suit_clovers.key) then clover_count = clover_count + 1 end
  end
    G.FUNCS.buff_cards(G.hand.highlighted, card.ability.extra.strength * clover_count, 1)
  G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = 0.2,
    func = function()
      G.hand:unhighlight_all(); return true
    end
  }))
  delay(0.5)
end,
}

--Chatterstorm
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-chatterstorm",
  key = "chatterstorm",
  pos = {
      x = 1,
      y = 2
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 19,
  config = {},
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "r_mtg_storm_count", set = "Other", config = {extra = 1}, vars = { G.GAME.mtg_storm_count or "?"}}
    info_queue[#info_queue + 1] = { key = "r_mtg_squirrel", set = "Other", config = { extra = 1 } , vars = { 6 } }
    return { vars = {G.GAME.mtg_storm_count}}
  end,
can_use = function(self, card)
    return #G.hand.cards > 0
end,
use = function(self, card, area, copier)
  local used_tarot = card or copier
  for i=1, G.GAME.mtg_storm_count do
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4 / i, func = function()
        play_sound('tarot1')
        used_tarot:juice_up(0.3, 0.5)
        return true end }))
          G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4 / i,func = function()
            local _suit, _rank = SMODS.Suits[suit_clovers.key].card_key, "2"
            create_playing_card({front = G.P_CARDS[_suit..'_'.._rank], center = token_squirrel}, G.hand, nil, i ~= 1, {G.C.SECONDARY_SET.Magic})
            G.hand:sort()

            return true end }))
          end
  return true
end,
}
end

--Giant Growth
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-giantgrowth",
  key = "giantgrowth",
  pos = {
      x = 4,
      y = 1
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 20,
  config = {extra = {strength = 3, targets = 1}},
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.targets, card.ability.extra.strength } }
  end,
can_use = function(self, card)
    return #G.hand.highlighted <= card.ability.extra.targets and #G.hand.highlighted > 0
end,
use = function(self, card, area, copier)
  local used_tarot = copier or card
  G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = 0.4,
    func = function()
      play_sound('tarot1')
      used_tarot:juice_up(0.3, 0.5)
      return true
    end
  }))
    G.FUNCS.buff_cards(G.hand.highlighted, card.ability.extra.strength , 1)
  G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = 0.2,
    func = function()
      G.hand:unhighlight_all(); return true
    end
  }))
  delay(0.5)
end,
}

--Monstrous Onslaught
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-monstrousonslaught",
  key = "monstrousonslaught",
  pos = {
      x = 14,
      y = 0
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 18,
  config = {extra = {}},
  loc_vars = function(self, info_queue, card)
    if (G.hand and G.hand.cards and G.hand.cards[1]) then 
      local temp_ID = G.hand.cards[1].base.id
      local largest = G.hand.cards[1]
      for i=1, #G.hand.cards do
        if temp_ID <= G.hand.cards[i].base.id and G.hand.cards[i].ability.effect ~= 'Stone Card' and not G.hand.cards[i].debuff then temp_ID = G.hand.cards[i].base.id; largest = G.hand.cards[i] end
      end
      return { vars = { largest.base.nominal} }
    else
      return {vars = {"???"}} end
  end,
can_use = function(self, card)
  return (G.STATE == G.STATES.SELECTING_HAND or #G.hand.highlighted > 0)
end,
  use = function(self, card, area, copier)
    local used_tarot = copier or card
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('tarot1')
        used_tarot:juice_up(0.3, 0.5)
        return true
      end
    }))
    local temp_ID = G.hand.cards[1].base.id
    local largest = G.hand.cards[1]
    for i=1, #G.hand.cards do
      if temp_ID <= G.hand.cards[i].base.id and G.hand.cards[i].ability.effect ~= 'Stone Card' and not G.hand.cards[i].debuff then temp_ID = G.hand.cards[i].base.id; largest = G.hand.cards[i] end
    end
    if #G.hand.highlighted < 1 then
      damage_blind(card, largest.base.nominal)
    else
      for i=1, #G.hand.highlighted do
        damage_card(G.hand.highlighted[i], math.floor(largest.base.nominal / #G.hand.highlighted))
      end
    end
  end,
}

--overrun
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-overrun",
  key = "overrun",
  pos = {
      x = 6,
      y = 0
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 21,
  config = {extra = {strength = 1}},
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.strength } }
  end,
can_use = function(self, card)
    return #G.hand.cards > 0
end,
use = function(self, card, area, copier)
  local used_tarot = card or copier
  G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = 0.4,
    func = function()
      play_sound('tarot1')
      used_tarot:juice_up(0.3, 0.5)
      return true
    end
  }))
  G.FUNCS.buff_cards(G.hand.cards, card.ability.extra.strength, 1)
  G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = 0.2,
    func = function()
      G.hand:unhighlight_all(); return true
    end
  }))
  delay(0.5)
end,
}

--Black Lotus
SMODS.Consumable {
	object_type = "Consumable",
	set = "Spectral",
	name = "mtg-blacklotus",
	key = "blacklotus",
	pos = { x = 0, y = 0 },
	hidden = true,
  cost=7000000,
	soul_set = "Magic",
	order = 21,
	atlas = "lotus",
	can_use = function(self, card)
		return true
	end,
  config = { extra = {num_jokers = 3}},
	loc_vars = function(self, info_queue, card)
	  info_queue[#info_queue + 1] = { key = "e_negative_consumable", set = "Edition", config = { extra = 1 } }
	  return { vars = { card.ability.extra.num_jokers } }
	end,
	use = function(self, card, area, copier)
    local used_tarot = card or copier
  G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
    play_sound('timpani')
      used_tarot:juice_up(0.3, 0.5)
      return true end }))
    for i=1,card.ability.extra.num_jokers do
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				local card = create_card("Joker", G.jokers, nil, nil, nil, nil, nil, "mtg_blacklotus")
        card:set_edition({negative = true}, true)
				card:add_to_deck()
				G.jokers:emplace(card)
				card:juice_up(0.3, 0.5)
				return true
			end,
		}))
		delay(0.6)
  end
	end,
}

--Fallen Empires
SMODS.Booster {
  object_type = "Booster",
  key = "magic_pack_1",
  kind = "Magic",
  atlas = "pack",
  pos = { x = 0, y = 0 },
  config = {extra = 2, choose = 1 },
  cost = 4,
  order = 1,
  weight = 0.96,
  create_card = function(self, card)
      return create_card("Magic", G.pack_cards, nil, nil, true, true, nil, "mtg_magic")
  end,
  ease_background_colour = function(self)
      ease_colour(G.C.DYN_UI.MAIN, G.C.SET.Magic)
      ease_background_colour({ new_colour = G.C.SET.Magic, special_colour = G.C.BLACK, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
      return { vars = { card.config.center.config.choose, card.ability.extra } }
  end,
  group_key = "k_mtg_magic_pack",
}

--Arabian Nights
SMODS.Booster {
  object_type = "Booster",
  key = "magic_pack_2",
  kind = "Magic",
  atlas = "pack",
  pos = { x = 1, y = 0 },
  config = {extra = 2, choose = 1 },
  cost = 6,
  order = 1,
  weight = 0.96,
  create_card = function(self, card)
      return create_card("Magic", G.pack_cards, nil, nil, true, true, nil, "mtg_magic")
  end,
  ease_background_colour = function(self)
      ease_colour(G.C.DYN_UI.MAIN, G.C.SET.Magic)
      ease_background_colour({ new_colour = G.C.SET.Magic, special_colour = G.C.BLACK, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
      return { vars = { card.config.center.config.choose, card.ability.extra } }
  end,
  group_key = "k_mtg_magic_pack",
}

--MB2
SMODS.Booster {
  object_type = "Booster",
  key = "magic_pack_3",
  kind = "Magic",
  atlas = "pack",
  pos = { x = 2, y = 0 },
  config = {extra = 4, choose = 1 },
  cost = 6,
  order = 1,
  weight = 0.48,
  create_card = function(self, card)
      return create_card("Magic", G.pack_cards, nil, nil, true, true, nil, "mtg_magic")
  end,
  ease_background_colour = function(self)
      ease_colour(G.C.DYN_UI.MAIN, G.C.SET.Magic)
      ease_background_colour({ new_colour = G.C.SET.Magic, special_colour = G.C.BLACK, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
      return { vars = { card.config.center.config.choose, card.ability.extra } }
  end,
  group_key = "k_mtg_magic_pack",
}

--P3K
SMODS.Booster {
  object_type = "Booster",
  key = "magic_pack_4",
  kind = "Magic",
  atlas = "pack",
  pos = { x = 0, y = 1 },
  config = {extra = 4, choose = 2 },
  cost = 6,
  order = 1,
  weight = 0.48,
  create_card = function(self, card)
      return create_card("Magic", G.pack_cards, nil, nil, true, true, nil, "mtg_magic")
  end,
  ease_background_colour = function(self)
      ease_colour(G.C.DYN_UI.MAIN, G.C.SET.Magic)
      ease_background_colour({ new_colour = G.C.SET.Magic, special_colour = G.C.BLACK, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
      return { vars = { card.config.center.config.choose, card.ability.extra } }
  end,
  group_key = "k_mtg_magic_pack",
}

-- bloomborrow Land Cards
SMODS.Booster {
  object_type = "Booster",
  key = "magic_pack_5",
  kind = "Magic",
  atlas = "land_pack",
  pos = { x = 0, y = 0 },
  config = {extra = 4, choose = 1 },
  cost = 5,
  order = 1,
  weight = 0.48,
  create_card = function(self, card)
      return create_card("Land", G.pack_cards, nil, nil, true, true, nil, "mtg_magic")
  end,
  ease_background_colour = function(self)
      ease_colour(G.C.DYN_UI.MAIN, G.C.SET.Magic)
      ease_background_colour({ new_colour = G.C.SET.Magic, special_colour = G.C.BLACK, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
      return { vars = { card.config.center.config.choose, card.ability.extra } }
  end,
  group_key = "k_mtg_magic_pack",
}

SMODS.Tag {
	object_type = "Tag",
	atlas = "mtg_tag",
	name = "mtg-magictag",
	order = 26,
	pos = { x = 0, y = 0 },
	config = { type = "new_blind_choice" },
	key = "magictag",
	min_ante = 2,
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = { set = "Other", key = "p_mtg_magic_pack", specific_vars = { 1, 2 } }
		return { vars = {} }
	end,
	apply = function(self, tag, context)
		if context.type == "new_blind_choice" then
			tag:yep("+", G.C.SECONDARY_SET.Code, function()
				local key = "p_mtg_magic_pack_" .. math.random(1, 2)
				local card = Card(
					G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
					G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
					G.CARD_W * 1.27,
					G.CARD_H * 1.27,
					G.P_CARDS.empty,
					G.P_CENTERS[key],
					{ bypass_discovery_center = true, bypass_discovery_ui = true }
				)
				card.cost = 0
				card.from_tag = true
				G.FUNCS.use_card({ config = { ref_table = card } })
				card:start_materialize()
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
}

SMODS.Tag {
	object_type = "Tag",
	atlas = "mtg_tag",
	name = "mtg-bigmagictag",
	order = 26,
	pos = { x = 0, y = 0 },
	config = { type = "new_blind_choice" },
	key = "bigmagictag",
	min_ante = 2,
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = { set = "Other", key = "p_mtg_magic_pack", specific_vars = { 1, 4 } }
		return { vars = {} }
	end,
	apply = function(self, tag, context)
		if context.type == "new_blind_choice" then
			tag:yep("+", G.C.SECONDARY_SET.Code, function()
				local key = "p_mtg_magic_pack_3"
				local card = Card(
					G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
					G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
					G.CARD_W * 1.27,
					G.CARD_H * 1.27,
					G.P_CARDS.empty,
					G.P_CENTERS[key],
					{ bypass_discovery_center = true, bypass_discovery_ui = true }
				)
				card.cost = 0
				card.from_tag = true
				G.FUNCS.use_card({ config = { ref_table = card } })
				card:start_materialize()
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
  in_pool = function()
		return false
	end
}
