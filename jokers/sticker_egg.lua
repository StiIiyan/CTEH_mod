SMODS.Atlas{
    key = 'stickers', 
    path = 'stickers.png', 
    px = 71, 
    py = 95
}

SMODS.Sticker{
    key = 'egg',

    should_apply = function(self, card, center, area, bypass_roll)
        local default_check = SMODS.Sticker.should_apply(self, card, center, area, bypass_roll)
        local other_sticker_check = not (card.ability.eternal or card.ability.bunc_hindered or card.ability.bunc_reactive)
        local shop_check = (area == G.shop_jokers) or (area == G.pack_cards)
        return default_check and other_sticker_check and shop_check
    end,
    apply = function(self, card, val)
        card.ability[self.key] = val
    end,

    badge_colour = HEX('F0EAD6'),
    
    pos = {x = 0, y = 0},
    atlas = 'stickers'
}