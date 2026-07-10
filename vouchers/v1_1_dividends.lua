SMODS.Atlas{
    key = "v_dividends",
    path = "vouchers.png",
    px = 71,
    py = 95
}
SMODS.Voucher {
    key = 'dividends',
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    atlas = 'v_dividends',
    loc_txt = {
        name = 'Dividends',
        text = {
            'Lower the {C:cteh_interest}interest',
            '{C:cteh_interest}rate{} by {C:money}$1{}',
            '{C:cteh_interest}Interest {C:attention}Vouchers{} and {C:attention}Jokers{}',
            'have reduced prices',
        }
    },
    redeem = function(self, card)
        reduce_interest_rate(1)
    end
}