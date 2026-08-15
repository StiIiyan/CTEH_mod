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
            '{C:green,E:1,S:1.1}x+Probability {C:attention}base',
            '{C:attention}Free rerolls{} after rerolling',
            '{C:attention}Bonus{} Shop slots, {C:red}+100{}, {C:gold}+$23',
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'CTEH_unobtainable', set = 'Other'}
    end,
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
        change_shop_size(2)
    end,
    calculate = function(self, card, context)
        if context.reroll_shop and not context.blueprint then
            single_player:increase_additive_value(1)
            SMODS.change_free_rerolls(2)
        end
        if context.joker_main then
            return {
                mult = 100
            }
        end
    end,
    calc_dollar_bonus = function(self, card)
        return 23
    end
}