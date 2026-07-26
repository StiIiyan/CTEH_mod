MISPRINT_LAST_TRIGGER = 0

SMODS.Atlas{
    key = "j_blue_printer",
    path = "blue_printer.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'blue_printer',
    loc_txt = {
        name = '#1#',
        text = {
            ""
        },
    },
    rarity = 1,
    cost = 4,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_blue_printer',
    pos = {x = 1, y = 0},
    config = {
        numerator_value = 0,
        odds = 1000
    },
    loc_vars = function(self, info_queue, card)
        local in_game = G.jokers
        local in_joker_slots = false
        if in_game then
            for i=1,#G.jokers.cards do
                in_joker_slots = in_joker_slots or G.jokers.cards[i] == card
            end
        end

        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.numerator_value, card.ability.odds)
                      
        if not in_game then
            card.children.center:set_sprite_pos({x = 0, y = 0})
            return { vars = {numerator, denominator}, key = 'j_CTEH_blueprinter_1' }
        else
            if not in_joker_slots then
                card.children.center:set_sprite_pos({x = 1, y = 0})

                local r_mults = {}
                for i = 0, 23 do
                    r_mults[#r_mults+1] = tostring(i)
                end
                local loc_mult = ' '..(localize('k_mult'))..' '
                main_start = {
                    {n=G.UIT.T, config={text = '  +',colour = G.C.MULT, scale = 0.32}},
                    {n=G.UIT.O, config={object = DynaText({string = r_mults, colours = {G.C.RED},pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.5, scale = 0.32, min_cycle_time = 0})}},
                    {n=G.UIT.O, config={object = DynaText({string = {
                        {string = 'rand()', colour = G.C.JOKER_GREY},{string = "#@"..(G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.id or 11)..(G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.suit:sub(1,1) or 'D'), colour = G.C.RED},
                        loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult},
                    colours = {G.C.UI.TEXT_DARK},pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.2011, scale = 0.32, min_cycle_time = 0})}},
                }

                return { main_start = main_start, key = 'j_misprint' }
            else
                card.children.center:set_sprite_pos({x = 0, y = 0})
                return { vars = {numerator, denominator}, key = 'j_CTEH_blueprinter_2' }
            end
        end
    end,
    
    calculate = function(self, card, context)
        if context.blind then
            if SMODS.pseudorandom_probability(card, "blue_printer", card.ability.numerator_value, card.ability.odds) then
                play_sound('polychrome1', 1.2, 0.7)
                card:set_ability("j_blueprint")
            else
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Miss", colour = G.C.SECONDARY_SET.Joker})
                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = (function()
                            local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_misprint')
                            card:add_to_deck()
                            G.jokers:emplace(card)
                            G.GAME.joker_buffer = 0
                            return true
                        end)}))
                    end
            end            
        end

        if context.end_of_round and context.main_eval and context.game_over == false then
            card.ability.numerator_value = MISPRINT_LAST_TRIGGER
        end
    end
}