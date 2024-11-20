
----------------------------------------------
------------MOD CODE -------------------------

--Will be moved to D20 file when that gets added


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
assert(SMODS.load_file("items/magic.lua"))()
assert(SMODS.load_file("items/jokers.lua"))()