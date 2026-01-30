SMODS.Atlas{
    key = 'consumables', 
    path = 'consumables.png', 
    px = 71, 
    py = 95
}

SMODS.Consumable {
    key = 'rockada',
    set = 'Spectral',
    pos = { x = 0, y = 0 },
    atlas = 'consumables',
    config = { max_highlighted = 1, extra = { seal = 'CTEH_stone' } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'cteh_stone_seal', set = 'Other'}
        return { vars = { card.ability.max_highlighted } }
    end,
    loc_txt = {
        name = 'Rockada',
        text = {
            'Add a {C:inactive}Stone Seal',
            'to {C:attention}1{} selected',
            'card in your hand'
        }
    },
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conv_card:set_seal(card.ability.extra.seal, nil, true)
                return true
            end
        }))

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end
}