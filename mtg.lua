
----------------------------------------------
------------MOD CODE -------------------------

MagicTheJokering = SMODS.current_mod
-- Load Options
MagicTheJokering_config = MagicTheJokering.config
-- This will save the current state even when settings are modified
MagicTheJokering.enabled = copy_table(MagicTheJokering_config)

SMODS.Atlas { key = 'mtg_lc_cards', path = '8BitDeck.png', px = 71, py = 95 }
SMODS.Atlas { key = 'mtg_hc_cards', path = '8BitDeck_opt2.png', px = 71, py = 95 }
SMODS.Atlas { key = 'mtg_lc_ui', path = 'ui_assets.png', px = 18, py = 18 }
SMODS.Atlas { key = 'mtg_hc_ui', path = 'ui_assets_opt2.png', px = 18, py = 18 }
SMODS.Atlas({
	key = "mtg_atlas",
	path = "mtg_atlas.png",
	px = 71,
	py = 95,
}):register()
SMODS.Atlas({
	key = "kiki",
	path = "kiki.png",
	px = 71,
	py = 95,
}):register()
SMODS.Atlas({
	key = "power",
	path = "power_matrix.png",
	px = 71,
	py = 95,
}):register()
SMODS.Atlas({
	key = "tiny",
	path = "tinybones.png",
	px = 71,
	py = 95,
}):register()
SMODS.Atlas({
	key = "chromatic",
	path = "chromatic.png",
	px = 71,
	py = 95,
}):register()
SMODS.Atlas({
	key = "lotus",
	path = "black lotus.png",
	px = 71,
	py = 95,
}):register()
SMODS.Atlas({
	object_type = "Atlas",
	key = "mtg_pack",
	path = "mtg_pack.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	object_type = "Atlas",
	key = "forest",
	path = "forest.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	object_type = "Atlas",
	key = "island",
	path = "island.png",
	px = 71,
	py = 95,
})
-- [[
SMODS.Atlas({
	object_type = "Atlas",
	key = "mountain",
	path = "mountain.png",
	px = 71,
	py = 95,
})
--]]
-- [[
SMODS.Atlas({
	object_type = "Atlas",
	key = "plains",
	path = "plains.png",
	px = 71,
	py = 95,
})
--]]
-- [[
SMODS.Atlas({
	object_type = "Atlas",
	key = "swamp",
	path = "swamp.png",
	px = 71,
	py = 95,
})
--]]

SMODS.Atlas({
	object_type = "Atlas",
	key = "mtg_tag",
	path = "mtg_tag.png",
	px = 34,
	py = 34,
})
SMODS.Atlas({
	object_type = "Atlas",
	key = "mtg_back",
	path = "un_back.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	object_type = "Atlas",
	key = "land_pack",
	path = "land_booster.png",
	px = 71,
	py = 95,
})

--[[
for checking if a mod is enabled
	
	
]]

assert(SMODS.load_file("items/utility.lua"))()
init_planeswalkers()
if MagicTheJokering.config.include_clover_suit then
	init_clovers()
end
update_ranks()
assert(SMODS.load_file("items/magic.lua"))()
assert(SMODS.load_file("items/jokers.lua"))()
assert(SMODS.load_file("items/enha.lua"))()
assert(SMODS.load_file("items/misc.lua"))()
assert(SMODS.load_file("items/lands.lua"))()
