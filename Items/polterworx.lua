-- polterworx Cross mod content

if not POLTERWORX3rdParty then
	POLTERWORX3rdParty = {
		Bans = {},
		SuitLeveling = {},
	}
end

table.insert(POLTERWORX3rdParty.SuitLeveling, {
	Suit = 'mtg_Clovers',
	Chips = 2,
	Mult = 5
})

table.insert(POLTERWORX3rdParty.Bans,{
    "c_mtg_obliterate",
    "c_mtg_angerofthegods",
    "c_mtg_grapeshot",
    "c_mtg_lavaaxe",
    "c_mtg_flameslash",
    "c_mtg_lightningbolt",
    "c_mtg_monstrousonslaught",
    "j_mtg_wastenot",
    "j_mtg_emancipation",
    "j_mtg_vortex",
    "j_mtg_torbran",
    "j_mtg_bolt",
    'j_mtg_whirler',
    'j_mtg_decoction',
    'j_scry_bolt',
    "j_mtg_bolas",
    "j_mtg_omniscience"
})

SMODS.Rarity{
    key = "mtg_Eldrazi_Titan",
    loc_txt = {
        name = 'Eldrazi Titan',
    },
    badge_colour = HEX('707070')
}

SMODS.Joker {
    key = "Ulamog",
    config = {extra = {power = 1, power_mod = 1, count = 0}},
    pos = {x = 14, y = 2},
    atlas = "mtg_atlas",
    discovered = true,
    unique = true,
    rarity = "mtg_Eldrazi_Titan",
    loc_txt = {
        name = "Ulamog, the Infinite Gyre",
        text = {
            "For every {C:attention}four 10's{} scored",
            "Increase Ulamog, the Infinite Gyre's power by {C:attention}#2#",
            "Gives {X:black,C:inactive,s:4}^^^^#1#{} {C:chips}chips{} and {C:mult}mult{}",
            "per card scored",
        },
    },
    cant_scare = true,
    no_doe = true,
    blueprint_compat = false,
    immune_to_vermillion = true,
    unlocked = true,
    eternal_compat = true,
    perishable_compat = false,
    immutable = true,
    no_mysterious = true,
    debuff_immune = true,
    dissolve_immune = true,
    permaeternal = true,
    loc_vars = function(self, info_queue, center)
        return {
            vars = {center.ability.extra.power, center.ability.extra.power_mod},
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 10 then
                card.ability.extra.count = card.ability.extra.count + 1
            end
        end
        if card.ability.extra.count >= 4 then
            card.ability.extra.power = card.ability.extra.power + card.ability.extra.power_mod
            card.ability.extra.count = 0
        end
        if context.cardarea == G.play and context.individual then
            return {
                hypermult_mod = {card.ability.extra.power_mod, 10^300},
                hyperchip_mod = {card.ability.extra.power_mod, 10^300},
            }
        end
    end,
}

local count = 0

SMODS.Joker {
    key = "Kozilek",
    pos = {x = 15, y = 2},
    atlas = "mtg_atlas",
    discovered = true,
    unique = true,
    rarity = "mtg_Eldrazi_Titan",
    loc_txt = {
        name = "Kozilek, Butcher of Truth",
        text = {
            "For every {C:attention}7{} that is scored",
            "you gain {X:dark_edition,C:mult}^^^^7{C:mult} Mult{}",
            "Reduce the Blind size by {C:attention}42%{}",
            "And gain {X:dark_edition,C:chips}^^^^7{C:chips} chips",
            "Retrigger all other jokers and card {C:attention}14{} times",
            "Copy every scored card {C:attention}7{} times",
            "if you have Leviathan, destroy it and set blind size to {C:attention}1{}",
            "if you have {C:attention}7{} or more cards in played hand, gain {X:dark_edition,C:attention}10^7{} Malice"
        },
    },
    cant_scare = true,
    no_doe = true,
    blueprint_compat = false,
    immune_to_vermillion = true,
    unlocked = true,
    eternal_compat = true,
    perishable_compat = false,
    immutable = true,
    no_mysterious = true,
    debuff_immune = true,
    dissolve_immune = true,
    permaeternal = true,
    calculate = function(self, card, context)
		if not context.blueprint and not context.repetition then
			if context.retrigger_joker_check and not context.retrigger_joker and context.other_joker ~= self then
                return {repetitions = 14}
            end
        end
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 7 then
				local sevens = {}
				for i = 1, 7 do
					local seven = copy_card(context.other_card, nil, nil, G.playing_card)
					seven:add_to_deck()
					seven:start_materialize()
					G.deck.config.card_limit = G.deck.config.card_limit + 1
					table.insert(sevens, seven)
				end
				for k, seven in pairs(sevens) do
					if seven ~= context.other_card then
						table.insert(G.playing_cards, seven)
						G.deck:emplace(seven)
					end
				end
                return {
                    hypermult_mod = {100, 10^300},
                    hyperchip_mod = {100, 10^300},
                    repetitions = 14,
                    nil, true
                }
            elseif context.other_card:get_id() ~= 7 then
				local sevens = {}
				for i = 1, 7 do
					local seven = copy_card(context.other_card, nil, nil, G.playing_card)
					seven:add_to_deck()
					seven:start_materialize()
					G.deck.config.card_limit = G.deck.config.card_limit + 1
					table.insert(sevens, seven)
				end
				for k, seven in pairs(sevens) do
					if seven ~= context.other_card then
						table.insert(G.playing_cards, seven)
						G.deck:emplace(seven)
					end
				end
                return {
                    hypermult_mod = {100, 10^300},
                    hyperchip_mod = {100, 10^300},
                    repetitions = 14,
                    nil, true
                }
            end
            if (G.SETTINGS.FASTFORWARD or 0) < 1 and (G.SETTINGS.STATUSTEXT or 0) < 2 then
                card_status_text(card, '-42% Blind Size', nil, 0.05*card.T.h, G.C.FILTER, 0.75, 1, 0.6, nil, 'bm', 'generic1')
            end
            change_blind_size(to_big(G.GAME.blind.chips) / to_big(1.07), (G.SETTINGS.FASTFORWARD or 0) > 1, (G.SETTINGS.FASTFORWARD or 0) > 1)
            return nil, true
        end
        local mod = 10^7
        if context.before then
            if #G.play.cards >= 7 then
                add_malice(mod, true, true)
            end
            if #SMODS.find_card('j_jen_leviathan') >= 1 then
                for k, v in pairs(SMODS.find_card('j_jen_leviathan')) do
                    v:destroy()
                end
                change_blind_size(1, true, true)
            end
        end
    end,
}
SMODS.Atlas({
    key = "omega_lotus",
    path = "lotus_soul.png",
    px = 71,
    py = 95,
})

-- omega consumeables

local randtext = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',' ','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9','+','-','?','!','$','%','[',']','(',')'} -- code from polterworx

local function obfuscatedtext(length)
	local str = ''
	for i = 1, length do
		str = str .. randtext[math.random(#randtext)]
	end
	return str
end -- code from polterworx

local num_chance = 0

SMODS.Consumable {
    key = "blacklotus_omega",
    loc_txt = {
        name = "{C:red,s:3}Balatro\'s Lotus",
        text = {
			'{C:inactive,s:5,E:1}?????'
        },
    },
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0, extra = {x = 2, y = 0} },
	cost = 0,
	soul_rate = 0,
	gloss = true,
    set = "jen_omegaconsumable",
	hidden = true,
	hidden2 = true,
	unlocked = true,
	discovered = true,
	no_doe = true,
    atlas = "omega_lotus",
    can_use = function(self, card)
		return jl.canuse() and not ((G.GAME or {}).banned_keys or {}).c_mtg_blacklotus_omega and #SMODS.find_card('j_mtg_Ulamog', true) <= 0
	end,
	use = function(self, card, area, copier)
		if not G.GAME.banned_keys then G.GAME.banned_keys = {} end
		G.GAME.banned_keys.c_mtg_blacklotus_omega = true
		jl.rd(1)
		for i = 1, 60 do
			card_status_text(card, obfuscatedtext(math.random(6,18)), nil, 0.05*card.T.h, G.C.RED, 0.6, 2.5 - (i/50), 0.4, 0.4, 'bm', 'generic1')
		end
          local random_value = pseudorandom_i_range(pseudoseed("blacklotus_omega"), 1, 2)
        if random_value == 1 then
            Q(function()
                for k, v in pairs(G.jokers.cards) do
                    v:destroy()
                end
                for k, v in pairs(G.consumeables.cards) do
                    v:destroy()
                end
                for k, v in pairs(G.playing_cards) do
                    v:destroy()
                end
                for k, v in pairs(G.GAME.tags) do
                    v:remove()
                end
            return true end)
            jl.rd(3)
            if G.GAME.round_resets.ante > 2 then ease_ante(math.floor(-G.GAME.round_resets.ante / 4 * 3), true, true, true) end
            createfulldeck()
            jl.a('Baaaa.', G.SETTINGS.GAMESPEED, 1, G.C.RED)
            card.sell_cost = 0
            Q(function()
                local ulamog = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_mtg_Ulamog')
                ulamog.ability.eternal = true
                ulamog:add_to_deck()
                G.jokers:emplace(ulamog)
                QR(function() G.jokers:set_size_absolute(5) set_dollars(4) return true end, 99)
                G.consumeables:change_size_absolute(G.consumeables.config.card_limit)
            return true end, 1)
            if G.GAME.banned_keys.c_jen_soul_omega == true then
                Q(function()
                    local kosmos = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_jen_kosmos', 'thekingslayer')
                    kosmos.ability.eternal = true
                    kosmos:add_to_deck()
                    G.jokers:emplace(kosmos)
                    QR(function() G.jokers:set_size_absolute(5) set_dollars(4) return true end, 99)
                    G.consumeables:change_size_absolute(G.consumeables.config.card_limit)
		        return true end, 1)
            end
        elseif random_value == 2 then
            Q(function()
                for k, v in pairs(G.jokers.cards) do
                    v:destroy()
                end
                for k, v in pairs(G.consumeables.cards) do
                    v:destroy()
                end
                for k, v in pairs(G.playing_cards) do
                    v:destroy()
                end
                for k, v in pairs(G.GAME.tags) do
                    v:remove()
                end
            return true end)
            jl.rd(3)
            if G.GAME.round_resets.ante > 2 then ease_ante(math.floor(-G.GAME.round_resets.ante / 4 * 3), true, true, true) end
            createfulldeck()
            jl.a('Baaaa.', G.SETTINGS.GAMESPEED, 1, G.C.RED)
            card.sell_cost = 0
            Q(function()
                local kozilek = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_mtg_Kozilek')
                kozilek.ability.eternal = true
                kozilek:add_to_deck()
                G.jokers:emplace(kozilek)
                QR(function() G.jokers:set_size_absolute(5) set_dollars(4) return true end, 99)
                G.consumeables:change_size_absolute(G.consumeables.config.card_limit)
            return true end, 1)
            if G.GAME.banned_keys.c_jen_soul_omega == true then
                Q(function()
                    local kosmos = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_jen_kosmos', 'thekingslayer')
                    kosmos.ability.eternal = true
                    kosmos:add_to_deck()
                    G.jokers:emplace(kosmos)
                    QR(function() G.jokers:set_size_absolute(5) set_dollars(4) return true end, 99)
                    G.consumeables:change_size_absolute(G.consumeables.config.card_limit)
		        return true end, 1)
            end
        end
    end
}



SMODS.Consumable{
    key = "forest_omega",
    loc_txt = {
        name = "The Forest {C:dark_edition}Omega",
        text = {
            'Enhance all {C:attention}Clovers{} into Exotic Cards'
        },
    },
    pos = { x = 0, y = 1 },
    soul_pos = { x = 1, y = 1 },
    cost = 250,
    soul_rate = 0,
    hidden = true,
    hidden2 = true,
    unlocked = true,
    discovered = true,
    no_doe = true,
    set = "jen_omegaconsumable",
    atlas = 'omega_lotus',
    can_use = function(self, card)
        return jl.canuse()
    end,
    use = function(self, card, area, copier)
        play_sound('jen_pop')
        for k, v in ipairs(G.playing_cards) do
            if v.base.suit == "mtg_Clovers" and not v:nosuit() then
                if v.area == G.hand then
                    Q(function() v:set_ability(G.P_CENTERS['m_jen_exotic']) play_sound('jen_pop') v:juice_up(1, 0.5) return true end, 0.75)
                else
                    v:set_ability(G.P_CENTERS['m_jen_exotic'])
                end
            end
        end
    end
}

SMODS.Consumable{
    key = "Wastes_omega",
    loc_txt = {
        name = "The Wastes {C:dark_edition}Omega",
        text = {
            'Enhance all {C:white}Suitless{} into Exotic Cards'
        },
    },
    pos = { x = 0, y = 2 },
    soul_pos = { x = 1, y = 2 },
    cost = 250,
    soul_rate = 0,
    hidden = true,
    hidden2 = true,
    unlocked = true,
    discovered = true,
    no_doe = true,
    set = "jen_omegaconsumable",
    atlas = 'omega_lotus',
    can_use = function(self, card)
        return jl.canuse()
    end,
    use = function(self, card, area, copier)
        play_sound('jen_pop')
        for k, v in ipairs(G.playing_cards) do
            if v.base.suit == "mtg_Suitless" and not v:nosuit() then
                if v.area == G.hand then
                    Q(function() v:set_ability(G.P_CENTERS['m_jen_exotic']) play_sound('jen_pop') v:juice_up(1, 0.5) return true end, 0.75)
                else
                    v:set_ability(G.P_CENTERS['m_jen_exotic'])
                end
            end
        end
    end
}

SMODS.Consumable{
    key = "mountain_land_omega",
    loc_txt = {
        name = "{C:red}Mountain{} {C:dark_edition}Omega",
        text = {
            'Enhance all {C:red}Hearts{} into {C:attention}Mountains{}',
            'and all {C:attention}non-Heart suits{} into {C:red}Hearts{}'
        },
    },
    pos = { x = 0, y = 3 },
    soul_pos = { x = 1, y = 3, extra = {x = 2, y = 3} },
    cost = 250,
    soul_rate = 0,
    hidden = true,
    hidden2 = true,
    unlocked = true,
    discovered = true,
    no_doe = true,
    set = "jen_omegaconsumable",
    atlas = 'omega_lotus',
    can_use = function(self, card)
        return jl.canuse()
    end,
    use = function(self, card, area, copier)
        play_sound('jen_pop')
        for k, v in ipairs(G.playing_cards) do
            if v.base.suit == "Hearts" and not v:nosuit() then
                if v.area == G.hand then
                    Q(function() v:set_ability(G.P_CENTERS['m_mtg_Mountain_land']) play_sound('jen_pop') v:juice_up(1, 0.5) return true end, 0.75)
                else
                    v:set_ability(G.P_CENTERS['m_mtg_Mountain_land'])
                end
            elseif v.base.suit ~= "Hearts" and not v:nosuit() then
                if v.area == G.hand then
                    Q(function() v:change_suit('Hearts') play_sound('jen_pop') v:juice_up(1, 0.5) return true end, 0.75)
                else
                    v:change_suit('Hearts')
                end
            end
        end
    end
}

SMODS.Consumable{
    key = "forest_land_omega",
    loc_txt = {
        name = "{C:green}Forest{} {C:dark_edition}Omega",
        text = {
            'Enhance all {C:green}Clovers{} into {C:attention}Forests{}',
            'and all {C:attention}non-Clover suits{} into {C:green}Clovers{}'
        },
    },
    pos = { x = 0, y = 4 },
    soul_pos = { x = 1, y = 4, extra = {x = 2, y = 4} },
    cost = 250,
    soul_rate = 0,
    hidden = true,
    hidden2 = true,
    unlocked = true,
    discovered = true,
    no_doe = true,
    set = "jen_omegaconsumable",
    atlas = 'omega_lotus',
    can_use = function(self, card)
        return jl.canuse()
    end,
    use = function(self, card, area, copier)
        play_sound('jen_pop')
        for k, v in ipairs(G.playing_cards) do
            if v.base.suit == "mtg_Clovers" and not v:nosuit() then
                if v.area == G.hand then
                    Q(function() v:set_ability(G.P_CENTERS['m_mtg_Forest_land']) play_sound('jen_pop') v:juice_up(1, 0.5) return true end, 0.75)
                else
                    v:set_ability(G.P_CENTERS['m_mtg_Forest_land'])
                end
            elseif v.base.suit ~= "mtg_Clovers" and not v:nosuit() then
                if v.area == G.hand then
                    Q(function() v:change_suit('mtg_Clovers') play_sound('jen_pop') v:juice_up(1, 0.5) return true end, 0.75)
                else
                    v:change_suit('mtg_Clovers')
                end
            end
        end
    end
}

function chance_for_omegal(is_lotus)
	if is_lotus and type(is_lotus) == 'string' then
		is_lotus = (is_lotus or '') == 'blacklotus'
	end
	local chance = (Jen.config.omega_chance * (is_lotus and Jen.config.soul_omega_mod or 1)) - 1
	if #SMODS.find_card('j_jen_apollo') > 0 then
		for _, claunecksmentor in ipairs(SMODS.find_card('j_jen_apollo')) do
			if is_lotus then
				chance = chance / (((claunecksmentor.ability.omegachance_amplifier < Jen.config.soul_omega_mod and 1 or 0) + claunecksmentor.ability.omegachance_amplifier) / Jen.config.soul_omega_mod)
			else
				chance = chance / claunecksmentor.ability.omegachance_amplifier
			end
		end
	end
	if G.GAME and G.GAME.obsidian then chance = chance / 2 end
	return chance + 1
end

local omegaconsumables = {
    'blacklotus',
}

local omegas_found = 0

local ccr = create_card

function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	local card = ccr(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	if G.STAGE ~= G.STAGES.MAIN_MENU and card.gc then
		local cen = card:gc()
		for k, v in ipairs(omegaconsumables) do
			if cen.key == ('c_mtg_' .. v) and G.P_CENTERS['c_mtg_' .. v .. '_omega'] and not G.GAME.banned_keys['c_mtg_' .. v .. '_omega'] and jl.chance('omega_replacement', chance_for_omegal(v), true) then
				G.E_MANAGER:add_event(Event({trigger = 'after', blockable = false, blocking = false, func = function()
					if card and not card.no_omega then
						card:set_ability(G.P_CENTERS['c_mtg_' .. v .. '_omega'])
						card:set_cost()
						if chance_for_omegal(v) > 10 then play_sound('jen_omegacard', 1, 0.4) end
						card:juice_up(1.5, 1.5)
						if omegas_found <= 0 then
							Q(function() play_sound_q('jen_chime', 1, 0.65); jl.a('Omega!' .. (omegas_found > 1 and (' x ' .. number_format(omegas_found)) or ''), G.SETTINGS.GAMESPEED, 1, G.C.jen_RGB); jl.rd(1); omegas_found = 0; return true end)
						end
						omegas_found = omegas_found + 1
					end
					return true
				end }))
				break
			end
		end
	end
	return card
end