-- cryptid jokers for cross mod




-- jetmir, nexus of revels
SMODS.Joker {
    name = "jetmir",
    key = "jetmir",
    config = {extra = { mult = 10, x_mult = 10, power = 10}},
    pos = { x = 0, y = 1 },
    atlas = "mtg_atlas",
    order = 1,
    rarity = "cry_epic", -- might change to epic if this is too strong
    cost = 13,
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.mult, center.ability.extra.x_mult, center.ability.extra.power } }
    end,
    calculate = function(self, card, context)
        local level = 0
        for i = 1, #G.GAME.tags do
            if G.GAME.tags[i].key == 'tag_cry_cat' then
                level = math.max(G.GAME.tags[i].ability.level or 1, level)
            end
        end
        if context.individual and context.cardarea == G.play then
            if level >= 9 then
                return {
                    Emult_mod = 10,
                    Xmult_mod = 10,
                    mult_mod = 10,
                }
            elseif level <= 8 and level >= 6 then
                return {
                    Xmult_mod = 10,
                    mult_mod = 10,
                }
            elseif level <= 5 and level >= 3 then
                return {
                    mult_mod = 10,
                }
            end
        end
    end
}