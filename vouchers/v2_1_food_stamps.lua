SMODS.Atlas{
    key = "v_food_stamps",
    path = "vouchers.png",
    px = 71,
    py = 95
}
SMODS.Voucher {
    key = 'food_stamps',
    pos = { x = 2, y = 0 },
    unlocked = true,
    discovered = true,
    atlas = 'v_food_stamps',
    loc_txt = {
        name = 'Food Stamps',
        text = {
            'Jokers now appear with',
            '{C:attention}Yolky{} and {C:attention}Beaned{} stickers'
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'CTEH_egg', set = 'Other'}
        info_queue[#info_queue + 1] = {key = 'CTEH_bean', set = 'Other'}
    end,
    redeem = function(self, card)
        G.GAME.modifiers.enable_yolky_sticker = true
        G.GAME.modifiers.enable_beaned_sticker = true
    end
}