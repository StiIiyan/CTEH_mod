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
            'Adds {C:green}#1#{} odds to all probabilities',
            'Increase odds upon exiting shop',
            '{C:green}#2# in {C:attention}#4#{} to increase odds during timer',
            '{C:green}#2# in #3#{} to break joker at the end of round'
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
        return {vars = {card.ability.additional_probability,numerator, denominator,MP.GAME.timer}}
    end,
    remove_from_deck = function(self, card, from_debuff)
        if playing_multiplayer() then
            multi_player:increase_additive_value(-card.ability.additional_probability)
        else
            single_player:increase_additive_value(-card.ability.additional_probability)
        end
        G.E_MANAGER:add_event(Event({
            blockable = false,
            func = (function()
                    play_sound('glass'..math.random(1, 6), math.random()*0.2 + 0.9,0.5)
                    play_sound('generic1', math.random()*0.2 + 0.9,0.5)
                return true end)
        }))
    end,
    calculate = function(self, card, context)
        if context.ending_shop then
            if playing_multiplayer() then
                --TODO?
                multi_player:increase_additive_value(1)
                card.ability.additional_probability = card.ability.additional_probability + 1
            else
                single_player:increase_additive_value(1)
                card.ability.additional_probability = card.ability.additional_probability + 1
            end
        end

        if context.end_of_round and context.main_eval and context.game_over == false then
            if not SMODS.pseudorandom_probability(card, "lucky_mirror", 1, card.ability.odds) then return end


        end
    end
}