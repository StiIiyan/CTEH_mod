SMODS.Atlas{
    key = "j_dwarven_space",
    path = "dwarven_space.png",
    px = 71,
    py = 95
}

SMODS.Gradient {
    key = "dwarven_space",
    colours = {
        HEX("DAEAE7"),
        HEX("F8EFDE"),
        HEX("93A8B1"),
        HEX("5F718B"),
    }
}

SMODS.Joker{
    key = 'dwarven_space',
    loc_txt = {
        name = '{C:cteh_dwarven_space}Dwarven Space',
        text = {
            'Using a {C:planet}Dwarven Planet{} consumable',
            '{C:attention}upgrades{} all {C:planet}Dwarven Planets'
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'dwarven_planets', set = 'Other'}
    end,
    rarity = 1,
    cost = 3,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_dwarven_space',
    pos = {x = 0, y = 0},
    calculate = function(self, card, context)
        if context.using_consumeable then 
            if context.consumeable.ability.name == 'Pluto' or
            context.consumeable.ability.name == 'Ceres' or context.consumeable.ability.name == 'Eris' then
                if context.consumeable.ability.name == 'Pluto' then
                    SMODS.upgrade_poker_hands({hands = {"Flush Five","Flush House"}, from = card})
                elseif context.consumeable.ability.name == 'Ceres' then
                    SMODS.upgrade_poker_hands({hands = {"Flush Five","High Card"}, from = card})
                elseif context.consumeable.ability.name == 'Eris' then
                    SMODS.upgrade_poker_hands({hands = {"Flush House","High Card"}, from = card})
                end
            end
        end
    end
}