
SMODS.ConsumableType {
    object_type = "ConsumableType",
    key = 'Land',
    collection_rows = { 3,4 },
    primary_colour = HEX("E08C50"),
    secondary_colour = HEX("97572b"),
    loc_txt = {
        collection = 'Land Cards',
        name = 'Land',
        label = 'Land',
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
    key = "un_magic",
    atlas = "un_back.png",
    pos = {
        x = 0,
        y = 0
    }
}

--[[
SMODS.Consumable {
    object_type = "Consumable",
    set = "Land",
    name = "mtg-mountain_land",
    key = "mountain_land",
    pos = { x = 0, y = 0},
    cost = 1,
    atlas = "mountain",
    can_use = function(self, card)
        return #G.hand.highlighted <= card.ability.extra.max_selected and #G.hand.highlighted > 0
    end,
    config = {mod_conv= "m_mtg_mountain" , max_selected = 3}},
    loc_vars = function(self, info_queue, card)
        if card then
            return { vars = { card.ability.extra.max_selected } }
        else
            return { vars = { 0 } }
        end
    end,
    use = function (self, card, area, copier)
        local used_land = card or copier
        
    end
}
--]]

-- [[
SMODS.Consumable {
    object_type = "Consumable",
    set = "Land",
    name = "mtg-forest_land",
    key = "forest_land",
    pos = { x = 0, y = 0},
    cost = 1,
    atlas = "forest",
    can_use = function(self, card)
        return #G.hand.highlighted <= card.ability.extra.max_selected and #G.hand.highlighted > 0
    end,
    config = {extra = {max_selected = 1}},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_selected } }
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
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() Card.set_ability(G.hand.highlighted[i], Forest_land, nil);return true end }))
        end
        
        
        
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
        delay(0.5)
        
        
    end,        
            
}
--]]

-- [[
SMODS.Consumable {
    object_type = "Consumable",
    set = "Land",
    name = "mtg-island_land",
    key = "island_land",
    pos = { x = 0, y = 0},
    cost = 1,
    atlas = "island",
    can_use = function(self, card)
        return #G.hand.highlighted <= card.ability.extra.max_selected and #G.hand.highlighted > 0
    end,
    config = {extra = {max_selected = 1}},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_selected } }
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
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() Card.set_ability(G.hand.highlighted[i], Island_land, nil);return true end }))
        end
   
        
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
        delay(0.5)
        
        
    end,        
            
}
--]]

--[[
SMODS.Consumable {
    object_type = "Consumable",
    set = "Land",
    name = "mtg-swamp_land",
    key = "swamp_land",
    pos = { x = 0, y = 0},
    cost = 1,
    atlas = "swamp",
    can_use = function(self, card)
        return #G.hand.highlighted <= card.ability.extra.max_selected and #G.hand.highlighted > 0
    end,
    config = {extra = {max_selected = 3}},
    loc_vars = function(self, info_queue, card)
        if card then
            return { vars = { card.ability.extra.max_selected } }
        else
            return { vars = { 0 } }
        end
    end,
    use = function (self, card, area, copier)
        local used_land = card or copier
        
    end
}

--]]

-- [[

SMODS.Consumable {
    object_type = "Consumable",
    set = "Land",
    name = "mtg-plains_land",
    key = "plains_land",
    pos = { x = 0, y = 0},
    cost = 1,
    atlas = "plains",
       can_use = function(self, card)
        return #G.hand.highlighted <= card.ability.extra.max_selected and #G.hand.highlighted > 0
    end,
    config = {extra = {max_selected = 1}},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_selected } }
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
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() Card.set_ability(G.hand.highlighted[i], Plains_land, nil);return true end }))
        end
   
        
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
        delay(0.5)
        
        
    end,        
            
}
--]]


-- will probably make this its own type and not an enhancment ecentually 
-- [[


Forest_land = SMODS.Enhancement {
    object_type = "Enhantment",
    name = "mtg-Forest_land",
    key = "Forest_land",
    atlas = "forest",
    pos = { x = 0, y = 0 },
    config = { extra = { m_mult = 1.25 } },
    weight = 0,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.m_mult } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
          return { mult = card.ability.extra.m_mult }
        end
      end
}
--]]

-- [[

Island_land = SMODS.Enhancement {
    object_type = "Enhancement",
    name = "mtg-Island_land",
    key = "Island_land",
    text = "Island",
    atlas = "island",
    pos = { x = 0, y = 0 },
    config = { extra = { m_mult = 1.25 } },
    weight = 1,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.m_mult } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
          return { mult = card.ability.extra.m_mult }
        end
      end
}

Plains_land = SMODS.Enhancement {
    object_type = "Enhancement",
    name = "mtg-Plains_land",
    key = "Plains_land",
    text = "Plains",
    atlas = "plains",
    pos = { x = 0, y = 0 },
    config = { extra = { m_mult = 1.25 } },
    weight = 1,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.m_mult } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
          return { mult = card.ability.extra.m_mult }
        end
      end
}