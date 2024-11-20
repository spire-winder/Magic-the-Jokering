function pseudorandom_f_range(seed, min, max)
	local val
	while not val do
		val = pseudorandom(seed) * (max - min) + min
	end
	return val
end

function buff_card(card, amount)
	G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
		local suit_prefix = string.sub(card.base.suit, 1, 1)..'_'
		local rank_suffix = math.fmod(card.base.id + amount - 2, 13) + 2
		if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
		elseif rank_suffix == 10 then rank_suffix = 'T'
		elseif rank_suffix == 11 then rank_suffix = 'J'
		elseif rank_suffix == 12 then rank_suffix = 'Q'
		elseif rank_suffix == 13 then rank_suffix = 'K'
		elseif rank_suffix == 14 then rank_suffix = 'A'
		end
		card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
	return true end }))
end

function damage_card(card, amount)
	G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
		local suit_prefix = string.sub(card.base.suit, 1, 1)..'_'
		local rank_suffix = card.base.id - amount
		if rank_suffix < 2 then
			if card.ability.name == 'Glass Card' then 
                card:shatter()
            else
                card:start_dissolve(nil, i == #G.hand.highlighted)
            end
		else
			rank_suffix = math.fmod(rank_suffix - 2, 13) + 2
			if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
			elseif rank_suffix == 10 then rank_suffix = 'T'
			elseif rank_suffix == 11 then rank_suffix = 'J'
			elseif rank_suffix == 12 then rank_suffix = 'Q'
			elseif rank_suffix == 13 then rank_suffix = 'K'
			elseif rank_suffix == 14 then rank_suffix = 'A'
			end
			card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
		end
	return true end }))
end

function damage_increase()
	amount = 0
	local torbrans = find_joker("mtg-torbran")
	if torbrans[1] then
		for i=1,#torbrans do
			if torbrans[i] ~= card then
				amount = amount + torbrans[i].ability.extra.damage_bonus
			end
		end
	end
	return amount
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
					end_round()
					return true
				end,
			}),
			"other"
		)
end


function deal_damage(card, amount)
	local total_chips = amount * G.GAME.blind.chips / 20
	G.E_MANAGER:add_event(Event({
		trigger = "before",
		func = function()
			card_eval_status_text(card, 'extra', nil, nil, nil, {
			  message = "+" .. number_format(total_chips or 0)
			});
			return true
		end
	}))

	G.E_MANAGER:add_event(Event({
	  blocking = true,
	  trigger = 'ease',
	  ref_table = G.GAME,
	  ref_value = 'chips',
	  ease_to = G.GAME.chips + math.floor(total_chips or 0),
	  delay = 0.2,
	  func = (function(t) return math.floor(t) end)
	}))

	G.E_MANAGER:add_event(Event({
	  func = (function(t) if G.GAME.chips >  G.GAME.blind.chips then 
		G.E_MANAGER:add_event(
			Event({
				trigger = "immediate",
				func = function()
					if G.STATE ~= G.STATES.SELECTING_HAND then
						return false
					end
					G.STATE = G.STATES.HAND_PLAYED
					G.STATE_COMPLETE = true
					end_round()
					return true
				end,
			}),
			"other"
		)
	   end
	  return true end)
	}))
end

function bonus_damage(card, amount)
	local torbrans = find_joker("mtg-torbran")
	if torbrans[1] then
		for i=1,#torbrans do
			if torbrans[i] ~= card then
				amount = amount + torbrans[i].ability.extra.damage_bonus
			end
		end
	end
	local total_chips = amount * G.GAME.blind.chips / 20
	G.E_MANAGER:add_event(Event({
		trigger = "before",
		func = function()
			card_eval_status_text(card, 'extra', nil, nil, nil, {
			  message = "+" .. number_format(total_chips or 0)
			});
			return true
		end
	}))

	G.GAME.mtg_bonus_chips = G.GAME.mtg_bonus_chips + total_chips
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
	  G.ARGS.LOC_COLOURS.hel_ascendant = G.C.HEL_ASCENDANT
	  return lc(_c, _default)
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

local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
G.UIDEF.use_and_sell_buttons = function(card)
			if (card.area == G.pack_cards and G.pack_cards) and card.ability.consumeable then --Add a use button
				if card.ability.set == "Magic" then
					return {
					  n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
						{n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, maxw = 0.9*card.T.w - 0.15, minh = 0.3*card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'use_card', func = 'can_reserve_card'}, nodes={
						  {n=G.UIT.T, config={text = localize('b_take'),colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true}}
						}},
					}}
				end
			end
			return G_UIDEF_use_and_sell_buttons_ref(card)
end