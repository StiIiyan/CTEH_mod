SMODS.Atlas{
    key = 'stickers', 
    path = 'stickers.png', 
    px = 71, 
    py = 95
}

SMODS.Sticker{
    key = 'paycheck',
    badge_colour = HEX('4D8276'),
    pos = {x = 2, y = 0},
    atlas = 'stickers',
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local odds = 4
        local numerator, denominator =
            SMODS.get_probability_vars(card, 1, odds, "paycheck")
        return {vars = {numerator, denominator}}
    end,
    apply = function(self, card, val)
        card.ability[self.key] = true
    end,
    should_apply = function(self, card, center, area, bypass_roll)
        local sticker_rate = pseudorandom(pseudoseed('CTEH_paycheck_sticker'))
        local sticker_apply = sticker_rate >= 0.75

        local is_tarot_or_planet = center.set == 'Tarot' or center.set == 'Planet'
        
        return G.GAME.modifiers.enable_paycheck_sticker and sticker_apply and is_tarot_or_planet
    end
    -- button_callbacks -> if card.ability.consumeable then
}