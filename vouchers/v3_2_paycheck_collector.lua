SMODS.Atlas{
    key = "v_paycheck_collector",
    path = "vouchers.png",
    px = 71,
    py = 95
}
SMODS.Voucher {
    key = 'paycheck_collector',
    pos = { x = 5, y = 0 },
    unlocked = true,
    discovered = true,
    atlas = 'v_paycheck_collector',
    loc_txt = {
        name = 'Paycheck Collector',
        text = {
            '{C:attention}Vouchers{} generate {C:green}interest',
            '{C:green}#1# in #2#{} to generate {C:green}interest',
            'when any {C:attention}Booster Pack{} is skipped'
        }
    },
    loc_vars = function(self, info_queue, card)
        local odds = 2
        local numerator, denominator =
            SMODS.get_probability_vars(card, 1, odds, "paycheck")
        return {vars = {numerator, denominator}}
    end,
    requires = { 'v_astral_interest' },
    redeem = function(self, card)
        G.GAME.modifiers.vouchers_give_interest = true
        G.GAME.modifiers.boosters_give_interest = true        
    end
}