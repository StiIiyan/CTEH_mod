SMODS.Atlas{
    key = "d_white",
    path = "deck_white2.png",
    px = 71,
    py = 95
}
SMODS.Back {
    key = "white_deck",
    atlas = 'd_white',
    pos = { x = 0, y = 0 },
    config = { consumables = { 'c_judgement' } },
    loc_txt = {
        name = "White Deck",
        text = {
            'Start with a {C:tarot}Judgement{} and a',
            '{C:enhanced}perishable {C:attention}Invisible Joker{}'
        }
    },
    
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                local card = SMODS.create_card({
                    set = 'Joker',
                    area = G.jokers,
                    key = 'j_invisible',
                })
                card:set_perishable()
                G.jokers:emplace(card)
                return true
            end
        }))
    end
}