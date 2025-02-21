-- cryptid enhancements

SMODS.Enhancement {
    name = 'leonin warleader',
    key = 'leonin_warleader',
    atlas = 'mtg_atlas',
    pos = { x = 0, y = 1 },
    order = 0,
    config = {mtg_energy = false},
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