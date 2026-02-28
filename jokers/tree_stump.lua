SMODS.Atlas{
    key = "j_tree_stump",
    path = "tree_stump.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'tree_stump',
    loc_txt = {
        name = Fade_Gradient({HEX("6A4934"),HEX("FFD3A2"),HEX("5A3E2D")},'tree_stump','Tree Stump',6,false),
        text = {
            '{C:cteh_interest}Interest cap{} increased with each {C:attention}Ring',
            'Lose a {C:attention}Ring{} after first {C:attention}hand{} and {C:attention}discard',
            '{C:inactive}(Currently: #1# Rings)',
        }
    },
    config = {
        additional_interest_cap = 6, -- Rings
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = get_interest_info_queue()
        return {vars = {card.ability.additional_interest_cap}}
    end,
    rarity = 2,
    cost = (G.GAME and G.GAME.interest_rate + 1) or 6,
    blueprint_compat=false,
    eternal_compat=false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_tree_stump',
    pos = {x = 0, y = 0},
    
    calculate = function(self, card, context)
        if context.before and G.GAME.current_round.hands_played == 0 or context.pre_discard and G.GAME.current_round.discards_used <= 0 then
            card.ability.additional_interest_cap = card.ability.additional_interest_cap - 1
            
            if card.ability.additional_interest_cap == 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Chomped", colour = G.C.FILTER})
            end
        end
    end  
}