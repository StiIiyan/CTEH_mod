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
    sets = { Joker = true },
    rate = 0.3,
    
    should_apply = function(self, card, center, area, bypass_roll)
        --return G.GAME.modifiers.enable_beaned_sticker_in_shop (default check)
        local voucher_check = true -- next(SMODS.find_card("v_CTEH_food_coupons"))
        
        local sticker_rate = pseudorandom(pseudoseed('CTEH_bean_sticker'))
        local sticker_apply = sticker_rate >= 0.7
        
        return voucher_check and sticker_apply
    end
}