SMODS.Atlas{
    key = "v_dividends",
    path = "vouchers.png",
    px = 71,
    py = 95
}
SMODS.Voucher {
    key = 'dividends',
    pos = { x = 0, y = 0 },
    cost = (G.GAME and 2 * G.GAME.interest_rate) or 10,
    unlocked = true,
    discovered = true,
    atlas = 'v_dividends',
    loc_txt = {
        name = 'Dividends',
        text = {
            'Lower the {C:cteh_interest}interest',
            '{C:cteh_interest}rate{} by {C:money}$1{}'
        }
    },
    redeem = function(self, card)
        if G.GAME.interest_rate > 1 then
            G.GAME.interest_rate = G.GAME.interest_rate - 1
        end
    end
}