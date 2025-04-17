-- Energy system for MTG Jokering

-- local array of stuff and things

mtg = {
	config = {
		energy_array = {
			'j_mtg_whirler',
			'j_mtg_decoction'
		},
	},
}

--energy functions

function mtg_check_for_decoction(energy_array)
    for k, v in ipairs(energy_array) do
       if v ==  'j_mtg_decoction' then
		return true
	   end
    end
    return false
end

mtg_energy = G.energy

mtg_inc1 = mtg_energy_storage_inc1

function energy_storage_increase(card, amount)
	local amount = card.ability.extra.add_energy
	G.GAME.mtg_energy_storage = G.GAME.mtg_energy_storage + amount
end

G.energy = function (card, context)
	--if context.main_scoring or context.joker_main then
		G.GAME.mtg_energy_storage = G.GAME.mtg_energy_storage + card.ability.extra.add_energy
	--end
	if G.GAME.mtg_energy_storage <= 0 or G.GAME.mtg_energy_storage > 1e300 then
		G.GAME.mtg_energy_storage = 0
	end
end

function mtg_energy_storage_inc1(card, context)
	G.GAME.mtg_energy_storage = G.GAME.mtg_energy_storage + 1
end

function mtg_increment_energy(card, context)
   -- if card.ability.mtg_energy or mtg_check_for_decoction(mtg.config.energy_array) == true then
        return (G.energy(card, context))
   -- end
end
function require_token_count(card, context)
	return G.GAME.mtg_energy_storage >= card.ability.extra.require_token_count
end

function use_energy(card)
	G.GAME.mtg_energy_storage = G.GAME.mtg_energy_storage - card.ability.extra.require_token_count
	SMODS.trigger_effects({eval_card(card, { use_energy = true })})
end

function G.FUNCS.can_use_energy(e)
	local c1 = e.config.ref_table
	if require_token_count(c1) then
		e.config.colour = G.C.GOLD
		e.config.button = 'use_energy'
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

function G.FUNCS.use_energy(e)
	 local c1 = e.config.ref_table
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0.1,
		func = function()
			use_energy(c1)
			return true
		end,
	}))
	G.jokers:unhighlight_all()
end
