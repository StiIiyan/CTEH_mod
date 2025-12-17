SMODS.Atlas{
    key = "j_squimbo_rare",
    path = "squimbo_rare.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'squimbo_rare',
    loc_txt = {
        name = 'Squarest Joker',
        text = {
            'Sell to {C:attention,S:1.4}SQUARE{C:chips} chips',
            'of all {C:attention}Square Jokers{}'
        }
    },
    rarity = 3,
    cost = 8,
    blueprint_compat=true,
    eternal_compat=false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_squimbo_rare',
    pos = {x = 0, y = 0},
    pixel_size = { h = 71 },
    in_pool = function(self, args)
        return next(SMODS.find_card("j_CTEH_squimbo_unc"))
    end,
    calculate = function(self, card, context)
        if context.selling_self then -- unlike remove_from_deck, this allows the blueprint compatibility
            for _, card in pairs(G.jokers.cards) do
                if card.ability.name == "Square Joker" then
                    card.ability.extra.chips = card.ability.extra.chips * card.ability.extra.chips

                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "SQUARE", colour = G.C.FILTER})
                            play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                            play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                            return true
                        end)
                    }))
                end
            end
        end
    end 
}