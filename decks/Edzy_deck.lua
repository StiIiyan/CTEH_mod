SMODS.Atlas{
    key = "d_edzy",
    path = "decks.png",
    px = 71,
    py = 95
}
SMODS.Back {
    key = "edzy_deck",
    atlas = 'd_edzy',
    pos = { x = 4, y = 0 },
    loc_txt = {
        name = "Edzy's Wrath",
        text = {
            'Start with {C:attention}Edzy\'s Special{}'
        }
    },
    
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                local card = SMODS.create_card({
                    set = 'Joker',
                    area = G.jokers,
                    key = 'j_CTEH_edzy',
                })
                card:set_edition(nil) -- removes RNG editions
                G.jokers:emplace(card)
                return true
            end
        }))
    end
}