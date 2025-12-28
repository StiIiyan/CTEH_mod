SMODS.Atlas{
    key = "v_gmo_snacks",
    path = "vouchers.png",
    px = 71,
    py = 95
}
SMODS.Voucher {
    key = 'gmo_snacks',
    pos = { x = 3, y = 0 },
    unlocked = true,
    discovered = true,
    atlas = 'v_gmo_snacks',
    loc_txt = {
        name = 'GMO Snacks',
        text = {
            '{C:enhanced}Perishable{} stickers are also {C:attention}Beaned',
            '{C:gold}Rental{} stickers are also {C:attention}Yolky'
        }
    },
    requires = { 'v_CTEH_food_stamps' },
    redeem = function(self, card)
        G.GAME.modifiers.hybrid_perishable_beaned = true
        G.GAME.modifiers.hybrid_rental_yolky = true
    end
}