SMODS.Atlas{
    key = "j_alloy_diffusion",
    path = "alloy_diff.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'alloy_diffusion',
    loc_txt = {
        name = 'Alloy diffusion',
        text = {
            'After achieving a {C:attention}flaming score{},',
            '{C:attention}Gold{} and {C:attention}Steel{} enhancements',
            'liquidate sideways'
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
    config = {
        gold_steel_table = {},
        chips_so_far = 0,
        last_hand_chips = 0,
        x_sprite = 0
    },
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

        if context.blind then
            card.ability.chips_so_far = 0
            card.ability.last_hand_chips = 0
        end

        if context.after then
            card.ability.gold_steel_table = {}

            for i = 1, #G.hand.cards do
                if SMODS.has_enhancement(G.hand.cards[i], 'm_steel') then
                    card.ability.gold_steel_table[i] = 'm_steel'
                elseif SMODS.has_enhancement(G.hand.cards[i], 'm_gold') then
                    card.ability.gold_steel_table[i] = 'm_gold'
                elseif not next(SMODS.get_enhancements(G.hand.cards[i])) then
                    card.ability.gold_steel_table[i] = 'no_enhance'
                else
                    card.ability.gold_steel_table[i] = false
                end
            end

            card.ability.chips_so_far = G.GAME.chips
        end

        if context.end_of_round and context.main_eval and context.game_over == false then
            card.ability.last_hand_chips = G.GAME.chips - card.ability.chips_so_far

            if card.ability.last_hand_chips - G.GAME.blind.chips >= 0 then
                for i = 1, #G.hand.cards do
                    if card.ability.gold_steel_table[i] == 'no_enhance' and 
                    card.ability.gold_steel_table[i-1] and card.ability.gold_steel_table[i-1] ~='no_enhance' then
                        G.hand.cards[i]:set_ability(card.ability.gold_steel_table[i-1], nil, true)
                    elseif card.ability.gold_steel_table[i] == 'no_enhance' and 
                    card.ability.gold_steel_table[i+1] and card.ability.gold_steel_table[i+1] ~='no_enhance' then
                        G.hand.cards[i]:set_ability(card.ability.gold_steel_table[i+1], nil, true)
                    end
                end
            end
        end
    end
}