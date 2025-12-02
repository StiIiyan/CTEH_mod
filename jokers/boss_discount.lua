SMODS.Atlas{
    key = "j_boss_discount",
    path = "boss_discount.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'boss_discount',
    loc_txt = {
        name = 'Boss\' discount',
        text = {
            'When {C:attention}Big Blind{} is defeated',
            '{C:green}(#1# + {C:white,X:green}#3#{C:green}) in #2#{} to create',
            'a {C:attention}D6 Tag{} and a {C:attention}Coupon Tag{}',
            '{C:inactive}(Increase by {C:white,X:green}1{C:inactive} for every{}',
            '{C:red,E:1}life {C:inactive}less than your {X:purple,C:white}Nemesis{C:inactive})'
        }
    },
	loc_vars = function(self, info_queue, card)
		if loaded_BMP() then 
            MP.UTILS.add_nemesis_info(info_queue) 
        end
		return { vars = {} }
	end,
    rarity = 1,
    cost = 4,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_boss_discount',
    pos = {x = 0, y = 0},
    
    config = {
        odds = 8
    },
    loc_vars = function(self, info_queue, card)      
        local numerator, denominator =
            SMODS.get_probability_vars(card, 1, card.ability.odds, "boss_discount")
        local life_numerator, denominator =
            SMODS.get_probability_vars(card, life_difference_nonnegative(), card.ability.odds, "boss_discount")
        return {vars = {numerator, denominator, life_numerator}}
    end,
    calculate = function(self, card, context)
        if G.GAME.blind:get_type() == 'Big' and context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            local base_numerator = 1 + life_difference_nonnegative()
            if not SMODS.pseudorandom_probability(card, "boss_discount", base_numerator, card.ability.odds) then return end

            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+1 D6 Tag!", colour = G.C.FILTER})
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_d_six'))
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end)
            }))
            delay(0.3)
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+1 Coupon Tag!", colour = G.C.FILTER})
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_coupon'))
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end)
            }))
        end
    end
}
