SMODS.Joker{
    key = "jesterhat",
    atlas = 'mtg_atlas2',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 5,
    eternal_compat = false,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.selling_self then
            for i=1,2 do
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = (function()
                                local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, "c_hanged_man")
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                G.GAME.consumeable_buffer = 0
                            return true
                        end)}))
                end
            end
        end
    end,
}

SMODS.Joker{
    key = "impseal",
    atlas = 'mtg_atlas2',
    pos = { x = 0, y = 1 },
    rarity = 3,
    cost = 7,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            seal_count = 0
            for k, v in pairs(G.playing_cards) do
                if v.seal ~= nil then seal_count = seal_count+1 end
            end
            return {
                message = localize{type='variable',key='a_xmult',vars={seal_count*0.75}},
                Xmult_mod = 1 + seal_count*0.75
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        if not G.playing_cards then
            return {
                vars = {
                    0
                }
            }
        end
        seal_count = 0
        for k, v in pairs(G.playing_cards) do
            if v.seal ~= nil then seal_count = seal_count+1 end
        end
        return {
            vars = {
                1 + seal_count * 0.75
            }
        }
    end,
}

SMODS.Joker{
    key = "birds",
    atlas = 'mtg_atlas2',
    pos = { x = 1, y = 1 },
    rarity = 2,
    cost = 4,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            local suits = {
                ['Hearts'] = 0,
                ['Diamonds'] = 0,
                ['Spades'] = 0,
                ['Clubs'] = 0
            }
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i].ability.name ~= 'Wild Card' then
                    if context.scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
                    elseif context.scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
                    elseif context.scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
                    elseif context.scoring_hand[i]:is_suit('Clubs', true) and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
                end
            end
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i].ability.name == 'Wild Card' then
                    if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
                    elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
                    elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
                    elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
                end
            end
            if suits["Hearts"] > 0 and
            suits["Diamonds"] > 0 and
            suits["Spades"] > 0 and
            suits["Clubs"] > 0 then
                return {
                    message = 'Again!',
					repetitions = 1,
					card = context.other_card
                }
            end
        end
    end,
}   

SMODS.Joker{
    key = "balance",
    atlas = 'mtg_atlas2',
    pos = { x = 2, y = 1 },
    rarity = 3,
    cost = 8,
}   


SMODS.Joker {
	key = 'cycrift',
	config = { extra = { chips = 0, chip_gain = -5, mult = 1, mult_gain = 1 } },
	rarity = 2,
    atlas = 'mtg_atlas2',
    blueprint_compat = true,
	pos = { x = 2, y = 0 },
	cost = 7,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.chip_gain,  card.ability.extra.mult, card.ability.extra.mult_gain,} }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chip_mod = card.ability.extra.chips,
                Xmult_mod = card.ability.extra.mult,
                remove_default_message = true,
                message = card.ability.extra.chips .. 'Chips & X' .. card.ability.extra.mult .. " Mult",
			}
		end

		if context.setting_blind and not context.blueprint then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
		end
	end
}

SMODS.Joker {
	key = 'bolas',
	config = {},
	rarity = 4,
	atlas = 'mtg_atlas2',
	pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },
	cost = 20,

    update = function(self, card, front)
		if G.STAGE == G.STAGES.RUN then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
                    if i == 1 then
                        other_joker = nil
                    else
					    other_joker = G.jokers.cards[i - 1]
                    end
				end
			end
			if other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat then
				card.ability.blueprint_compat = "compatible"
			else
				card.ability.blueprint_compat = "incompatible"
			end
		end
	end,

    loc_vars = function(self, info_queue, card)
        card.ability.blueprint_compat_ui = card.ability.blueprint_compat_ui or ""
        card.ability.blueprint_compat_check = nil
		return {
			main_end = (card.area and card.area == G.jokers) and {
				{
					n = G.UIT.C,
					config = { align = "bm", minh = 0.4 },
					nodes = {
						{
							n = G.UIT.C,
							config = {
								ref_table = card,
								align = "m",
								colour = G.C.JOKER_GREY,
								r = 0.05,
								padding = 0.06,
								func = "blueprint_compat",
							},
							nodes = {
								{
									n = G.UIT.T,
									config = {
										ref_table = card.ability,
										ref_value = "blueprint_compat_ui",
										colour = G.C.UI.TEXT_LIGHT,
										scale = 0.32 * 0.8,
									},
								},
							},
						},
					},
				},
			} or nil,
		}
	end,

	calculate = function(self, card, context)
        local other_joker = nil
        for i = 2, #G.jokers.cards do
            if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i-1] end
        end
        if not context.retrigger_joker_check then

            if other_joker and other_joker ~= card then
                context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
                context.copy_depth = (context.copy_depth and (context.copy_depth + 1)) or 1
                context.blueprint_card = context.blueprint_card or card
                if context.blueprint > #G.jokers.cards + 1 then return end
                context.no_callback = true
                local other_joker_ret, trig = other_joker:calculate_joker(context)
                if other_joker_ret then 
                    other_joker_ret.card = context.blueprint_card or card
                    context.no_callback = not (context.copy_depth <= 1)
                    context.copy_depth = context.copy_depth - 1;
                    other_joker_ret.colour = G.C.BLUE
                    return other_joker_ret
                end
            end
        else
            if not context.retrigger_joker and context.other_card == card then
                return {
					repetitions = 1,
                    card = card,
				}
            end
        end
    end,
}

lightingbolt_value = 0


SMODS.Joker{
    key = "bolt",
    atlas = 'mtg_atlas2',
    pos = { x = 1, y = 0 },
    rarity = 1,
    cost = 4,
    eternal_compat = false,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.selling_self then
            lightingbolt_value = lightingbolt_value + 500
            return {
                message = "Bolted"
            }
        end
    end,
}