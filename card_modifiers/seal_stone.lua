SMODS.Atlas{
    key = 'stickers', 
    path = 'stickers.png', 
    px = 71, 
    py = 95
}

-- calculations are in patches so things work with joker Wild Seals
SMODS.Seal {
    key = 'stone',
    badge_colour = HEX('99A2B3'),
    pos = {x = 5, y = 0},
    atlas = 'stickers',
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local odds = 4
        local numerator, denominator =
            SMODS.get_probability_vars(card, 1, odds)
        return {vars = {numerator, denominator}}
    end
}