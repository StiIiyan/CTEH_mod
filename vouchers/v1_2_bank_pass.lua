SMODS.Atlas{
    key = "v_bank_pass",
    path = "vouchers.png",
    px = 71,
    py = 95
}
SMODS.Voucher {
    key = 'bank_pass',
    pos = { x = 1, y = 0 },
    unlocked = true,
    discovered = true,
    atlas = 'v_bank_pass',
    loc_txt = {
        name = 'Bank pass',
        text = {
            'Lower the interest',
            'rate by {C:money}$1{}'
        }
    },
    requires = { 'v_CTEH_dividends' },
    redeem = function(self, card)
        if G.GAME.interest_rate > 1 then
            G.GAME.interest_rate = G.GAME.interest_rate - 1
        end
    end
}