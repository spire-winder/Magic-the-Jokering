SMODS.ConsumableType {
    object_type = "ConsumableType",
    key = 'Card_token',
    collection_rows = { 3,4 },
    primary_colour = HEX("E08C50"),
    secondary_colour = HEX("97572b"),
    loc_txt = {
        collection = 'Tokens',
        name = 'Card Token',
        label = 'Card Land',
        undiscovered = {
            name = "Not Discovered",
            text = {
                "Aquire this card",
                " in an unseeded run to",
                "discover it"
            },
        },
    },
}

-- [[
SMODS.Consumable {
    object_type = "Consumable",
set = "Card_token",
name = "mtg-energy",
    key = "energy",
    atlas = "mtg_atlas",
    pos = { x = 0, y = 1 },
order = 1,
no_doe = true,
cost = 3,
 config = { extra = { energy = 0 } },
 in_pool = function()
        return false
    end,
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.energy } }
    end,
    can_use = function (self, card)
        if card.ability.mtg_energy or card.ability.extra.energy then
            return true
        end
    end,
    use = function (self, card, area, copier)
        local used_tarot = copier or card
       if area then
        area:remove_from_highlighted(card)
        end
        if G.hand.highlighted[1] then
            G.hand.highlighted[1].ability.mtg_energy = true
        end
        if G.jokers.highlighted[1] and card.ability.mtg_energy == true then
            G.jokers.highlighted[1].ability.mtg_energy = true
        end
    end,
}
--]]