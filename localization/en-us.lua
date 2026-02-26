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
            j_marble = {
                name = "Marble Joker",
                text = {
                    "Adds one {C:attention}Stone{} card",
                    "with a {C:attention}Stone{} seal",
                    "when {C:attention}Blind{} is selected",
                },
            },
            j_stone = {
                name = "Stone Joker",
                text = {
                    "Gives {C:chips}+#1#{} Chips for each card",
                    "with {C:inactive}Stone{C:attention} Enhancement{}",
                    "or {C:attention}Seal{} in your {C:attention}full deck",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
                },
            },
            j_mail = {
                name = "Mail-In Rebate",
                text = {
                    "Earn {C:money}$#1#{} for each discarded {C:attention}#2#{}",
                    "{C:attention}Lower{} by {C:money}$1{} after playing hand",
                    "rank changes every round",
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
            j_CTEH_suited_seals_1 = {
                name = 'Suited Seals',
                text = {
                    '{C:attention}Suits{} behave like {C:attention}seals{}:',
                    '{C:spades}Spades{} are {C:enhanced}Purple{}, {C:diamonds}Diamonds{} are {C:gold}Gold',
                    '{C:hearts}Hearts{} are {C:red}Red{}, {C:clubs}Clubs{} are {C:blue}Blue',
                    '{C:inactive}Stones{} are {C:inactive}Stone',
                }
            },
            j_CTEH_suited_seals_2 = {
                name = 'Suited Seals',
                text = {
                    '{C:hearts}Roses{} are {C:red}Red{}, {C:clubs}Violets{} are {C:blue}Blue',
                    '',
                }
            },
        },
        Enhanced = {
            m_CTEH_sizaak_enh = {
                name = "Sizaak",
                text = {
                    "{C:attention}Always{} scores, {C:red}Break{} when scored",
                    "{C:red}Cannot{} change or remove enhancement",
                    "or be {C:attention}selected by force{}"
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
                    '{C:green}1 in 4{} to gain ',
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
            cteh_stone_seal = {
                name = 'Stone Seal',
                text = {
                    'Permanently gain {C:chips}+40{} chips',
                    'when {C:attention}changing Enhancement',
                    'Discard to turn into {C:attention}Stone'
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
                    'by any means',
                    '{s:0.7,C:inactive}Except maybe challenges'
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
            cteh_stone_seal = 'Stone Seal',
        },
        challenge_names = {
            c_CTEH_turtle = "Magic Bean",
            c_CTEH_sizaak_bus = "Sizaak's Bus",
        },
        v_text={
            ch_c_empty_deck_lose_condition={
                "If you draw your entire deck, you lose",
            },
            ch_c_all_magic_beaned={
                "All Jokers have a {C:attention}Magic Beaned{} sticker",
            },
            ch_c_bus_debuff_license={
                "Crashing {C:attention}The Bus{} revokes {C:inactive}(debuffs){} your {C:attention}License",
            },
            ch_c_bus16={
                "Renew {C:inactive}(de-debuff){} your {C:attention}License{} by reaching {C:mult}+16{} on {C:attention}The Bus{}",
            },
            ch_c_sizaak_bus_wincon={
                "Have your {C:attention}License{} revoked by playing {C:attention}Sizaak{} to win the game",
            },
            ch_c_sizaak_bus_losecon={
                "Playing {C:attention}Sizaak{} too early {C:red}loses{} the game",
            },
            ch_c_all_cbell={
                "All {C:attention}Bosses{} have {C:chips}Cerulean Bell{} effect",
            },
        }
    }
}