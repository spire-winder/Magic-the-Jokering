
local jetmir = {
    object_type = "Joker",
    name = "mtg-jetmir",
    key = "jetmir",
    order = 17,
    config = {extra = { mult = 10, x_mult = 10, power = 10}},
    gameset_config = {
		modest = { disabled = true },
		mainline = { extra = { mult = 2, x_mult = 2, power = 2 }, disabled = true },
		madness = { extra = { mult = 10, x_mult = 10, power = 10 }, disabled = true },
		experimental = {disabled = true},
    },
    dependencies = {
        items = {
            "set_cry_epic",
            "set_cry_tag",
        },
    },
    pos = { x = 0, y = 1 },
    atlas = "mtg_atlas",
    rarity = "cry_epic",
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
                    Emult_mod = self.config.extra.power,
                    Xmult_mod = self.config.extra.x_mult,
                    mult_mod = self.config.extra.mult,
                }
            elseif level <= 8 and level >= 6 then
                return {
                    Xmult_mod = self.config.extra.x_mult,
                    mult_mod = self.config.extra.mult,
                }
            elseif level <= 5 and level >= 3 then
                return {
                    mult_mod = self.config.extra.mult,
                }
            end
        end
    end
}
local ret_items = {
   jetmir,
}
return {
	name = "M Jokers",
	init = function() end,
	items = ret_items,
}