-- This is where all of the Damage based code will be at

function decrease_rank(card, amount)
	for i=1,amount do
		local rank_data = SMODS.Ranks[card.base.value]
		local behavior = rank_data.strength_effect or { fixed = 1, ignore = false, random = false }
		local new_rank
		if behavior.ignore then
			return true
		elseif not next(rank_data.previous) then
			destroy_cards({card})
			return true
		elseif behavior.random then
			-- TODO doesn't respect in_pool
			new_rank = pseudorandom_element(rank_data.next, pseudoseed('damage_card'))
		else
			local ii = (behavior.fixed and rank_data.next[behavior.fixed]) and behavior.fixed or 1
			new_rank = rank_data.previous[ii]
		end
		assert(SMODS.change_base(card, nil, new_rank))
	end
end

function destroy_cards(cards)
	for i=1, #cards do
		if cards[i].ability.name == 'Glass Card' then 
			cards[i]:shatter()
		else
			cards[i]:start_dissolve(nil, i == 1)
		end
	end
	for i=1, #G.jokers.cards do
		G.jokers.cards[i]:calculate_joker({remove_playing_cards = true, removed = cards})
	end
end

function damage_card(card, amount, repetition)
	G.E_MANAGER:add_event(Event({
		trigger = 'after',
		delay = 0.1,
		func = function()
			card:flip(); play_sound('card1', 1.15); card:juice_up(0.3,
				0.3); return true
		end
	}))
	if not repetition then repetition = 1 end
	amount = modify_damage(card, amount)
	G.E_MANAGER:add_event(Event({
		trigger = 'after',
		delay = 0.1,
		func = function()
			decrease_rank(card, amount * repetition)
		  return true
		end
	}))
	G.E_MANAGER:add_event(Event({
		trigger = 'after',
		delay = 0.1,
		func = function()
			card:flip(); play_sound('tarot2', 0.85, 0.6); card
				:juice_up(
					0.3, 0.3); return true
		end
	}))
	
end

function modify_damage(card, amount)
	amount = amount + damage_additive(card)
	amount = amount * damage_multiple(card)
	return math.floor(amount)
end

function damage_additive(card)
	local amount = 0
	local torbrans = SMODS.find_card("j_mtg_torbran")
	if torbrans[1] then
		for i=1,#torbrans do
			if torbrans[i] ~= card then
				amount = amount + torbrans[i].ability.extra.damage_bonus
			end
		end
	end
	return amount
end

function damage_multiple(card)
	local amount = 1
	local fiery = SMODS.find_card("j_mtg_emancipation")
	if fiery[1] then
		for i=1,#fiery do
			if fiery[i] ~= card then
				amount = amount * fiery[i].ability.extra.damage_mult
			end
		end
	end
	return amount
end

function current_blind_life()
	if G.GAME.round_resets.ante <= 0 then
		return 1
	else
		return G.GAME.round_resets.ante * 5
	end
end

--damage_blind: creates an event to damage the blind
function damage_blind(card, amount, repetition)
	if not repetition then repetition = 1 end
	amount = modify_damage(card, amount) * repetition
	local total_chips = amount * G.GAME.blind.chips / current_blind_life()
	card_eval_status_text(card, 'extra', nil, nil, nil, {message = "+" .. number_format(total_chips or 0)});

	G.E_MANAGER:add_event(Event({
	  blocking = true,
	  trigger = 'ease',
	  ref_table = G.GAME,
	  ref_value = 'chips',
	  ease_to = G.GAME.chips + math.floor(total_chips or 0),
	  delay = 0.2,
	  func = (function(t) return math.floor(t) end)
	}))
	if not SMODS.find_mod("NotJustYet") then
		G.E_MANAGER:add_event(Event({
		func = (function(t) if G.GAME.chips >=  G.GAME.blind.chips then 
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
end

--damage_blind: creates an event to damage the blind, use this when other events are happening
function bonus_damage(card, amount, repetition)
	if not repetition then repetition = 1 end
	amount = modify_damage(card, amount) * repetition
	local total_chips = amount * G.GAME.blind.chips / current_blind_life()
	card_eval_status_text(card, 'extra', nil, nil, nil, {
		message = "+" .. number_format(total_chips or 0)
	  });
	G.GAME.mtg_bonus_chips = G.GAME.mtg_bonus_chips + total_chips
end
