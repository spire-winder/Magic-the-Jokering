
----------------------------------------------
------------MOD CODE -------------------------

if not MTJ then
	MTJ = {}
end

MagicTheJokering = SMODS.current_mod
-- Load Options
MagicTheJokering_config = MagicTheJokering.config
-- This will save the current state even when settings are modified
MagicTheJokering.enabled = copy_table(MagicTheJokering_config)

SMODS.Atlas { key = 'mtg_lc_cards', path = '8BitDeck.png', px = 71, py = 95 }
SMODS.Atlas { key = 'mtg_hc_cards', path = '8BitDeck_opt2.png', px = 71, py = 95 }
SMODS.Atlas { key = 'mtg_lc_ui', path = 'ui_assets.png', px = 18, py = 18 }
SMODS.Atlas { key = 'mtg_hc_ui', path = 'ui_assets_opt2.png', px = 18, py = 18 }
SMODS.Atlas ({
	key = "modicon",
	path = "Magic_icon.png",
	px = 34,
	py = 34,
})
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
SMODS.Atlas({
	object_type = "Atlas",
	key = "urza_mine",
	path = "urza-mine.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	object_type = "Atlas",
	key = "urza-power",
	path = "urza-plant.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	object_type = "Atlas",
	key = "urza-tower",
	path = "urza-tower.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	object_type = "Atlas",
	key = "energy",
	path = "energy.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	object_type = "Atlas",
	key = "thopter",
	path = "thopter.png",
	px = 71,
	py = 96,
})
SMODS.Atlas({
	object_type = "Atlas",
	key = "mtg_atlas2",
	path = "Jokers.png",
	px = 71,
	py = 95,
})

assert(SMODS.load_file("lib/utility.lua"))()
assert(SMODS.load_file("lib/Damage.lua"))()
assert(SMODS.load_file("lib/energy.lua"))()
init_planeswalkers()
init_suitless()
if MagicTheJokering.config.include_clover_suit then
	init_clovers()
end
update_ranks()
assert(SMODS.load_file("items/magic.lua"))()
assert(SMODS.load_file("items/jokers.lua"))()
assert(SMODS.load_file("items/enha.lua"))()
assert(SMODS.load_file("items/misc.lua"))()
assert(SMODS.load_file("items/lands.lua"))()
assert(SMODS.load_file("items/seals.lua"))()

-- other mod stuff
if not next(SMODS.find_mod('ScryfallHomepage')) then
	assert(SMODS.load_file("items/scryfall.lua"))()
end



--language stuff
SMODS.Language {key = 'Phyrexian', label = '^new phyrexia.', font = {
    file = "Phi_normal_3.0.ttf",
    render_scale = G.TILESIZE*7,
    TEXT_HEIGHT_SCALE = 0.63,
    TEXT_OFFSET = {x=10,y=-20},
    FONTSCALE = 0.1,
    squish = 1,
    DESCSCALE = 1
}}