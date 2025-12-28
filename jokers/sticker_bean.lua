SMODS.Atlas{
    key = 'stickers', 
    path = 'stickers.png', 
    px = 71, 
    py = 95
}

SMODS.Sticker{
    key = 'bean',
    badge_colour = HEX('360202'),
    pos = {x = 1, y = 0},
    atlas = 'stickers',
    discovered = true,
    
    should_apply = function(self, card, center, area, bypass_roll)
        local sticker_rate = pseudorandom(pseudoseed('CTEH_bean_sticker'))
        local sticker_apply = sticker_rate >= 0.75

        local is_joker = center.set == 'Joker'
        
        return G.GAME.modifiers.enable_beaned_sticker and sticker_apply and is_joker
    end
}