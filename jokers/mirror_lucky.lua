SMODS.Atlas{
    key = "j_lucky_mirror",
    path = "lucky_mirror.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'lucky_mirror',
    loc_txt = {
        name = 'Lucky mirror',
        text = {
            'Adds {C:green}#1# {C:attention}odds{} to probabilities',
            'Increase {C:attention}odds{} upon exiting shop',
            '{C:green}#2# in {C:attention}#4#{} to increase {C:attention}odds{} during {C:attention}timer',
            '{C:green}#2# in #3#{} to {S:1.1,C:red,E:2}break{} at end of round'
        }
    },
    rarity = 2,
    cost = 6,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_lucky_mirror',
    pos = {x = 0, y = 0},
    
    config = {
        additional_probability = 0,
        odds = 7
    },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator =
            SMODS.get_probability_vars(card, 1, card.ability.odds, "lucky_mirror")
        return {vars = {card.ability.additional_probability,numerator, denominator,(MP and MP.GAME and MP.GAME.timer or 150)}}
    end,
    remove_from_deck = function(self, card, from_debuff)
        if playing_multiplayer() then
            multi_player:increase_additive_value(-card.ability.additional_probability)
        else
            single_player:increase_additive_value(-card.ability.additional_probability)
        end
    end,
    calculate = function(self, card, context)
        if context.ending_shop then
            if playing_multiplayer() then
                --TODO link multi_player to actual parameter when I finish with the probability expansion
                multi_player:increase_additive_value(1)
                card.ability.additional_probability = card.ability.additional_probability + 1
            else
                single_player:increase_additive_value(1)
                card.ability.additional_probability = card.ability.additional_probability + 1
            end
        end

        if context.end_of_round and context.main_eval and context.game_over == false then
            if SMODS.pseudorandom_probability(card, "lucky_mirror", 1, card.ability.odds) then
                if playing_multiplayer() then
                    card:set_ability("j_CTEH_broken_mirror")
                else
                    SMODS.destroy_cards(card, nil, nil, true)
                end
                G.E_MANAGER:add_event(Event({
                    blockable = false,
                    func = (function()
                            play_sound('glass'..math.random(1, 6), math.random()*0.2 + 0.9,0.5)
                            play_sound('generic1', math.random()*0.2 + 0.9,0.5)
                        return true end)
                }))
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Break!", colour = G.C.FILTER})
            else
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Intact!", colour = G.C.FILTER})
            end
        end
    end
}