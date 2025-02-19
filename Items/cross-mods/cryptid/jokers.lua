-- cryptid jokers for cross mod


-- jetmir, nexus of revels
SMODS.Joker {
    name = "jetmir",
    key = "jetmir",
    config = {extra = { chips = 10, mult = 10, power = 1}},
    pos = { x = 0, y = 1 },
    atlas = "mtg_atlas",
    order = 1,
    rarity = 3, -- might change to epic if this is too strong
    cost = 13,
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.chips, center.ability.extra.mult, center.ability.extra.power } }
    end,
    calculate = function(self, info_queue, center, vars)
        local chips = vars[1]
        local mult = vars[2]
        local power = vars[3]
        local total = 0
        for i = 1, chips do
            total = total + math.random(1, mult)
        end
        return total * power
    end,
}