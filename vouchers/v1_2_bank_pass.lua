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
        name = 'Bank Pass',
        text = {
            'Lower the {C:cteh_interest}interest',
            '{C:cteh_interest}rate{} by {C:money}$1{}',
            'Reduce {C:attention}Voucher{} and {C:attention}Joker{} prices',
            'related to {C:cteh_interest}interest{}',
        }
    },
    requires = { 'v_CTEH_dividends' },
    redeem = function(self, card)
        if G.GAME.interest_rate > 1 then
            G.GAME.interest_rate = G.GAME.interest_rate - 1
        end
    end
}