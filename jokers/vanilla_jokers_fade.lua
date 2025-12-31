SMODS.Joker:take_ownership('caino',
{
    key = "caino",
    loc_txt = {
        name = Fade_Gradient({HEX("E1ECF2"),HEX("ADC2D3")},'canio','Canio',2,false),
        text = {
            "This Joker gains {X:mult,C:white} X#1# {} Mult",
            "when a {C:attention}face{} card",
            "is destroyed",
            "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
        },
        unlock = {
            "{E:1,s:1.3}?????",
        },
    }
})
SMODS.Joker:take_ownership('triboulet',
{
    key = "triboulet",
    loc_txt = {
        name = Fade_Gradient({HEX("009CFD"),HEX("ADC2D3"),HEX('FDA200')},'triboulet','Triboulet',4,false),
        text = {
            "Played {C:attention}Kings{} and",
            "{C:attention}Queens{} each give",
            "{X:mult,C:white} X#1# {} Mult when scored",
        },
        unlock = {
            "{E:1,s:1.3}?????",
        },
    }
})
SMODS.Joker:take_ownership('yorick',
{
    key = "yorick",
    loc_txt = {
        name = Fade_Gradient({HEX("F2D092"),HEX("FDA200"),HEX("4F6367")},'yorick','Yorick',3,false),
        text = {
            "This Joker gains",
            "{X:mult,C:white} X#1# {} Mult every {C:attention}#2#{C:inactive} [#3#]{}",
            "cards discarded",
            "{C:inactive}(Currently {X:mult,C:white} X#4# {C:inactive} Mult)",
        },
        unlock = {
            "{E:1,s:1.3}?????",
        },
    }
})
SMODS.Joker:take_ownership('chicot',
{
    key = "chicot",
    loc_txt = {
        name = Fade_Gradient({HEX("EE8F8D"),HEX("FD5F55")},'chicot','Chicot',2,false),
        text = {
            "Disables effect of",
            "every {C:attention}Boss Blind",
        },
        unlock = {
            "{E:1,s:1.3}?????",
        },
    }
})
SMODS.Joker:take_ownership('perkeo',
{
    key = "perkeo",
    loc_txt = {
        name = Fade_Gradient({HEX("88BEB0"),HEX("56A786"),HEX("FD5F55")},'perkeo','Perkeo',3,false),
        text = {
            "Creates a {C:dark_edition}Negative{} copy of",
            "{C:attention}1{} random {C:attention}consumable{}",
            "card in your possession",
            "at the end of the {C:attention}shop",
        },
        unlock = {
            "{E:1,s:1.3}?????",
        },
    }
})
SMODS.Joker:take_ownership('blueprint',
{
    key = "blueprint",
    loc_txt = {
        name = Fade_Gradient({HEX("ABBDF8"),HEX("6484F7"),HEX("3E60D4")},'blueprint','Blueprint',3,false),
        text = {
            "Copies ability of",
            "{C:attention}Joker{} to the right",
        },
        unlock = {
            "Win a run",
        },
    }
})
SMODS.Joker:take_ownership('brainstorm',
{
    key = "brainstorm",
    loc_txt = {
        name = Fade_Gradient({HEX("F9EDD3"),HEX("C09D75")},'brainstorm','Brainstorm',3,false),
        text = {
            "Copies the ability",
            "of leftmost {C:attention}Joker",
        },
        unlock = {
            "Discard a",
            "{E:1,C:attention}Royal Flush",
        },
    }
})
SMODS.Joker:take_ownership('cavendish',
{
    key = "cavendish",
    loc_txt = {
        name = Fade_Gradient({HEX("F9DB41"),HEX("F9DB41"),HEX("9EB65F"),HEX("64825C")},'cavendish','Cavendish',3,false),
        text = {
            "{X:mult,C:white} X#1# {} Mult",
            "{C:green}#2# in #3#{} chance this",
            "card is destroyed",
            "at end of round",
        },
    }
})
SMODS.Joker:take_ownership('invisible',
{
    key = "invisible",
    loc_txt = {
        name = Fade_Gradient({HEX("75A3AE40"),HEX("FEFEFE60"),HEX("AFE8F740")},'invisible','Invisible Joker',3,false),
        text = {
            "After {C:attention}#1#{} rounds,",
            "sell this card to",
            "{C:attention}Duplicate{} a random Joker",
            "{C:inactive}(Currently {C:attention}#2#{C:inactive}/#1#)",
        },
        unlock = {
            "Win a run without",
            "ever having more",
            "than {E:1,C:attention}4 Jokers{}",
        },
    }
})