SMODS.Atlas{
    key = 'stickers', 
    path = 'stickers.png', 
    px = 71, 
    py = 95
}

SMODS.Sticker{
    key = 'egg',
    badge_colour = HEX('F0EAD6'),
    pos = {x = 0, y = 0},
    atlas = 'stickers',
    discovered = true,
    
    should_apply = function(self, card, center, area, bypass_roll)
        local sticker_rate = pseudorandom(pseudoseed('CTEH_egg_sticker'))
        local sticker_apply = sticker_rate >= 0.7
        
        return G.GAME.modifiers.enable_yolky_sticker and sticker_apply
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.individual then
            card.ability.extra_value = card.ability.extra_value + 2
            card:set_cost()
            return {
                message = localize('k_val_up'),
                colour = G.C.MONEY
            }
        end
    end
}