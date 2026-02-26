SMODS.Atlas{
    key = "j_suited_seals",
    path = "suited_seals.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'suited_seals',
    loc_vars = function(self, info_queue, card)
        card.ability.description_switch = not card.ability.description_switch

        if card.ability.description_switch then
            return { key = 'j_CTEH_suited_seals_1' }
        else
            return { key = 'j_CTEH_suited_seals_2' }
        end
    end,
    config = {
        description_switch = true
    },
    rarity = 4,
    cost = 20,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_suited_seals',
    pos = {x = 0, y = 0},
}