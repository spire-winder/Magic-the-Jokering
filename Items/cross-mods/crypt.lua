
SMODS.Edition:take_ownership( "cry_double_sided", {
    
} )

-- Double-Sided - create FLIP button
		-- kinda based on Fusion Jokers
local card_focus_ui = G.UIDEF.card_focus_ui
function G.FUNCS.can_flip_card(e)
    e.config.colour = G.C.DARK_EDITION
    e.config.button = "flip"
end
function G.FUNCS.can_flip_merge_card(e)
    local area = e.config.ref_table.area
    local mergable = 0
    for i = 1, #area.highlighted do
        if area.highlighted[i].edition and area.highlighted[i].edition.cry_double_sided then
            mergable = mergable + 1
            mergedcard = area.highlighted[i]
        end
    end
    if mergable == 1 then
        e.config.colour = G.C.DARK_EDITION
        e.config.button = "flip_merge"
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end
function G.FUNCS.flip(e)
    e.config.ref_table:flip()
    e.config.ref_table.area:remove_from_highlighted(e.config.ref_table)
end
function G.FUNCS.flip_merge(e)
    e.config.ref_table:flip()
    e.config.ref_table.area:remove_from_highlighted(e.config.ref_table)
    G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 1,
        func = function()
            local area = e.config.ref_table.area
            area:remove_card(e.config.ref_table)
            mergedcard:init_dbl_side()
            copy_dbl_card(e.config.ref_table, mergedcard.dbl_side)
            e.config.ref_table:remove()
            e.config.ref_table = nil
            return true
        end,
    }))
end
local use_and_sell_buttonsref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
    local retval = use_and_sell_buttonsref(card)
    if
        card.area
        and card.edition
        and (card.area == G.jokers or card.area == G.consumeables or card.area == G.hand)
        and card.edition.cry_double_sided
        and not Card.no(card, "dbl")
    then
        local use = {
            n = G.UIT.C,
            config = { align = "cr" },
            nodes = {
                {
                    n = G.UIT.C,
                    config = {
                        ref_table = card,
                        align = "cr",
                        maxw = 1.25,
                        padding = 0.1,
                        r = 0.08,
                        hover = true,
                        shadow = true,
                        colour = G.C.UI.BACKGROUND_INACTIVE,
                        one_press = true,
                        button = "flip",
                        func = "can_flip_card",
                    },
                    nodes = {
                        { n = G.UIT.B, config = { w = 0.1, h = 0.3 } },
                        {
                            n = G.UIT.T,
                            config = {
                                text = localize("b_flip"),
                                colour = G.C.UI.TEXT_LIGHT,
                                scale = 0.3,
                                shadow = true,
                            },
                        },
                    },
                },
            },
        }
        local m = retval.nodes[1]
        if not card.added_to_deck then
            use.nodes[1].nodes = { use.nodes[1].nodes[2] }
            if card.ability.consumeable then
                m = retval
            end
        end
        m.nodes = m.nodes or {}
        table.insert(m.nodes, { n = G.UIT.R, config = { align = "cl" }, nodes = {
            use,
        } })
        return retval
    end
    if
        card.area
        and (card.area == G.jokers or card.area == G.consumeables or card.area == G.hand)
        and (not card.edition or not card.edition.cry_double_sided)
        and not card.ability.eternal
        and not Card.no(card, "dbl")
    then
        for i = 1, #card.area.cards do
            if card.area.cards[i].edition and card.area.cards[i].edition.cry_double_sided then
                local use = {
                    n = G.UIT.C,
                    config = { align = "cr" },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = {
                                ref_table = card,
                                align = "cr",
                                maxw = 1.25,
                                padding = 0.1,
                                r = 0.08,
                                hover = true,
                                shadow = true,
                                colour = G.C.UI.BACKGROUND_INACTIVE,
                                one_press = true,
                                button = "flip_merge",
                                func = "can_flip_merge_card",
                            },
                            nodes = {
                                { n = G.UIT.B, config = { w = 0.1, h = 0.3 } },
                                {
                                    n = G.UIT.T,
                                    config = {
                                        text = localize("b_merge"),
                                        colour = G.C.UI.TEXT_LIGHT,
                                        scale = 0.3,
                                        shadow = true,
                                    },
                                },
                            },
                        },
                    },
                }
                local m = retval.nodes[1]
                if not card.added_to_deck then
                    use.nodes[1].nodes = { use.nodes[1].nodes[2] }
                    if card.ability.consumeable then
                        m = retval
                    end
                end
                m.nodes = m.nodes or {}
                table.insert(m.nodes, { n = G.UIT.R, config = { align = "cl" }, nodes = {
                    use,
                } })
                return retval
            end
        end
    end
    return retval
end
local cupd = Card.update
function Card:update(dt)
    cupd(self, dt)
    if self.area then
        if self.area.config.type == "discard" or self.area.config.type == "deck" then
            return --prevent lagging event queues with unneeded flips
        end
    end
    if self.sprite_facing == "back" and self.edition and self.edition.cry_double_sided then
        self.sprite_facing = "front"
        self.facing = "front"
        if self.flipping == "f2b" then
            self.flipping = "b2f"
        end
        self:dbl_side_flip()
    end
    if self.ability.cry_absolute then	-- feedback loop... may be problematic
        self.cry_absolute = true
    end
    if self.cry_absolute then
        self.ability.cry_absolute = true
        self.ability.eternal = true
    end
end
function copy_dbl_card(C, c, deck_effects)
    if not deck_effects then
        Cdeck = C.added_to_deck
        cdeck = c.added_to_deck
        C.added_to_deck = true
        c.added_to_deck = false
    end
    copy_card(C, c)
    c.config.center_key = C.config.center_key
end
function Card:init_dbl_side()
    if Card.no(self, "dbl") then
        self:set_edition(nil, true)
    end
    if not self.dbl_side then
        self.dbl_side = cry_deep_copy(self)
        self.dbl_side:set_ability(G.P_CENTERS.c_base)
        -- self.dbl_side:set_base(G.P_CARDS.empty) -- RIGHT HERE THIS RIGHT HERE THATS YOUR DAM CULPRIT
        if self.area == G.hand then
            self.dbl_side.config.center = cry_deep_copy(self.dbl_side.config.center)
            self.dbl_side.config.center.no_rank = true
        end
        self.dbl_side.added_to_deck = false
        return true
    end
end
function Card:dbl_side_flip()
    local init_dbl_side = self:init_dbl_side()
    local tmp_side = cry_deep_copy(self.dbl_side)
    self.children.center.scale = { x = self.children.center.atlas.px, y = self.children.center.atlas.py }
    self.T.w, self.T.h = G.CARD_W, G.CARD_H
    local active_side = self
    if next(find_joker("cry-Flip Side")) and self.dbl_side then
        active_side = self.dbl_side
    end
    if not init_dbl_side then 
        active_side:remove_from_deck(true) 
    end
    copy_dbl_card(self, self.dbl_side, false)
    copy_dbl_card(tmp_side, self, false)
    active_side:add_to_deck(true)
    self.children.center:set_sprite_pos(G.P_CENTERS[self.config.center.key].pos)
    if self.base then
        --Note: this causes a one-frame stutter
        for k, v in pairs(G.P_CARDS) do
            if self.base.suit == v.suit and self.base.value == v.value then
                self.config.card_key = k
            end
        end
        self:set_sprites(nil, self.config.card)
        if self.children and self.children.front and self.config.card_key then self.children.front:set_sprite_pos(G.P_CARDS[self.config.card_key].pos) end
    end
    if (not self.base or not self.base.name) and self.children.front then
        self.children.front:remove()
        self.children.front = nil
    end
    self:set_edition({cry_double_sided = true},true,true)
end
local cgcb = Card.get_chip_bonus
function Card:get_chip_bonus()
    if self.ability.set == "Joker" then return 0 end
    return cgcb(self)
end
local csave = Card.save
function Card:save()
    local cardTable = csave(self)
    if self.dbl_side then
        cardTable.dbl_side = csave(self.dbl_side)
    end
    return cardTable
end
local cload = Card.load
function Card:load(cardTable, other_card)
    cload(self, cardTable, other_card)
    if self.ability.set == "Default" then
        self:set_ability(G.P_CENTERS.c_base, true)
    end
    if not self.base.name then
        self:set_base(G.P_CARDS.empty, true)
        if self.children.front then
            self.children.front:remove()
            self.children.front = nil
        end
    end
    if cardTable.dbl_side then
        self.dbl_side = cry_deep_copy(self)
        cload(self.dbl_side, cardTable.dbl_side)
        if self.dbl_side.ability.set == "Default" and self.ability.set ~= "Default" then
            self.dbl_side:set_ability(G.P_CENTERS.c_base, true)
        end
        if not self.dbl_side.base.name then
            self.dbl_side:set_base(G.P_CARDS.empty, true)
        end
    end
end
local rma = remove_all
function remove_all(t)
    if t then
        rma(t)
    end
end
--prevent chaos the clown's ability from being applied on debuff
local catd = Card.add_to_deck
local crfd = Card.remove_from_deck
function Card:add_to_deck(debuff)
    if debuff and self.ability.name == 'Chaos the Clown' then
        return
    end
    return catd(self, debuff)
end
function Card:remove_from_deck(debuff)
    if debuff and self.ability.name == 'Chaos the Clown' then
        return
    end
    return crfd(self, debuff)
end
local cae = CardArea.emplace
function CardArea:emplace(card,m1,m2)
    if not (card.will_shatter or card.destroyed or card.shattered) then
        cae(self,card,m1,m2)
    else
        if card.area then
            card.area:remove_card(card)
        end
        card:remove()
        card = nil
    end
end
local sjw = set_joker_win
function set_joker_win()
    sjw()
    for k, v in pairs(G.jokers.cards) do
      if v.dbl_side and v.dbl_side.config.center_key and v.dbl_side.ability.set == 'Joker' then
        G.PROFILES[G.SETTINGS.profile].joker_usage[v.dbl_side.config.center_key] = G.PROFILES[G.SETTINGS.profile].joker_usage[v.dbl_side.config.center_key] or {count = 1, order = v.dbl_side.config.center.order, wins = {}, losses = {}, wins_by_key = {}, losses_by_key = {}}
        if G.PROFILES[G.SETTINGS.profile].joker_usage[v.dbl_side.config.center_key] then
          G.PROFILES[G.SETTINGS.profile].joker_usage[v.dbl_side.config.center_key].wins = G.PROFILES[G.SETTINGS.profile].joker_usage[v.dbl_side.config.center_key].wins or {}
          G.PROFILES[G.SETTINGS.profile].joker_usage[v.dbl_side.config.center_key].wins[G.GAME.stake] = (G.PROFILES[G.SETTINGS.profile].joker_usage[v.dbl_side.config.center_key].wins[G.GAME.stake] or 0) + 1
        end
      end
    end
    G:save_settings()
end