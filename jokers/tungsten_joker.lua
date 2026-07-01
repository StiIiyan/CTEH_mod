SMODS.Atlas{
    key = "j_tungsten",
    path = "tungsten_joker.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'tungsten_joker',
    loc_txt = {
        name = 'Tungsten Joker',
        text = {
            'When opening a {C:attention}Booster Pack{}',
            '{C:green}#1# in #2#{} to {C:red}destroy{} the entire pack',
            'and create an {C:spectral}Immolate',
            '{C:inactive}(Must have room)'
        }
    },
    config = {
        lower_sensitivity = 0.6,
        odds = 8
    },
    loc_vars = function(self, info_queue, card)      
        local numerator, denominator =
            SMODS.get_probability_vars(card, 1, card.ability.odds, "tungsten_joker")
        return {vars = {numerator, denominator}}
    end,
    rarity = 2,
    cost = 4,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_tungsten',
    pos = {x = 0, y = 0},
    
    calculate = function(self, card, context)
        if next(SMODS.find_mod("WeeCursors")) then
            if card.states.drag.is then
                setSensitivity(card.ability.lower_sensitivity)
            else
                resetSensitivity()
            end
        end

        if context.open_booster then
            if not SMODS.pseudorandom_probability(card, "tungsten", 1, card.ability.odds) then return end
            
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Immo", colour = G.C.SECONDARY_SET.Spectral})
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                            local card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_immolate')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            G.GAME.consumeable_buffer = 0
                        return true
                    end)}))
            else
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "No space?", colour = G.C.SECONDARY_SET.Spectral})
            end

            G.E_MANAGER:add_event(Event({
                func = function()
                    G.FUNCS.end_consumeable()
                    return true
                end
            }))
            --DESTROY_PACKS = DESTROY_PACKS + 1
        end

        if context.ending_booster then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.FUNCS.draw_from_hand_to_deck();
                    -- refreshing the run after a successful hit retains the hand, tried to make things work with the Game update
                    return true
                end
            }))
        end
    end  
}

-- DESTROY_PACKS = 0

-- local prev_uap = Game.update_arcana_pack
-- function Game:update_arcana_pack(dt)
--     prev_uap(dt)
    
--     if G.STATE_COMPLETE and DESTROY_PACKS > 0 then
--         DESTROY_PACKS = DESTROY_PACKS - 1
--         G.STATE = G.STATES.SHOP
--         G.STATE_COMPLETE = false
--     end
-- end
-- local prev_usp = Game.update_spectral_pack
-- function Game:update_spectral_pack(dt)
--     prev_usp(dt)
    
--     if G.STATE_COMPLETE and DESTROY_PACKS > 0 then
--         DESTROY_PACKS = DESTROY_PACKS - 1
--         G.STATE = G.STATES.SHOP
--         G.STATE_COMPLETE = false
--     end
-- end