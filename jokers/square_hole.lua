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
            '{C:attention}Joker{} to the right {E:1}becomes',
            '{C:attention}Square Joker{} when selecting {C:attention}Blind{}',
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
    pixel_size = { h = 71 },    
    calculate = function(self, card, context)
        if context.blind then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.name == 'j_CTEH_square_hole' and i + 1 <= #G.jokers.cards and
                 not G.jokers.cards[i + 1].ability.eternal and G.jokers.cards[i + 1].ability.name ~= 'Square Joker' then
                    play_sound('whoosh1', 0.55, 0.62)
                    G.jokers.cards[i + 1]:set_ability("j_square")
                end
                -- if it's most right, turn itself in a square joker
                if G.jokers.cards[i].ability.name == 'j_CTEH_square_hole' and i == #G.jokers.cards and 
                 not G.jokers.cards[i].ability.eternal then
                    play_sound('whoosh1', 0.55, 0.62)
                    G.jokers.cards[i]:set_ability("j_square")
                end
            end
        end
    end
}