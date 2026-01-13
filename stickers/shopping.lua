SMODS.Atlas{
    key = 'stickers', 
    path = 'stickers.png', 
    px = 71, 
    py = 95
}

SMODS.Sticker{
    key = 'shopping',
    badge_colour = HEX('EED15A'),
    pos = {x = 4, y = 0},
    atlas = 'stickers',
    discovered = true,
    apply = function(self, card, val)
        card.ability[self.key] = true
        if card.ability[self.key] then card.ability.sticker_shopping = true end
        -- ease_dollars(1)
        -- card_eval_status_text(card, 'extra', nil, nil, nil, {message = "$1", colour = G.C.GOLD})
    end,
    should_apply = function(self, card, center, area, bypass_roll)
        local sticker_rate = pseudorandom(pseudoseed('CTEH_shopping_sticker'))
        local sticker_apply = sticker_rate >= 0.80

        local is_playing_card = center.set ~= 'Joker' and center.set ~= 'Tarot' and center.set ~= 'Planet' and center.set ~= 'Spectral'
        
        return G.GAME.modifiers.enable_shopping_sticker and is_playing_card and sticker_apply
    end
}