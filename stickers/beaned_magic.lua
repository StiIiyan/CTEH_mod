SMODS.Atlas{
    key = 'stickers', 
    path = 'stickers.png', 
    px = 71, 
    py = 95
}

SMODS.Sticker{
    key = 'magic_bean',
    badge_colour = HEX('66654D'),
    pos = {x = 2, y = 0},
    atlas = 'stickers',
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.sticker_magic_beaned } }
    end,
    apply = function(self, card, val)
        card.ability[self.key] = true
        if card.ability[self.key] then card.ability.sticker_magic_beaned = 1 end        
    end,
    should_apply = function(self, card, center, area, bypass_roll)
        local is_joker = center.set == 'Joker'

        return G.GAME.modifiers.all_magic_beaned and is_joker
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.individual then
            card.ability.sticker_magic_beaned = card.ability.sticker_magic_beaned + 1
            G.hand:change_size(1)
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "+1 Hand Size", colour = G.C.FILTER})
        end
    end
}