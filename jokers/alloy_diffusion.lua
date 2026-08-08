SMODS.Atlas{
    key = "j_alloy_diffusion",
    path = "alloy_diff.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'alloy_diffusion',
    loc_txt = {
        name = 'Alloy Diffusion',
        text = {
            'After achieving a {X:chips,E:1,C:white}flaming {X:mult,E:1,C:white}score{}',
            '{C:gold}Gold{} and {C:inactive}Steel{} cards liquidate',
            'to left and right {C:attention}unenhanced{} cards'
        }
    },
    rarity = 1,
    cost = 6,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_alloy_diffusion',
    pos = {x = 0, y = 0},
    in_pool = function(self, args)
        for _, card in pairs(G.playing_cards) do
            if SMODS.has_enhancement(card, 'm_steel') or SMODS.has_enhancement(card, 'm_gold') then
                return true
            end
        end
        return false
    end,
    
    calculate = function(self, card, context)
        if card.highlighted then
            card.children.center:set_sprite_pos({x = 1, y = 0})
        else
            card.children.center:set_sprite_pos({x = 0, y = 0})
        end

        if context.end_of_round and context.main_eval and context.game_over == false then
            if SMODS.last_hand_oneshot then
                local gold_steel_table = {}

                for i = 1, #G.hand.cards do
                    if SMODS.has_enhancement(G.hand.cards[i], 'm_steel') then
                        gold_steel_table[i] = 'm_steel'
                    elseif SMODS.has_enhancement(G.hand.cards[i], 'm_gold') then
                        gold_steel_table[i] = 'm_gold'
                    elseif not next(SMODS.get_enhancements(G.hand.cards[i])) then
                        gold_steel_table[i] = 'no_enhance'
                    else
                        gold_steel_table[i] = false
                    end
                end
                for i = 1, #G.hand.cards do
                    if gold_steel_table[i] == 'no_enhance' and 
                    gold_steel_table[i-1] and gold_steel_table[i-1] ~='no_enhance' then
                        G.hand.cards[i]:set_ability(gold_steel_table[i-1], nil, true)
                    elseif gold_steel_table[i] == 'no_enhance' and 
                    gold_steel_table[i+1] and gold_steel_table[i+1] ~='no_enhance' then
                        G.hand.cards[i]:set_ability(gold_steel_table[i+1], nil, true)
                    end
                end
            end
        end
    end
}