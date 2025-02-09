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
cost = 3,
 config = { extra = { energy = 0 } },
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.extra.energy}}
    end,
    can_use = function (self, card)
        return card.ability.extra.energy >= 0
    end,
    use = function (self, card, area, copier)
        local used_tarot = copier or card
        card.ability.extra.energy = card.ability.extra.energy + 1
    end,
}
--]]