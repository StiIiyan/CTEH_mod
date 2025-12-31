SMODS.Atlas{
    key = "v_astral_interest",
    path = "vouchers.png",
    px = 71,
    py = 95
}
SMODS.Voucher {
    key = 'astral_interest',
    pos = { x = 4, y = 0 },
    unlocked = true,
    discovered = true,
    atlas = 'v_astral_interest',
    loc_txt = {
        name = 'Astral Interest',
        text = {
            '{C:tarot}Tarot{} and {C:planet}Planet{} cards',
            'may appear with a {C:cteh_interest}Paycheck{} sticker'
        }
    },
    redeem = function(self, card)
        G.GAME.modifiers.enable_paycheck_sticker = true
    end
}