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
            'When {C:attention}Ante{} begins, set {C:chips,E:2}charges{} to {C:chips}#1#{}',
            'When {C:attention}Blind{} is selected, use a {C:chips,E:2}charge{} per',
            'joker to the left, {C:attention}debuff{} jokers to the right',
            '{C:inactive}(Currently: {C:chips}#2#{C:inactive}){}'
        }
    },
    config = {
        max_charges = 13,
        current_charges = 13
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
                G.jokers.cards[i].ability.perma_debuff = false
                G.jokers.cards[i]:add_to_deck(true)
                G.jokers.cards[i]:juice_up()
                card.ability.current_charges = card.ability.current_charges - 1
            end
            for i = jokers_not_to_debuff + 1, #G.jokers.cards do
                if i ~= buff_joker_index then
                    G.jokers.cards[i].ability.perma_debuff = true
                    G.jokers.cards[i]:remove_from_deck(true)
                    G.jokers.cards[i]:juice_up()
                end
            end
        end
        
        -- 15 is hard coded, since I want it to be a one-time event
        if card.ability.max_charges < 15 and next(SMODS.find_card("v_antimatter")) then
            card.ability.max_charges = card.ability.max_charges + 3
        end

        if context.ante_end then
            card.ability.current_charges = card.ability.max_charges
        end
    end  
}