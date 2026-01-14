SMODS.Atlas{
    key = "j_rerolling_stones",
    path = "rerolling_stones.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'rerolling_stones',
    loc_txt = {
        name = 'Rerolling Stones',
        text = {
            '{C:green}#1# in #2#{} to create a {C:attention}Tower{}',
            'when rerolling'
        }
    },
    config = {
        sprite_pos = 0,
        odds = 3
    },
    loc_vars = function(self, info_queue, card)      
        local numerator, denominator =
            SMODS.get_probability_vars(card, 1, card.ability.odds)
        return {vars = {numerator, denominator}}
    end,
    rarity = 2,
    cost = 3,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_rerolling_stones',
    pos = {x = 0, y = 0},
    
    calculate = function(self, card, context)

        if context.reroll_shop then            
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Roll", colour = G.C.SECONDARY_SET.Tarot})
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = (function()
                            local card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_tower')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            G.GAME.consumeable_buffer = 0
                        return true
                    end)}))
            end

            card.ability.sprite_pos = (card.ability.sprite_pos + 1) % 4
            card.children.center:set_sprite_pos({x = card.ability.sprite_pos, y = 0})
        end
    end  
}