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
                    "{C:cteh_interest}interest{} for every {C:money}$#2#{} you",
                    "have at end of round"
                }
            },
            j_oops = {
                name = "Oops! All 6s",
                text = {
                    "Doubles the {C:green,E:1,S:1.1}probability {C:attention}base",
                    "{C:inactive}(ex: {C:green}1 in 3{C:inactive} -> {C:green}2 in 3{C:inactive})",
                },
                unlock = {
                    "In one hand,",
                    "earn at least",
                    "{E:1,C:attention}#1#{} chips",
                }
            },
            j_hack = {
                name = "Hack",
                text = {
                    "Retrigger each played",
                    "and held in hand",
                    "{C:attention}2{}, {C:attention}3{}, {C:attention}4{}, or {C:attention}5{}",
                },
            },
            j_CTEH_blueprinter_1 = {
                name = "Blue Printer",
                text = {
                    "Create a {C:attention}Misprint{} when {C:attention}Blind{} is selected",
                    "{C:green}#1# in #2#{} to instead turn into a {C:attention}Blueprint",
                    "Set {C:green}odds{} to previous round's last Misprint trigger",
                    "{C:warning_text}Joker will appear as Misprint in Shop",
                },
            },
            j_CTEH_blueprinter_2 = {
                name = "Blue Printer",
                text = {
                    "Create a {C:attention}Misprint{} when {C:attention}Blind{} is selected",
                    "{C:green}#1# in #2#{} to instead turn into a {C:attention}Blueprint",
                    "Set {C:green}odds{} to previous round's last Misprint trigger"
                },
            },
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
            },
            v_magic_trick = {
                name = "Magic Trick",
                text = {
                    "{C:enhanced}Enhanced {C:attention}playing cards{} can",
                    "be purchased from the {C:attention}shop",
                    "They may also appear",
                    "with a {C:gold}Shopping{} sticker"
                },
            }
        },
        Other = {
            CTEH_egg = {
                name = 'Yolky',
                text = {
                    'Gain {C:gold}$2{} of sell value',
                    'at end of round'
                }
            },
            CTEH_bean = {
                name = 'Beaned',
                text = {
                    'Gain {C:attention}1{} hand size'
                }
            },
            CTEH_magic_bean = {
                name = 'Magic Beaned',
                text = {
                    '{C:attention}+#1#{} hand size',
                    '{C:attention}+1{} hand size at end of round{}'
                }
            },
            CTEH_paycheck = {
                name = 'Paycheck',
                text = {
                    '{C:green}#1# in #2#{} to gain ',
                    '{C:cteh_interest}interest{} when consumed'
                }
            },
            CTEH_static_paycheck = {
                name = 'Paycheck',
                text = {
                    '{C:green}1 in 6{} to gain ',
                    '{C:cteh_interest}interest{} when consumed'
                }
            },
            CTEH_shopping = {
                name = 'Shopping',
                text = {
                    'Gain {C:gold}$1{} when',
                    'found in Shop',
                }
            },
            dwarven_planets = {
                name = 'Dwarven Planets',
                text = {
                    '{C:planet}Pluto{}, {C:planet}Ceres{} and {C:planet}Eris{}'
                }
            },
            CTEH_unobtainable = {
                name = 'Unobtainable',
                text = {
                    '{C:red}Cannot{} be obtained',
                    'by any means'
                }
            },
            CTEH_uncopyable = {
                name = 'Uncopyable',
                text = {
                    '{C:red}Cannot{} be copied',
                    'by Ankh or Invis Joker'
                }
            }
        }
    },
    misc = {
        labels = {
            CTEH_egg = 'Yolky',
            CTEH_bean = 'Beaned',
            CTEH_magic_bean = 'Magic Beaned',
            CTEH_paycheck = 'Paycheck',
            CTEH_shopping = 'Shopping',
        },
        challenge_names = {
            c_CTEH_turtle = "Magic Bean"
        },
        v_text={
            ch_c_empty_deck_lose_condition={
                "If you draw your entire deck, you lose",
            },
            ch_c_all_magic_beaned={
                "All Jokers have a {C:attention}Magic Beaned{} sticker",
            },
        }
    }
}