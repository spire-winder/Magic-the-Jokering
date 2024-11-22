
----------------------------------------------
------------MOD CODE -------------------------

--Will be moved to D20 file when that gets added

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
	object_type = "Atlas",
	key = "mtg_pack",
	path = "mtg_pack.png",
	px = 71,
	py = 95,
})
SMODS.Atlas({
	object_type = "Atlas",
	key = "mtg_tag",
	path = "mtg_tag.png",
	px = 34,
	py = 34,
})



assert(SMODS.load_file("items/utility.lua"))()
init_clover()

update_ranks()
assert(SMODS.load_file("items/magic.lua"))()
assert(SMODS.load_file("items/jokers.lua"))()
assert(SMODS.load_file("items/enha.lua"))()
assert(SMODS.load_file("items/misc.lua"))()
