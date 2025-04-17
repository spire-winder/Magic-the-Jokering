
SMODS.current_mod.optional_features = {
	retrigger_joker = true,
}


function pseudorandom_i_range(seed, min, max)
	local val
	while not val do
		val = math.floor(pseudorandom(seed) * (max + 1 - min) + min)
	end
	return val
end

function pseudorandom_f_range(seed, min, max)
	local val
	while not val do
		val = pseudorandom(seed) * (max - min) + min
	end
	return val
end

SMODS.Consumable:take_ownership('strength', {
	use = function(self, card, area, copier)
		local used_tarot = copier or card
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.4,
			func = function()
				play_sound('tarot1')
				used_tarot:juice_up(0.3, 0.5)
				return true
			end
		}))
		G.FUNCS.buff_cards(G.hand.highlighted,1)
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.2,
			func = function()
				G.hand:unhighlight_all(); return true
			end
		}))
		delay(0.5)
	end,
})

G.FUNCS.buff_cards = function(cards, amount, repetition, enhancement)
	if not repetition then repetition = 1 end
	for i = 1, #cards do
		local percent = 1.15 - (i - 0.999) / (#cards - 0.998) * 0.3
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.15,
			func = function()
				cards[i]:flip(); play_sound('card1', percent); cards[i]:juice_up(0.3,
					0.3); return true
			end
		}))
	end
	delay(0.2)
	if amount then
		amount = modify_buff(card, amount)
		for i = 1, #cards do
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
			increase_rank(cards[i], amount * repetition) return true
		end
	}))
		end
	end
	if enhancement then
		for i = 1, #cards do
			if enhancement == "random" then
				local cen_pool = {}
				for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
				if v.key ~= 'm_stone' and not v.overrides_base_rank then
					cen_pool[#cen_pool + 1] = v
				end
				end
				enhancement = pseudorandom_element(cen_pool, pseudoseed("mtg-random_enhancement"))
			else
				enhancement = G.P_CENTERS[enhancement]
			end
			cards[i]:set_ability(enhancement, nil, true)
		end
	end
	for i = 1, #cards do
		local percent = 0.85 + (i - 0.999) / (#cards - 0.998) * 0.3
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.15,
			func = function()
				cards[i]:flip(); play_sound('tarot2', percent, 0.6); cards[i]
					:juice_up(
						0.3, 0.3); return true
			end
		}))
	end
	--[[G.E_MANAGER:add_event(Event({
		func = function()
			card:flip(); play_sound('card1', 1.15); card:juice_up(0.3,
				0.3); return true
		end
	}))
	if amount then
		amount = modify_buff(card, amount)
		G.E_MANAGER:add_event(Event({
			func = function()
				increase_rank(card, amount * repetition)
			return true
			end
		}))
	end
	if enhancement then
		if enhancement == "random" then
			local cen_pool = {}
			for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
			if v.key ~= 'm_stone' and not v.overrides_base_rank then
				cen_pool[#cen_pool + 1] = v
			end
			end
			enhancement = pseudorandom_element(cen_pool, pseudoseed("mtg-random_enhancement"))
		else
			enhancement = G.P_CENTERS[enhancement]
		end
		card:set_ability(enhancement, nil, true)
	end
		G.E_MANAGER:add_event(Event({
			func = function()
				card:flip(); play_sound('tarot2', 0.85, 0.6); card
					:juice_up(
						0.3, 0.3); return true
			end
		}))]]
end

function increase_rank(card, amount)
	for i=1,amount do
		local rank_data = SMODS.Ranks[card.base.value]
		local behavior = rank_data.strength_effect or { fixed = 1, ignore = false, random = false }
		local new_rank
		if behavior.ignore or not next(rank_data.next) then
				return true
		elseif behavior.random then
				new_rank = pseudorandom_element(rank_data.next, pseudoseed('buff_card'))
		else
			local ii = (behavior.fixed and rank_data.next[behavior.fixed]) and behavior.fixed or 1
			new_rank = rank_data.next[ii]
		end
		assert(SMODS.change_base(card, nil, new_rank))
	end
end

function stop_debuff_card(card)
	G.E_MANAGER:add_event(Event({
		func = function()
			card:flip(); play_sound('card1', 1.15); card:juice_up(0.3,0.3); return true
		end
	}))
	if amount then
		G.E_MANAGER:add_event(Event({
			func = function()
				card.debuff = false
				card.mtg_debuff_immune = true
			return true
			end
		}))
	end
		G.E_MANAGER:add_event(Event({
			func = function()
				card:flip(); play_sound('tarot2', 0.85, 0.6); card
					:juice_up(
						0.3, 0.3); return true
			end
		}))
end

function reanimate()
	if #G.jokers.cards >= G.jokers.config.card_limit then
		--Maybe tell the user there was no space?
	else
		local created_card = create_card('Joker', G.jokers, nil, nil, nil, nil, pseudorandom_element(G.GAME.jokers_sold, pseudoseed("mtg-reanimate")))
		--Previously, it also made the joker negative, but I think this is too strong
		--created_card:set_edition({negative = true}, true)
		created_card:add_to_deck()
		G.jokers:emplace(created_card)
		created_card:start_materialize()
	end
	
end

function modify_buff(card, amount)
	amount = amount + buff_additive(card)
	amount = amount * buff_multiple(card)
	return math.floor(amount)
end

function buff_additive(card)
	local amount = 0
	local scales = SMODS.find_card("j_mtg_hardenedscales")
	if scales[1] then
		for i=1,#scales do
			if scales[i] ~= card then
				amount = amount + scales[i].ability.extra.buff_increase
			end
		end
	end
	return amount
end

function buff_multiple(card)
	local amount = 1
	return amount
end



G.FUNCS.free_jokers = function()
	local helms = SMODS.find_card("j_mtg_omniscience")
	if helms[1] then
		return true
	else
		return false
	end
	
end

G.FUNCS.total_shop_discount = function()
	local amount = 0
	local helms = SMODS.find_card("j_mtg_helmofawakening")
	if helms[1] then
		for i=1,#helms do
			amount = amount + helms[i].ability.extra.discount
		end
	end
	return amount
end

function init_planeswalkers()
end

function instant_win()
	G.E_MANAGER:add_event(
			Event({
				trigger = "immediate",
				func = function()
					if G.STATE ~= G.STATES.SELECTING_HAND then
						return false
					end
					G.GAME.current_round.instant_win = true
					G.STATE = G.STATES.HAND_PLAYED
					G.STATE_COMPLETE = true
					G.GAME.current_round.obliterate = true
					end_round()
					return true
				end,
			}),
			"other"
		)
end

G.FUNCS.draw_from_discard_to_hand = function(e)
    local hand_space = e or math.min(#G.discard.cards, G.hand.config.card_limit - #G.hand.cards)
	for i=1, hand_space do --draw cards from deckL
		draw_card(G.discard,G.hand, i*100/hand_space,'up', true)
	end
end

--Localization colors
local lc = loc_colour
function loc_colour(_c, _default)
	  if not G.ARGS.LOC_COLOURS then
		  lc()
	  end
	  G.ARGS.LOC_COLOURS.heart = G.C.SUITS.Hearts
	  G.ARGS.LOC_COLOURS.diamond = G.C.SUITS.Diamonds
	  G.ARGS.LOC_COLOURS.spade = G.C.SUITS.Spades
	  G.ARGS.LOC_COLOURS.club = G.C.SUITS.Clubs
	  if MagicTheJokering.config.include_clover_suit then
	  	G.ARGS.LOC_COLOURS.clover = G.C.SUITS[suit_clovers.key]
	  end
	  return lc(_c, _default)
end

function init_clovers()
	suit_clovers = SMODS.Suit {
		key = 'Clovers',
		card_key = 'L',
		hc_atlas = 'mtg_hc_cards',
		lc_atlas = 'mtg_lc_cards',
		hc_ui_atlas = 'mtg_hc_ui',
		lc_ui_atlas = 'mtg_lc_ui',
		pos = { y = 0 },
		ui_pos = { x = 0, y = 1 },
		hc_colour = HEX('3dad2f'),
		lc_colour = HEX('359229'),
		in_pool = function(self, args)
			if args and args.initial_deck then
				return false
			end
		end
	}
end

function init_suitless()
	suit_suitless = SMODS.Suit {
		key = 'Suitless',
		card_key = 'N',
		hc_atlas = 'mtg_hc_cards',
		lc_atlas = 'mtg_lc_cards',
		hc_ui_atlas = 'mtg_hc_ui',
		lc_ui_atlas = 'mtg_lc_ui',
		pos = { y = 1 },
		ui_pos = { x = 1, y = 1 },
		hc_colour = HEX('FFFFFF'),
		lc_colour = HEX('FFFFFF'),
		in_pool = function(self, args)
			if args and args.initial_deck then
				return false
			end
		end
	}
end

function update_ranks()
	for k, v in pairs(SMODS.Ranks) do
		for _, r in ipairs(v.next) do
		  local rank = SMODS.Ranks[r]
		  if not rank.previous then
			rank.previous = {}
		  end
		  table.insert(rank.previous, v.key)
		end
	  end
	SMODS.Ranks["2"].previous = { }
end

G.FUNCS.can_reserve_card = function(e)
	if #G.consumeables.cards < G.consumeables.config.card_limit then
		e.config.colour = G.C.GREEN
		e.config.button = "reserve_card"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

G.FUNCS.reserve_card = function(e)
	local c1 = e.config.ref_table
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0.1,
		func = function()
			c1.area:remove_card(c1)
			c1:add_to_deck()
			if c1.children.price then
				c1.children.price:remove()
			end
			c1.children.price = nil
			if c1.children.buy_button then
				c1.children.buy_button:remove()
			end
			c1.children.buy_button = nil
			remove_nils(c1.children)
			G.consumeables:emplace(c1)
			G.GAME.pack_choices = G.GAME.pack_choices - 1
			if G.GAME.pack_choices <= 0 then
				G.FUNCS.end_consumeable(nil, delay_fac)
			end
			return true
		end,
	}))
end

G.FUNCS.use_loyalty_1 = function(e)
	local c1 = e.config.ref_table
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0.1,
		func = function()
			return true
		end,
	}))
	G.jokers:unhighlight_all()
end

G.FUNCS.can_use_loyalty_1 = function(e)
	local c1 = e.config.ref_table
	if true then
		e.config.colour = G.C.GOLD
        e.config.button = 'use_loyalty_1'
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
      	e.config.button = nil
	end
end
-- [[
local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
G.UIDEF.use_and_sell_buttons = function(card)
	local retval = G_UIDEF_use_and_sell_buttons_ref(card)
	if (card.area == G.pack_cards and G.pack_cards) and card.ability.consumeable then --Add a use button
		if card.ability.set == "Magic" then
			return {
				n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
				{n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, maxw = 0.9*card.T.w - 0.15, minh = 0.3*card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'use_card', func = 'can_reserve_card'}, nodes={
					{n=G.UIT.T, config={text = localize('b_take'),colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true}}
				}},
			}}
		end
		if card.ability.set == "Land" then
			return {
				n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
				{n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, maxw = 0.9*card.T.w - 0.15, minh = 0.3*card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'use_card', func = 'can_reserve_card'}, nodes={
					{n=G.UIT.T, config={text = localize('b_take'),colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true}}
				}},
			}}
		end	
	--[[if card.area and card.area.config.type == 'joker' and card.ability.set == 'Joker' then
		local gx = 
		{n=G.UIT.C, config={align = "cl"}, nodes={
		  
			{n=G.UIT.C, config={ref_table = card, align = "cl",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.0, hover = true, shadow = true, colour = G.C.GOLD, one_press = true, button = 'sell_card', func = 'can_use_loyalty_1'}, nodes={
			  {n=G.UIT.B, config = {w=0.1,h=0.6}},
			  {n=G.UIT.C, config={align = "tm"}, nodes={
				  {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
					  {n=G.UIT.T, config={text = localize('b_use'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
				  }},
				  {n=G.UIT.R, config={align = "cm"}, nodes={
					{n=G.UIT.T, config={text = "+2",colour = G.C.WHITE, scale = 0.55, shadow = true}}
				  }}
			  }}
			}},
			{n=G.UIT.C, config={ref_table = card, align = "cl",maxw = 1.25, padding = 0.1, r=0.08, minw = 0.5, hover = true, shadow = true, colour = G.C.GOLD, one_press = true, button = 'sell_card', func = 'can_use_loyalty_1'}, nodes={
				{n=G.UIT.B, config = {w=0.1,h=0.6}},
				{n=G.UIT.C, config={align = "tm"}, nodes={
					{n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
						{n=G.UIT.T, config={text = localize('b_use'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
					}},
					{n=G.UIT.R, config={align = "cm"}, nodes={
					  {n=G.UIT.T, config={text = "-3",colour = G.C.WHITE, scale = 0.55, shadow = true}}
					}}
				}}
			  }},
			  {n=G.UIT.C, config={ref_table = card, align = "cl",maxw = 1.25, padding = 0.1, r=0.08, minw = 0.5, hover = true, shadow = true, colour = G.C.GOLD, one_press = true, button = 'sell_card', func = 'can_use_loyalty_1'}, nodes={
				{n=G.UIT.B, config = {w=0.1,h=0.6}},
				{n=G.UIT.C, config={align = "tm"}, nodes={
					{n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
						{n=G.UIT.T, config={text = localize('b_use'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
					}},
					{n=G.UIT.R, config={align = "cm"}, nodes={
					  {n=G.UIT.T, config={text = "-7",colour = G.C.WHITE, scale = 0.55, shadow = true}}
					}}
				}}
			  }}
		  }}
		retval.nodes[1].nodes[2].nodes = retval.nodes[1].nodes[2].nodes or {}
		table.insert(retval.nodes[1].nodes[2].nodes, gx)
		return retval
	end]]
	end
	return retval
end
--]]
-- SMODS UI funcs (additions, config, collection)

SMODS.current_mod.config_tab = function()
    local scale = 5/6
    return {n=G.UIT.ROOT, config = {align = "cl", minh = G.ROOM.T.h*0.25, padding = 0.0, r = 0.1, colour = G.C.GREY}, nodes = {
        {n = G.UIT.R, config = { padding = 0.05 }, nodes = {
            {n = G.UIT.C, config = { minw = G.ROOM.T.w*0.25, padding = 0.05 }, nodes = {
                create_toggle{ label = localize("include_clover_suit"), info = {localize("mtg_requires_restart"), localize("include_clover_suit_desc_1"), localize("include_clover_suit_desc_2")}, active_colour = MagicTheJokering.badge_colour, ref_table = MagicTheJokering.config, ref_value = "include_clover_suit" }
            }}
        }}
    }}
end
