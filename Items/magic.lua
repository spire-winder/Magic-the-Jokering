SMODS.ConsumableType {
    object_type = "ConsumableType",
    key = 'Magic',
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
    atlas = "mtg_atlas",
    pos = {
        x = 0,
        y = 1,
    }
}

--Ancestral Recall
SMODS.Consumable ({
    object_type = "Consumable",
    set = "Magic",
    name = "mtg-ancestral",
    key = "ancestral",
    pos = {
        x = 0,
        y = 0
    },
    atlas = 'mtg_atlas',
    cost = 3,
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
    end,
})

--One With Nothing
SMODS.Consumable {
    object_type = "Consumable",
  set = "Magic",
  name = "mtg-onewithnothing",
    key = "onewithnothing",
    pos = {
        x = 1,
        y = 0
    },
    atlas = 'mtg_atlas',
  cost = 3,
  order = 1,
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

--Wrath of God
SMODS.Consumable {
    object_type = "Consumable",
  set = "Magic",
  name = "mtg-wrathofgod",
    key = "wrathofgod",
    pos = {
        x = 1,
        y = 1
    },
    atlas = 'mtg_atlas',
  cost = 3,
  order = 1,
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
                      for i = #temp_hand, 1, -1 do
                          local card = temp_hand[i]
                          if card.ability.name == "Glass Card" then
                              card:shatter()
                          else
                              card:start_dissolve(nil, i ~= #temp_hand)
                          end
                      end
                      return true
                  end,
              }))
  end,
}

--Obliterate
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-obliterate",
  key = "obliterate",
  pos = {
      x = 1,
      y = 1
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 1,
  config = {},
  loc_vars = function(self, info_queue, card)
    return {}
  end,
can_use = function(self, card)
    return G.STATE == G.STATES.SELECTING_HAND and not G.GAME.blind.boss
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
                    for i = #temp_hand, 1, -1 do
                        local card = temp_hand[i]
                        if card.ability.name == "Glass Card" then
                            card:shatter()
                        else
                            card:start_dissolve(nil, i ~= #temp_hand)
                        end
                    end
                    return true
                end,
            }))
            instant_win()
end,
}

--Village Rites
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-villagerites",
  key = "villagerites",
  pos = {
      x = 2,
      y = 1
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 1,
  config = {extra = { cards = 2}},
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.cards } }
  end,
can_use = function(self, card)
    return #G.hand.highlighted <= 1 and #G.hand.highlighted > 0
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
        for i=#G.hand.highlighted, 1, -1 do
            local card = G.hand.highlighted[i]
            if card.ability.name == 'Glass Card' then 
                card:shatter()
            else
                card:start_dissolve(nil, i == #G.hand.highlighted)
            end
        end
        return true end }))
  G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
    G.FUNCS.draw_from_deck_to_hand(card.ability.extra.cards)
    return true
  end
  }))
end,
}

--Negate
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-negate",
  key = "negate",
  pos = {
      x = 3,
      y = 0
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 1,
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
    card_eval_status_text(card or copier, 'extra', nil, nil, nil, {message = localize('ph_boss_disabled')})
    G.GAME.blind:disable()
end
end,
}

--Chatterstorm
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-chatterstorm",
  key = "chatterstorm",
  pos = {
      x = 0,
      y = 2
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 1,
  config = {},
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "r_mtg_storm_count", set = "Other", config = { extra = 1 } }
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
                        local _suit, _rank = nil, nil
                        _rank = 'A'
                        _suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('chatterstorm'))
                        create_playing_card({front = G.P_CARDS[_suit..'_'.._rank]}, G.hand, nil, i ~= 1, {G.C.SECONDARY_SET.Magic})
                        return true end }))
          end
  return true
end,
}

--Reaping the Graves
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-reaping",
  key = "reaping",
  pos = {
      x = 3,
      y = 2
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 1,
  config = {},
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "r_mtg_storm_count", set = "Other", config = { extra = 1 } }
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

--mind's desire
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-mindsdesire",
  key = "mindsdesire",
  pos = {
      x = 4,
      y = 2
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 1,
  config = { extra = {num_tarot = 1}},
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "r_mtg_storm_count", set = "Other", config = { extra = 1 } }
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

--Astral Steel
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-astralsteel",
  key = "astralsteel",
  pos = {
      x = 5,
      y = 0
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 1,
  config = {extra = {strength = 2}},
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "r_mtg_storm_count", set = "Other", config = { extra = 1 } }
    return { vars = {card.ability.extra.strength, G.GAME.mtg_storm_count} }
  end,
can_use = function(self, card)
    return #G.hand.highlighted <= 1 and #G.hand.highlighted > 0
end,
use = function(self, card, area, copier)
  local used_tarot = card or copier
  for i=1, G.GAME.mtg_storm_count do
G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4 / i, func = function()
    play_sound('tarot1')
    used_tarot:juice_up(0.3, 0.5)
    return true end }))
    for i=1, #G.hand.highlighted do
      local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
      G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15 / i,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
  end
    for i=1, #G.hand.highlighted do
      buff_card(G.hand.highlighted[i], card.ability.extra.strength)
    end
  for i=1, #G.hand.highlighted do
    local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15 / i,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
end
end
G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
return true
end,
}

--Giant Growth
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-giantgrowth",
  key = "giantgrowth",
  pos = {
      x = 1,
      y = 2
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 1,
  config = {extra = {strength = 3}},
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.strength } }
  end,
can_use = function(self, card)
    return #G.hand.highlighted <= 1 and #G.hand.highlighted > 0
end,
use = function(self, card, area, copier)
  local used_tarot = card or copier
G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
    play_sound('tarot1')
    used_tarot:juice_up(0.3, 0.5)
    return true end }))
    for i=1, #G.hand.highlighted do
      local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
      G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
  end
  delay(0.2)
    for i=1, #G.hand.highlighted do
      buff_card(G.hand.highlighted[i], card.ability.extra.strength)
  end
  for i=1, #G.hand.highlighted do
    local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
end
G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
delay(0.5)
return true
end,
}

--Transmogrify
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-transmogrify",
  key = "transmogrify",
  pos = {
      x = 4,
      y = 0
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 1,
  config = {},
  loc_vars = function(self, info_queue, card)
    return { vars = {  } }
  end,
can_use = function(self, card)
    return #G.hand.highlighted <= 1 and #G.hand.highlighted > 0 and #G.deck.cards > 0
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
        for i=#G.hand.highlighted, 1, -1 do
            local card = G.hand.highlighted[i]
            if card.ability.name == 'Glass Card' then 
                card:shatter()
            else
                card:start_dissolve(nil, i == #G.hand.highlighted)
            end
        end
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

--Lava Axe
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-lavaaxe",
  key = "lavaaxe",
  pos = {
      x = 4,
      y = 0
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 1,
  config = {extra = {damage = 5}},
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "r_mtg_damage_blind", set = "Other", config = { extra = 1 } }
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
    deal_damage(card, card.ability.extra.damage + damage_increase())
end,
}

--Flame Slash
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-flameslash",
  key = "flameslash",
  pos = {
      x = 4,
      y = 0
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 1,
  config = {extra = {damage = 4}},
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "r_mtg_damage_card", set = "Other", config = { extra = 1 } }
    return { vars = { card.ability.extra.damage } }
  end,
can_use = function(self, card)
    return (#G.hand.highlighted > 0) and #G.hand.highlighted <= 1
end,
use = function(self, card, area, copier)
  local used_tarot = card or copier
  G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
    play_sound('tarot1')
    used_tarot:juice_up(0.3, 0.5)
    return true end }))
    for i=1, #G.hand.highlighted do
        damage_card(G.hand.highlighted[i], card.ability.extra.damage + damage_increase())
    end
end,
}

--Lightning Bolt
SMODS.Consumable {
  object_type = "Consumable",
set = "Magic",
name = "mtg-lightningbolt",
  key = "lightningbolt",
  pos = {
      x = 4,
      y = 0
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 1,
  config = {extra = {damage = 3}},
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "r_mtg_any_target", set = "Other", config = { extra = 1 } }
    info_queue[#info_queue + 1] = { key = "r_mtg_damage_blind", set = "Other", config = { extra = 1 } }
    info_queue[#info_queue + 1] = { key = "r_mtg_damage_card", set = "Other", config = { extra = 1 } }
    return { vars = { card.ability.extra.damage } }
  end,
can_use = function(self, card)
    return (G.STATE == G.STATES.SELECTING_HAND or #G.hand.highlighted > 0) and #G.hand.highlighted <= 1
end,
use = function(self, card, area, copier)
  local used_tarot = card or copier
  G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
    play_sound('tarot1')
    used_tarot:juice_up(0.3, 0.5)
    return true end }))
    if #G.hand.highlighted < 1 then
      deal_damage(card, card.ability.extra.damage + damage_increase())
    else
      for i=1, #G.hand.highlighted do
        damage_card(G.hand.highlighted[i], card.ability.extra.damage + damage_increase())
    end
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
      x = 4,
      y = 0
  },
  atlas = 'mtg_atlas',
cost = 3,
order = 1,
  config = {extra = {damage = 1}},
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "r_mtg_storm_count", set = "Other", config = { extra = 1 } }
    info_queue[#info_queue + 1] = { key = "r_mtg_any_target", set = "Other", config = { extra = 1 } }
    info_queue[#info_queue + 1] = { key = "r_mtg_damage_blind", set = "Other", config = { extra = 1 } }
    info_queue[#info_queue + 1] = { key = "r_mtg_damage_card", set = "Other", config = { extra = 1 } }
    return { vars = { card.ability.extra.damage, G.GAME.mtg_storm_count } }
  end,
can_use = function(self, card)
    return (G.STATE == G.STATES.SELECTING_HAND or #G.hand.highlighted > 0) and #G.hand.highlighted <= 1
end,
use = function(self, card, area, copier)
  local used_tarot = card or copier
    for i=1, G.GAME.mtg_storm_count do
      G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4 / i, func = function()
        play_sound('tarot1')
        used_tarot:juice_up(0.3, 0.5)
        return true end }))
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4 / i, func = function()
          if #G.hand.highlighted < 1 then
            deal_damage(card, card.ability.extra.damage + damage_increase())
          else
            for i=1, #G.hand.highlighted do
              damage_card(G.hand.highlighted[i], card.ability.extra.damage + damage_increase())
          end
        end
          return true end }))
    end
    
end,
}

--Booster Tutor
SMODS.Consumable {
	object_type = "Consumable",
	set = "Magic",
	name = "mtg-boostertutor",
	key = "boostertutor",
	pos = { x = 2, y = 0 },
	hidden = true,
  cost=3,
	order = 41,
	atlas = "mtg_atlas",
	can_use = function(self, card)
		return true
	end,
  config = { extra = {num_jokers = 3}},
	loc_vars = function(self, info_queue, card)
	  return { vars = { card.ability.extra.num_jokers } }
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


--Black Lotus
SMODS.Consumable {
	object_type = "Consumable",
	set = "Spectral",
	name = "mtg-blacklotus",
	key = "blacklotus",
	pos = { x = 2, y = 0 },
	hidden = true,
  cost=7000000,
	soul_set = "Magic",
	order = 41,
	atlas = "mtg_atlas",
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
	apply = function(tag, context)
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
		info_queue[#info_queue + 1] = { set = "Other", key = "p_mtg_magic_pack", specific_vars = { 2, 4 } }
		return { vars = {} }
	end,
	apply = function(tag, context)
		if context.type == "new_blind_choice" then
			tag:yep("+", G.C.SECONDARY_SET.Code, function()
				local key = "p_mtg_magic_pack_4"
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