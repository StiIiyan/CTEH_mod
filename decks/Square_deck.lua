SMODS.Atlas{
    key = "d_square",
    path = "decks.png",
    px = 71,
    py = 95
}
SMODS.Back {
    key = "square_deck",
    atlas = 'd_square',
    pos = { x = 3, y = 0 },
    loc_txt = {
        name = "Square Deck",
        text = {
            'Start with an {C:attention}eternal{}',
            '{C:chips,T:j_square}Square Joker{}'
        }
    },
    
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                local card = SMODS.create_card({
                    set = 'Joker',
                    area = G.jokers,
                    key = 'j_square',
                })
                card:set_eternal(true)
                card:set_edition(nil) -- removes RNG editions
                G.jokers:emplace(card)
                return true
            end
        }))
    end
}