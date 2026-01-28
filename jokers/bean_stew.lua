SMODS.Atlas{
    key = "j_bean_stew",
    path = "bean_stew.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'bean_stew',
    loc_txt = {
        name = 'Bean Stew',
        text = {
            '{C:attention}+#1#{} hand size',
            '{C:red}-#2#{} hand size after',
            'each played hand',
            '{C:inactive}(Currently: {C:attention}#3#{C:inactive})'
        }
    },
    rarity = 2,
    cost = 8,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_bean_stew',
    pos = {x = 0, y = 0},
    
    config = {
        base_handsize = 3,
        current_hand_size = 3,
        handsize_reduction = 2
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.base_handsize,card.ability.handsize_reduction,card.ability.current_hand_size}}
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            G.hand:change_size(card.ability.base_handsize - card.ability.current_hand_size)
            card.ability.current_hand_size = card.ability.base_handsize
        end

        if context.press_play then
            G.hand:change_size(-card.ability.handsize_reduction)
            card.ability.current_hand_size = card.ability.current_hand_size - card.ability.handsize_reduction
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.current_hand_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.current_hand_size)
    end
}