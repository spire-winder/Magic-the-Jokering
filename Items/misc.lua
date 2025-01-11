if MagicTheJokering.config.include_clover_suit then
SMODS.Consumable {
	object_type = "Consumable",
	set = "Tarot",
	name = "mtg-forest",
	key = "forest",
	pos = { x = 12, y = 1 },
  cost=3,
	atlas = "mtg_atlas",
	can_use = function(self, card)
		return #G.hand.highlighted <= card.ability.extra.max_selected and #G.hand.highlighted > 0
	end,
  config = { extra = {max_selected = 3}},
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
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() SMODS.change_base(G.hand.highlighted[i],suit_clovers.key,nil);return true end }))
        end
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
        delay(0.5)
	end,
}
end