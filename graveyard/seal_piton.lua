SMODS.Atlas{
    key = 'stickers', 
    path = 'stickers.png', 
    px = 71, 
    py = 95
}

-- calculations should be in patches so things work with joker Wild Seals (check functionality/seals.lua for more info)
SMODS.Seal {
    key = 'piton',
    badge_colour = HEX('EDD28B'),
    pos = {x = 0, y = 1},
    atlas = 'stickers',
    discovered = true,
    calculate = function(self, card, context)
        if context.main_scoring then -- individual? main_scoring? (when scored)
            card.perma_luck = (card.perma_luck or 0) + 1
        end
    end,
}