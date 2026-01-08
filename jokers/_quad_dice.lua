SMODS.Atlas{
    key = "j_quad_dice",
    path = "quad_dice.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'quad_dice',
    loc_txt = {
        name = Fade_Gradient({HEX("80F1C3"),HEX("469575"),HEX("CBE9F6")},'quad_dice','Quad Dice',3,false),
        text = {
            '{C:green}x16 probabilities',
            '{C:attention}5000{} free rerolls',
            '{C:attention}+2{} slots in Shop',
        }
    },
    rarity = 1,
    cost = 6,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_quad_dice',
    pos = {x = 0, y = 0},
    in_pool = function(self, args)
        return false
    end,
    add_to_deck = function(self, card, from_debuff)
        single_player:increase_multiplicative_value(16)
        SMODS.change_free_rerolls(5000)
        change_shop_size(2)
    end,
    remove_from_deck = function(self, card, from_debuff)
        single_player:increase_multiplicative_value(0.0625)
        SMODS.change_free_rerolls(-5000)
        change_shop_size(-2)
    end
}