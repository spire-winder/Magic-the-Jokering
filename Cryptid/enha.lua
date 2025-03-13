-- cryptid enhancements
local leonin ={
    object_type = "Enhancement",
    name = 'leonin warleader',
    key = 'leonin_warleader',
    atlas = 'mtg_atlas',
    pos = { x = 0, y = 1 },
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

local mtg_atlas = {
    object_type = "Atlas",
    key = 'mtg_atlas',
    path = 'mtg_atlas.png',
    px = 0,
    py = 1,
}


local ret_items = {
    --leonin,
}

return {
    name = "MTJ enhancements",
    init = function() end,
    items = ret_items,
}