SMODS.Atlas{
    key = "j_bean_juggler",
    path = "bean_jugg.png",
    px = 71,
    py = 95
}

SMODS.Gradient {
    key = "bean_juggler",
    colours = {
        HEX("fefefe"),
        HEX("6E8965"),
        HEX("FD5F55"),
    }
}

SMODS.Joker{
    key = 'bean_juggler',
    loc_txt = {
        name = '{C:cteh_bean_juggler}Bean Juggler',
        text = {
            'When {C:attention}Small{} or {C:attention}Big Blind{} is defeated',
            'by {C:chips}playing{} or {C:mult}discarding {C:attention}no more than 2 cards{}',
            'sell to create two {C:attention}Juggle Tags{}',
            '{C:inactive}(Currently {C:attention}#1#{C:inactive}/1)'
        }
    },
    rarity = 2,
    cost = 5,
    blueprint_compat=true,
    eternal_compat=false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_bean_juggler',
    pos = {x = 0, y = 0},
    
    config = {
        sellable = 0,
        condition = true
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.sellable}}
    end,
    calculate = function(self, card, context)
        if context.blind then
            card.ability.condition = true
        end

        if card.ability.sellable == 0 and (context.before or context.discard) and not context.blueprint and #context.full_hand > 2 and card.ability.condition then
            card.ability.condition = false
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Nope!", colour = G.C.FILTER})
        end

        if (G.GAME.blind:get_type() == 'Small' or G.GAME.blind:get_type() == 'Big') and context.end_of_round and 
        not context.repetition and not context.individual and not context.blueprint and card.ability.condition then
            card.ability.sellable = card.ability.sellable + 1
            local eval = function(card) return not card.REMOVED end
            juice_card_until(card, eval, true)
        end

        if context.selling_self and card.ability.sellable > 0 then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+2 Juggle Tags!", colour = G.C.FILTER})
                    add_tag(Tag('tag_juggle'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    add_tag(Tag('tag_juggle'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))
            return nil, true
        end
    end
}