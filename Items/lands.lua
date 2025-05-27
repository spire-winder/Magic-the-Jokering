


--[[
template for making new land consumeables

SMODS.Consumable {
    object_type = "Consumable",
    set = "Land",
    name = "mtg-'land name'_land",
    key = "'land name'_land",
    pos = { x = 0, y = 0},
    cost = 1,
    atlas = "atlas for land consumable",
    can_use = function(self, card)
        return #G.hand.highlighted <= card.ability.extra.max_selected and #G.hand.highlighted > 0
    end,
    config = {extra = {max_selected = 2}},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_selected } }
    end,
    use = function(self, card, area, copier)
        local used_tarot = card or copier (addde so when used it increases your storm count)
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
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                if G.hand.highlighted[i].base.suit == "'the suit that the land corosponds to'" then
                  (the name of the land in the card ability should be uppercase to make it call the correct card)
                    Card.set_ability(G.hand.highlighted[i], 'land name'_land, nil)
                else
                    SMODS.change_base(G.hand.highlighted[i], -- checks what card is selected
                    'corosponding suit',
                    nil)
                end
                return true
              end,}))
        end
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
        delay(0.5)
    end,
}

]]


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
    key = "Land",
    atlas = "mtg_back",
    pos = {
        x = 0,
        y = 0
    }
}

-- [[
SMODS.Consumable {
    object_type = "Consumable",
    set = "Land",
    name = "mtg-mountain_land",
    key = "mountain_land",
    pos = { x = 13, y = 4},
    cost = 1,
    atlas = "mtg_atlas",
   can_use = function(self, card)
        return #G.hand.highlighted <= card.ability.extra.max_selected and #G.hand.highlighted > 0
    end,
    config = {extra = {max_selected = 2}},
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
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                if G.hand.highlighted[i].base.suit == 'Hearts' or next(SMODS.find_card("j_mtg_bloodmoon")) then
                  -- do Hearts things
                    Card.set_ability(G.hand.highlighted[i], Mountain_land, nil)
                else
                  -- do non-Hearts things
                    SMODS.change_base(G.hand.highlighted[i],'Hearts',nil)
                end
                return true
              end,}))
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
    name = "mtg-forest_land",
    key = "forest_land",
    pos = { x = 14, y = 4},
    cost = 1,
    atlas = "mtg_atlas",
    can_use = function(self, card)
        return #G.hand.highlighted <= card.ability.extra.max_selected and #G.hand.highlighted > 0
    end,
    config = {extra = {max_selected = 2}},
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
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                if G.hand.highlighted[i].base.suit == suit_clovers.key or next(SMODS.find_card("j_mtg_yavimaya")) then
                  -- do clover things
                    Card.set_ability(G.hand.highlighted[i], Forest_land, nil)
                else
                  -- do non-clover things
                    SMODS.change_base(G.hand.highlighted[i],suit_clovers.key,nil)
                end
                return true
              end,}))
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
    pos = { x = 13, y = 3},
    cost = 1,
    atlas = "mtg_atlas",
    can_use = function(self, card)
        return #G.hand.highlighted <= card.ability.extra.max_selected and #G.hand.highlighted > 0
    end,
    config = {extra = {max_selected = 2}},
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
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                if G.hand.highlighted[i].base.suit == 'Clubs' or next(SMODS.find_card("j_mtg_harbinger")) then
                  -- do club things
                    Card.set_ability(G.hand.highlighted[i], Island_land, nil)
                else
                  -- do non-club things
                    SMODS.change_base(G.hand.highlighted[i],'Clubs',nil)
                end
                return true
              end,}))
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
    name = "mtg-swamp_land",
    key = "swamp_land",
    pos = { x = 14, y = 3},
    cost = 1,
    atlas = "mtg_atlas",
    can_use = function(self, card)
        return #G.hand.highlighted <= card.ability.extra.max_selected and #G.hand.highlighted > 0
    end,
    config = {extra = {max_selected = 2}},
    loc_vars = function(self, info_queue, card)
        if card then
            return { vars = { card.ability.extra.max_selected } }
        else
            return { vars = { 0 } }
        end
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
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                if G.hand.highlighted[i].base.suit == 'Spades' or next(SMODS.find_card("j_mtg_urborg")) then
                  -- do spade things
                    Card.set_ability(G.hand.highlighted[i], Swamp_land, nil)
                    
                else
                  -- do non-spade things
                    SMODS.change_base(G.hand.highlighted[i],'Spades',nil)
                end
                return true
              end,}))
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
    name = "mtg-plains_land",
    key = "plains_land",
    pos = { x = 12, y = 3},
    cost = 1,
    atlas = "mtg_atlas",
       can_use = function(self, card)
        return #G.hand.highlighted <= card.ability.extra.max_selected and #G.hand.highlighted > 0
    end,
    config = {extra = {max_selected = 2}},
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
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                if G.hand.highlighted[i].base.suit == 'Diamonds' or next(SMODS.find_card("j_mtg_celestialdawn")) then
                  -- do diamond things
                    Card.set_ability(G.hand.highlighted[i], Plains_land, nil)
                else
                  -- do non-diamond things
                    SMODS.change_base(G.hand.highlighted[i],'Diamonds',nil)
                end
                return true
              end,}))
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

SMODS.Consumable {
    object_type = "Consumable",
    set = "Land",
    name = "mtg-waste_land",
    key = "waste_land",
    pos = { x = 12, y = 4},
    cost = 1,
    atlas = "mtg_atlas",
       can_use = function(self, card)
        return #G.hand.highlighted <= card.ability.extra.max_selected and #G.hand.highlighted > 0
    end,
    config = {extra = {max_selected = 2}},
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
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                    if G.hand.highlighted[i].base.suit == suit_suitless.key then
                    -- do suitless things
                        Card.set_ability(G.hand.highlighted[i], Waste_land, nil)
                    else
                    -- do non-suitless things
                        SMODS.change_base(G.hand.highlighted[i],suit_suitless.key,nil)
                    end
                    return true
                end,
            }))
        end
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
        delay(0.5)
    end,
}


-- will probably make this its own type and not an enhancment eventually 
-- [[


Forest_land = SMODS.Enhancement {
    object_type = "Enhantment",
    name = "mtg-Forest_land",
    key = "Forest_land",
    atlas = "mtg_atlas",
    pos = { x = 14, y = 4 },
    config = { extra = { m_mult = 1.25, p_mult = 1.25 } },
    weight = 0,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.m_mult, card.ability.extra.p_mult } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if card:is_suit(suit_clovers.key) then
                return { Xmult = card.ability.extra.m_mult }
            else
                return { mult = card.ability.extra.p_mult }
            end
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
    atlas = "mtg_atlas",
    pos = { x = 13, y = 3 },
    config = { extra = { m_mult = 1.25, p_mult = 1.25 } },
    weight = 0,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.m_mult, card.ability.extra.p_mult } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if card:is_suit("Clubs") then
                return { Xmult = card.ability.extra.m_mult }
            else
                return { mult = card.ability.extra.p_mult }
            end
        end
    end
}

Plains_land = SMODS.Enhancement {
    object_type = "Enhancement",
    name = "mtg-Plains_land",
    key = "Plains_land",
    text = "Plains",
    atlas = "mtg_atlas",
    pos = { x = 12, y = 3 },
    config = { extra = { m_mult = 1.25, p_mult = 1.25 } },
    weight = 0,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.m_mult, card.ability.extra.p_mult } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if card:is_suit("Diamonds") then
                return { Xmult = card.ability.extra.m_mult }
            else
                return { mult = card.ability.extra.p_mult }
        end
    end
end
}

-- [[
Swamp_land = SMODS.Enhancement {
    object_type = "Enhancement",
    name = "mtg-Swamp_land",
    key = "Swamp_land",
    text = "Swamp",
    atlas = "mtg_atlas",
    pos = { x = 14, y = 3 },
    config = { extra = { m_mult = 1.25, p_mult = 1.25 } },
    weight = 0,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.m_mult, card.ability.extra.p_mult } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if card:is_suit("Spades") then
                return { Xmult = card.ability.extra.m_mult }
            else
                return { mult = card.ability.extra.p_mult }
            end
        end
    end
}
--]]

-- [[
Mountain_land = SMODS.Enhancement {
    object_type = "Enhancement",
    name = "mtg-Mountain_land",
    key = "Mountain_land",
    text = "Mountain",
    atlas = "mtg_atlas",
    pos = { x = 13, y = 4 },
    config = { extra = { m_mult = 1.25, p_mult = 1.25 } },
    weight = 0,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.m_mult, card.ability.extra.p_mult } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if card:is_suit("Hearts") then
                return { Xmult = card.ability.extra.m_mult }
            else
                return { mult = card.ability.extra.p_mult }
            end
        end
    end
}
--]]

Waste_land = SMODS.Enhancement {
    object_type = "Enhancement",
    name = "mtg-Wastes_land",
    key = "Waste_land",
    text = "Waste",
    atlas = "mtg_atlas",
    pos = { x = 12, y = 4 },
    config = { extra = { m_mult = 1.25, p_mult = 1.25 } },
    weight = 0,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.m_mult, card.ability.extra.p_mult } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if card:is_suit(suit_suitless.key) then
                return { Xmult = card.ability.extra.m_mult }
            else
                return { mult = card.ability.extra.p_mult }
            end
        end
    end
}

--[[
Aether_Hub = SMODS.Enhancement {
    object_type = "Enhancement",
    name = "mtg-Aether_Hub",
    key = "Aether_Hub",
    text = "Aether Hub",
    atlas = "mtg_atlas",
    pos = { x = 0, y = 1 },
    config = { extra = { energy = 2, add_energy = 2 }, mtg_energy = true },
    weight = 0,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.add_energy} }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return (mtg_increment_energy(card, context))
        end
    end
}
--]]