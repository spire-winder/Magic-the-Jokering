local leonin ={
    object_type = "Enhancement",
    name = 'leonin warleader',
    key = 'leonin_warleader',
    atlas = 'atlas',
    pos = { x = 10, y = 6 },
    order = 0,
    config = {mtg_energy = false},
    gameset_config = {
		modest = { disabled = true },
		mainline = { disabled = true },
		madness = { disabled = false },
		experimental = {disabled = true},
    },
    dependincies = {
        items = {
            'set_cry_tag',
        },
    },
    weight = 1,
    loc_vars = function(self, info_queue, center)
        return {  }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
				add_tag(Tag('tag_cry_cat'))
				return true
			end }))
        end
    end
}

local jetmir = {
    object_type = "Joker",
    name = "mtg-jetmir",
    key = "jetmir",
    order = 17,
    config = {extra = { mult = 10, x_mult = 10, power = 10}},
    gameset_config = {
		modest = { disabled = true },
		mainline = { extra = { mult = 2, x_mult = 2, power = 2 }, disabled = false },
		madness = { extra = { mult = 10, x_mult = 10, power = 10 }, disabled = false },
		experimental = {disabled = true},
    },
    dependencies = {
        items = {
            "set_cry_epic",
            "set_cry_tag",
        },
    },
    pos = { x = 9, y = 6 },
    atlas = "atlas",
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

local mtg_atlas = {
    object_type = "Atlas",
    key = 'atlas',
    path = 'mtg_atlas.png',
    px = 71,
    py = 95,
}


local ret_items = {
    jetmir,
    leonin,
}

return {
    name = "MTJ cards",
    init = function()end,
    items = ret_items,
}

--]]