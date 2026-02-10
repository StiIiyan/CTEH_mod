-- FADE EFFECTS #########################################

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
    },
    loc_vars = function(self, info_queue, card)
        local main_end
        if G.jokers and G.jokers.cards then
            for _, joker in ipairs(G.jokers.cards) do
                if joker.edition and joker.edition.negative then
                    main_end = {}
                    localize { type = 'other', key = 'remove_negative', nodes = main_end, vars = {} }
                    break
                end
            end
        end
        return { vars = { card.ability.total_rounds or 2, card.ability.invis_rounds or 0 }, main_end = main_end }
    end
})

-- OTHER EFFECTS #########################################

-- Make Misprint and Blue Printer indestinguishable (both will have the mod ID)
SMODS.Joker:take_ownership('misprint',
{
    key = "misprint",
})

-- Make Hack retrigger cards in hand too
SMODS.Joker:take_ownership('hack',
{
    key = "hack",
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.hand and (next(context.card_effects[1]) or #context.card_effects > 1) or
        context.repetition and context.cardarea == G.play then
            if context.other_card:get_id() == 2 or
            context.other_card:get_id() == 3 or
            context.other_card:get_id() == 4 or
            context.other_card:get_id() == 5 then
                return { repetitions = card.ability.extra }
            end
        end
    end
})

-- Marble Joker now gives Stone seal to the Stone cards
SMODS.Joker:take_ownership('marble',
{
    key = "marble",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        info_queue[#info_queue + 1] = {key = 'cteh_stone_seal', set = 'Other'}
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local stone_card = SMODS.create_card { set = "Base", enhancement = "m_stone", area = G.discard }
            stone_card:set_seal('CTEH_stone', nil, true)
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            stone_card.playing_card = G.playing_card
            table.insert(G.playing_cards, stone_card)

            G.E_MANAGER:add_event(Event({
                func = function()
                    stone_card:start_materialize({ G.C.SECONDARY_SET.Enhanced })
                    G.play:emplace(stone_card)
                    return true
                end
            }))
            return {
                message = localize('k_plus_stone'),
                colour = G.C.SECONDARY_SET.Enhanced,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
                            return true
                        end
                    }))
                    draw_card(G.play, G.deck, 90, 'up')
                    SMODS.calculate_context({ playing_card_added = true, cards = { stone_card } })
                end
            }
        end
    end
})


-- Stone Joker now gives chips for Stone sealed cards too
SMODS.Joker:take_ownership('stone',
{
    key = "stone",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        info_queue[#info_queue + 1] = {key = 'cteh_stone_seal', set = 'Other'}

        local stone_tally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_stone') or playing_card.seal == 'CTEH_stone' then stone_tally = stone_tally + 1 end
            end
        end
        return { vars = { card.ability.extra, card.ability.extra * stone_tally } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local stone_tally = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_stone') or playing_card.seal == 'CTEH_stone' then stone_tally = stone_tally + 1 end
            end
            return {
                chips = card.ability.extra * stone_tally
            }
        end
    end,
    in_pool = function(self, args) --equivalent to `enhancement_gate = 'm_stone'`
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_stone') or playing_card.seal == 'CTEH_stone' then
                return true
            end
        end
        return false
    end
})


-- Mail-in Rebate now reduces payout with each played hand
SMODS.Joker:take_ownership('mail',
{
    key = "mail",
    calculate = function(self, card, context)
        if context.discard and not context.other_card.debuff and
            context.other_card:get_id() == G.GAME.current_round.mail_card.id then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra
            return {
                dollars = card.ability.extra,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end

        if context.press_play then
            card.ability.extra = math.max(card.ability.extra - 1,1)
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra = 5
        end
    end
})

-- SMODS.Atlas{
--     key = "j_chads",
--     path = "chads.png",
--     px = 71,
--     py = 95
-- }

-- SMODS.Joker:take_ownership('hanging_chad',
-- {
--     key = "hanging_chad",
--     atlas = 'j_chads',
--     pos = {x = 0, y = 0},
--     config = { extra = { repetitions = 2 }, sprite_pos = 0 },
--     loc_vars = function(self, info_queue, card)
--         card.ability.sprite_pos = (card.ability.sprite_pos + 1) % 3
--         card.children.center:set_sprite_pos({x = card.ability.sprite_pos, y = 0})
--         return { vars = { card.ability.extra.repetitions } }
--     end,
-- })