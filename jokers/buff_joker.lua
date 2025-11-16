function Debuff_Joker_Table()
    local joker_table = {}
    function joker_table:add_joker(jokerID)
        if jokerID == 'j_chaos' then
            local final_free = G.GAME.current_round.free_rerolls > 0
            G.GAME.current_round.free_rerolls = math.max(G.GAME.current_round.free_rerolls - 1, 0)
            calculate_reroll_cost(final_free)
        --elseif G.jokers.cards[i].ability.name == 
        end
    end
    function joker_table:remove_joker(jokerID)
        if jokerID == 'j_chaos' then
            G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls + 1
            calculate_reroll_cost(true)
        end
    end
    
    return joker_table
end

DEBUFFED_JOKERS = Debuff_Joker_Table()

-- remove amount_debuffed_jokers ?


SMODS.Atlas{
    key = "j_buffed",
    path = "buff_joker.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'buff_joker',
    loc_txt = {
        name = 'Buff Joker',
        text = {
            'When {C:attention}Ante{} begins, set {C:chips,E:2}charges{} to {C:chips}#1#{}.',
            'When {C:attention}Blind{} is selected, use a {C:chips,E:2}charge{} per',
            'joker to the left, {C:attention}debuff{} jokers to the right',
            '{C:inactive}(Currently: {C:chips}#2#{C:inactive}){}'
        }
    },
    config = {
        max_charges = 60,
        current_charges = 60
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.max_charges,card.ability.current_charges}}
    end,
    rarity = 4,
    cost = 0,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'j_buffed',
    pos = {x = 0, y = 0},
    in_pool = function(self, args)
        return false
    end,
    add_to_deck = function(self, card, from_debuff)
        card:set_eternal(true)
        if card.edition ~= "e_negative" then
            card:set_edition("e_negative",true,true)
        end
    end,
    
    calculate = function(self, card, context)
        if card.ability.max_charges < 15 and next(SMODS.find_card("v_antimatter")) then
            card.ability.max_charges = card.ability.max_charges + 3
        end

        if context.ante_end then
            card.ability.current_charges = card.ability.max_charges
        end

        if context.setting_blind then
            local buff_joker_index = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.name == card.ability.name then
                    buff_joker_index = i
                    break
                end
            end

            local jokers_not_to_debuff = math.min(buff_joker_index - 1, card.ability.current_charges)
            for i = 1, jokers_not_to_debuff do
                if G.jokers.cards[i].ability.perma_debuff == true then
                    DEBUFFED_JOKERS:remove_joker(G.jokers.cards[i].ability.name)
                end

                G.jokers.cards[i].ability.perma_debuff = false
                G.jokers.cards[i]:juice_up()
                card.ability.current_charges = card.ability.current_charges - 1
            end
            for i = jokers_not_to_debuff + 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.perma_debuff == false then
                    DEBUFFED_JOKERS:add_joker(G.jokers.cards[i].ability.name)
                end

                if i ~= buff_joker_index then
                    G.jokers.cards[i].ability.perma_debuff = true
                    G.jokers.cards[i]:juice_up()
                end
            end
        end
    end  
}

