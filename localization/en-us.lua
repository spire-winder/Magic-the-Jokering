return {
    descriptions = {
        Joker = {
            j_mtg_urborg = {
                name = "Urborg, Tomb of Yawgmoth",
                text = {
                    "Each played card is a {C:spade}Spade{}",
                    "in addition to its other suits"
                },
            },
            j_mtg_celestialdawn = {
                name = "Celestial Dawn",
                text = {
                    "Each played card is a {C:diamond}Diamond{}",
                    "in addition to its other suits"
                },
            },
            j_mtg_harbinger = {
                name = "Harbinger of the Seas",
                text = {
                    "Each played card is a {C:club}Club{}",
                    "in addition to its other suits"
                },
            },
            j_mtg_bloodmoon = {
                name = "Blood Moon",
                text = {
                    "Each played card is a {C:heart}Heart{}",
                    "in addition to its other suits"
                },
            },
            j_mtg_torbran = {
                name = "Torbran, Thane of Red Fell",
                text = {
                    "If a hand contains a {C:red}Red{} card,",
                    "deal {C:attention}#1#{} {C:red}damage{} to the blind",
                    "If another source would deal {C:red}damage{},",
                    "it deals that much {C:red}damage{} plus {C:attention}#2#{} instead"
                },
            },
            j_mtg_urzamine = {
                name = "Urza's Mine",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "If you have {C:attention}Urza's Power Plant{}","and {C:attention}Urza's Tower{} {C:chips}+#2#{} more Chips"
                },
            },
            j_mtg_urzapower = {
                name = "Urza's Power Plant",
                text = {
                    "{C:mult}+#1#{} Mult",
                    "If you have {C:attention}Urza's Mine{}","and {C:attention}Urza's Tower{} {C:mult}+#2#{} more Mult"
                },
            },
            j_mtg_urzatower = {
                name = "Urza's Tower",
                text = {
                    "{X:mult,C:white} X#1# {} Mult",
                    "If you have {C:attention}Urza's Mine{}","and {C:attention}Urza's Power Plant{} {X:mult,C:white} X#2# {} more Mult"
                },
            },
            j_mtg_lantern = {
                name = "Lantern of Insight",
                text = {
                    "Adds {C:attention}double{} the rank of",
                    "of the top card of your deck",
                    "{C:inactive}(Currently adding {C:mult}+#2#{} {C:inactive}Mult){}",
                    "{C:inactive}(Top card is {C:attention}#3#{C:inactive}){}"
                },
            },
        },
        Spectral = {
            c_mtg_blacklotus = {
                name = "Black Lotus",
                text = {
                    "Add {C:attention}#1#{}","{C:dark_edition}Negative{} {C:attention}Jokers{}"
                },
            },
        },
        Magic = {
            c_mtg_onewithnothing = {
                name = "One with Nothing",
                text = {
                    "Discard your hand"
                },
            },
            c_mtg_chatterstorm = {
                name = "Chatterstorm",
                text = {
                    "Add a permanent {C:attention}Ace{}",
                    "to your hand",
                    "{C:dark_edition}Storm{}",
                    "{C:inactive,s:0.8}Current storm count: {C:attention}#1#{}"
                },
            },
            c_mtg_reaping = {
                name = "Reaping the Graves",
                text = {
                    "Return the top card of",
                    "your discard to your hand",
                    "{C:dark_edition}Storm{}",
                    "{C:inactive,s:0.8}Current storm count: {C:attention}#1#{}"
                },
            },
            c_mtg_mindsdesire = {
                name = "Mind's Desire",
                text = {
                    "Create {C:attention}#1#{} random {C:dark_edition}Negative{} Magic card",
                    "{C:dark_edition}Storm{}",
                    "{C:inactive,s:0.8}Current storm count: {C:attention}#2#{}"
                },
            },
            c_mtg_brainfreeze = {
                name = "Brainfreeze",
                text = {
                    "Draw {C:attention}#1#{} cards and discard them",
                    "{C:dark_edition}Storm{}",
                    "{C:inactive,s:0.8}Current storm count: {C:attention}#2#{}"
                },
            },
            c_mtg_negate = {
                name = "Negate",
                text = {
                    "Counter target {C:attention}Boss Blind{}"
                },
            },
            c_mtg_villagerites = {
                name = "Village Rites",
                text = {
                    "Destroy target card",
                    "Draw {C:attention}#1#{} cards"
                },
            },
            c_mtg_transmogrify = {
                name = "Transmogrify",
                text = {
                    "Destroy target card",
                    "Create a permanent copy of the",
                    "top card of deck in your hand"
                },
            },
            c_mtg_giantgrowth = {
                name = "Giant Growth",
                text = {
                    "Target card gets",
                    "{C:attention}+#1#{} rank",
                },
            },
            c_mtg_astralsteel = {
                name = "Astral Steel",
                text = {
                    "Target card gets",
                    "{C:attention}+#1#{} rank",
                    "{C:dark_edition}Storm{}",
                    "{C:inactive,s:0.8}Current storm count: {C:attention}#2#{}"
                },
            },
            c_mtg_ancestral = {
                name = "Ancestral Recall",
                text = {
                    "Draw",
                  "{C:attention}#1#{} cards"
                },
            },
            c_mtg_wrathofgod = {
                name = "Wrath of God",
                text = {
                    "{C:attention}Destroy{} all cards","in your hand"
                },
            },
            c_mtg_obliterate = {
                name = "Obliterate",
                text = {
                    "{C:attention}Destroy{} all cards in your hand",
                    "{C:attention}Destroy{} all jokers",
                    "{C:attention}Destroy{} all consumables",
                    "{C:attention}Destroy{} the blind"
                },
            },
            c_mtg_boostertutor = {
                name = "Booster Tutor",
                text = {
                    "Open a sealed",
                    "{C:dark_edition}Magic booster pack{}"
                },
            },
            c_mtg_lavaaxe = {
                name = "Lava Axe",
                text = {
                    "Deal {C:attention}#1#{} {C:red}damage{}",
                    "to target blind"
                },
            },
            c_mtg_flameslash = {
                name = "Flame Slash",
                text = {
                    "Deal {C:attention}#1#{} {C:red}damage{}",
                    "to target card"
                },
            },
            c_mtg_lightningbolt = {
                name = "Lightning Bolt",
                text = {
                    "Deal {C:attention}#1#{} {C:red}damage{}",
                    "to target blind or card"
                },
            },
            c_mtg_grapeshot = {
                name = "Grapeshot",
                text = {
                    "Deal {C:attention}#1#{} {C:red}damage{} to",
                    "target blind or card",
                    "{C:dark_edition}Storm{}",
                    "{C:inactive,s:0.8}Current storm count: {C:attention}#2#{}"
                },
            },
        },
        Tag = {
            tag_mtg_magictag = {
                name = "Magic Tag",
                text = {
                    "Gives a free",
                    "{C:dark_edition}Magic Pack",
                },
            },
            tag_mtg_bigmagictag = {
                name = "Big Magic Tag",
                text = {
                    "Gives a free",
                    "{C:dark_edition}Big Magic Pack",
                },
            },
        },
        Other = {
            r_mtg_any_target = {
                name = "Targeting the Blind",
                text = {
                    "To target the blind",
                    "use the consumable with",
                    "nothing else selected"
                }
            },
            r_mtg_damage_blind = {
                name = "Damage to Blind",
                text = {
                    "For each {C:red}damage{} add",
                    "{C:attention}5%{} of required chips"
                }
            },
            r_mtg_damage_card = {
                name = "Damage to Card",
                text = {
                    "For each {C:red}damage{} reduce",
                    "rank by {C:attention}1{}",
                    "If rank drops below {C:attention}2{}",
                    "destroy it"
                }
            },
            r_mtg_storm_count = {
                name = "Storm",
                text = {
                    "{C:attention}Copy{} this effect for each",
                    "consumable used earlier",
                    "this shop or blind"
                }
            },
            p_mtg_magic_pack = {
                name = "Magic Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:Magic} Magic{} cards"
                }
            },
            p_mtg_magic_pack_1 = {
                name = "Fallen Empires",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:Magic} Magic{} cards"
                }
            },
            p_mtg_magic_pack_2 = {
                name = "Arabian Nights",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:Magic} Magic{} cards"
                }
            },
            p_mtg_magic_pack_3 = {
                name = "Mystery Booster 2",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:Magic} Magic{} cards"
                }
            },
            p_mtg_magic_pack_4 = {
                name = "Portal Three Kingdoms",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:Magic} Magic{} cards"
                }
            },
            mtg_greedy_seal = {
                name = "Greedy Seal",
                text = {
                    "Draw {C:attention}#1#{} cards when","this card is played and scored or discarded",
                },
            },
        }
    },
    misc = {
        dictionary = {
            k_mtg_magic_pack = "Magic Pack",

            mtg_spades_ex = "Spades!",
            mtg_grunch_ex = "Grunch!",
            b_take = "TAKE",
        },
        labels = {
            mtg_greedy_seal = "Greedy Seal",
        },
        v_dictionary = {
            a_xchips = {"X#1# Chips"},
            a_powmult = {"^#1# Mult"},
            a_powchips = {"^#1# Chips"},
            a_powmultchips = {"^#1# Mult+Chips"},
            a_round = {"+#1# Round"},
            a_candy = {"+#1# Candy"},
            a_xchips_minus = {"-X#1# Chips"},
            a_powmult_minus = {"-^#1# Mult"},
            a_powchips_minus = {"-^#1# Chips"},
            a_powmultchips_minus = {"-^#1# Mult+Chips"},
            a_round_minus = {"-#1# Round"},

            a_tag = {"#1# Tag"},
            a_tags = {"#1# Tags"},
        }
    }
}
