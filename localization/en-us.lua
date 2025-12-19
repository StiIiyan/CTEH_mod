return {
    descriptions = {
        Joker = {
            j_square={
                name="Square Joker",
                text={
                    "This Joker gains {C:chips}+#2#{} Chips",
                    "if played hand has",
                    "exactly {C:attention}4{} cards",
                    "{C:inactive}(Currently {C:chips}#1#{C:inactive} Chips)",
                    "{C:inactive}(Multiple Square Jokers stack",
                    "{C:inactive}scaled chips and scaling)",
                }
            },
            j_egg = {
                name="Egg",
                text={
                    "{C:dark_edition,s:0.5,E:2}Egg Egg Egg Egg Egg{}",
                    "{C:dark_edition,s:1.7,E:2}Egg{}",
                    "{C:dark_edition,s:0.5,E:2}Egg Egg Egg Egg Egg{}"
                }
            },
            j_to_the_moon = {
                name="To the Moon",
                text={
                    "Earn an extra {C:money}$#1#{} of",
                    "{C:attention}interest{} for every {C:money}$#2#{} you",
                    "have at end of round"
                }
            }
        },
        Voucher = {
            v_seed_money = {
                name="Seed Money",
                text={
                    "{C:attention}Double{} the cap on",
                    "interest earned"
                }
            },
            v_money_tree = {
                name="Money Tree",
                text={
                    "{C:attention}Quadruple{} the cap on",
                    "interest earned"
                },
                unlock={
                    "Max out the interest",
                    "per round earnings for",
                    "{C:attention}#1#{} consecutive rounds",
                    "{C:inactive}(#2#)"
                }
            },
            v_planet_tycoon = {
                name="Planet Tycoon",
                text={
                    "Leveling up a hand now gives",
                    "{C:attention}twice{} as many levels"
                }
                -- not sure if I need to reiterate the unlock text
            }
        }
    }
}