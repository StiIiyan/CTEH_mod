SMODS.Atlas{
    key = "j_square_hole",
    path = "square_hole.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'square_hole',
    loc_txt = {
        name = 'Square Hole',
        text = {
            'All hands scale {C:attention}Square Joker{}',
            'When selecting {C:attention}Blind{}, joker to the right',
            '{E:1}becomes {C:attention}Square Joker',
            '{C:inactive,s:0.7}That\'s right! It goes in the square hole'
        }
    },
    rarity = 2,
    cost = 6,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_square_hole',
    pos = {x = 0, y = 0},
    
    calculate = function(self, card, context)
        if context.blind then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.name == 'j_CTEH_square_hole' and i + 1 <= #G.jokers.cards and not G.jokers.cards[i + 1].ability.eternal then
                    G.jokers.cards[i + 1]:set_ability("j_square")
                end
            end
        end
    end
}