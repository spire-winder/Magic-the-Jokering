SMODS.Sticker {
    key = "mtg_energy",
    order = 1,
    name = "energy",
    atlas = "energy",
    pos = { x = 0, y = 0 },
    badge_colour = HEX("59595b"),
    rate = 0.0,
    hide_badge = true,
    --config = { extra = { energy = 1 } },
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = {type = "sticker", key = "mtg_energy", set = "other"}
    end
}