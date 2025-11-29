SMODS.ObjectType({
    key = "Suit_Tarots",
    default = "c_world",
    cards = {
        c_world = true,
        c_sun = true,
        c_star = true,
        c_moon = true
    }
})


SMODS.Atlas{
    key = "d_prism",
    path = "deck_prism.png",
    px = 71,
    py = 95
}
SMODS.Back {
    key = "prism_deck",
    atlas = 'd_prism',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "Prism Deck",
        text = {
            "Suit tarots also apply",
            "a random {C:attention}Enhancement",
            "Begin with a",
            "random {C:attention}suit tarot"
        }
    },
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.0,
            func = (function()
                local card = create_card('Suit_Tarots',G.consumeables, nil, nil, nil, nil, nil, 'suit_tarots')
                G.consumeables:emplace(card)
                return true
            end)}))
    end
}