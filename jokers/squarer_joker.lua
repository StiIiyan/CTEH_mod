SMODS.Atlas{
    key = "j_squimbo_unc",
    path = "squimbo_unc.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'squimbo_unc',
    loc_txt = {
        name = 'Squarer Joker',
        text = {
            'Sell to {C:attention}double{C:chips} chips',
            'of all {C:attention}Square Jokers{}'
        }
    },
    rarity = 2,
    cost = 6,
    blueprint_compat=true,
    eternal_compat=false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_squimbo_unc',
    pos = {x = 0, y = 0},
    pixel_size = { h = 71 },
    in_pool = function(self, args)
        return next(SMODS.find_card("j_square"))
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            for _, card in pairs(G.jokers.cards) do
                if card.ability.name == "Square Joker" then
                    card.ability.extra.chips = 2 * card.ability.extra.chips

                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Double", colour = G.C.FILTER})
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