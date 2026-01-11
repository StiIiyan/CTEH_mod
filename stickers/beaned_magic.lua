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
        return { vars = { card.ability.magic_beaned } }
    end,
    apply = function(self, card, val)
        card.ability[self.key] = true
        if card.ability[self.key] then card.ability.magic_beaned = 1 end        
    end,
    should_apply = function(self, card, center, area, bypass_roll)
        local is_joker = center.set == 'Joker'

        return G.GAME.modifiers.all_magic_beaned and is_joker
    end
}