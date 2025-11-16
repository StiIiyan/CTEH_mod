SMODS.Atlas{
    key = "j_natural_born_joker",
    path = "nbj.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'natural_born_joker',
    loc_txt = {
        name = 'Natural Born Joker',
        text = {
            'Gain an {C:attention}Uncommon Tag{} and an',
            '{C:dark_edition}Edition Tag{} for each remaining {C:attention}discard{}',
            'by beating a blind in a {C:attention}single hand{}'
        }
    },
    rarity = 2,
    cost = 6,
    blueprint_compat=true,
    eternal_compat=true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_natural_born_joker',
    pos = {x = 0, y = 0},
    
    calculate = function(self, card, context)
        if G.GAME.current_round.hands_played == 1 and context.end_of_round and not context.repetition and not context.individual then
            for i=1,G.GAME.current_round.discards_left do
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+1 Uncommon Tag!", colour = G.C.FILTER})
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        add_tag(Tag('tag_uncommon'))
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                    end)
                }))
                delay(0.3)
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+1 Edition Tag!", colour = G.C.FILTER})
                local edition = math.random(1,20)
                if edition <= 10 then 
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            add_tag(Tag('tag_foil'))
                            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                            play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                            return true
                        end)
                    }))
                elseif edition <= 17 then 
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            add_tag(Tag('tag_holo'))
                            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                            play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                            return true
                        end)
                    }))
                else
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            add_tag(Tag('tag_polychrome'))
                            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                            play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                            return true
                        end)
                    }))
                end
            end
        end
    end
}