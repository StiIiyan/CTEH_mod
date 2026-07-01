SMODS.Atlas{
    key = "d_square",
    path = "decks.png",
    px = 71,
    py = 95
}

BACK_POS = {}
if next(SMODS.find_mod("SquareCards")) then 
    BACK_POS = { x = 1, y = 1 }
else 
    BACK_POS = { x = 3, y = 0 }
end

SMODS.Back {
    key = "square_deck",
    atlas = 'd_square',
    pos = BACK_POS,
    loc_txt = {
        name = "Square Deck",
        text = {
            'Start with an {C:attention}eternal{}',
            '{C:chips,T:j_square}Square Joker{}',
            '{C:chips}Square Joker{} may',
            'reapper in {C:attention}Shop'
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