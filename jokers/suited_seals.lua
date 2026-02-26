SMODS.Atlas{
    key = "j_suited_seals",
    path = "suited_seals.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'suited_seals',
    loc_vars = function(self, info_queue, card)
        -- TODO?
        -- if SMODS.pseudorandom_probability(card, "secret_text", 1, 2) then
        --     return { key = 'j_CTEH_suited_seals_2' }
        -- end
        return { key = 'j_CTEH_suited_seals_1' }
    end,
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