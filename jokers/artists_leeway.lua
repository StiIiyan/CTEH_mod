SMODS.Atlas{
    key = "j_artists_leeway",
    path = "artists_leeway.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'artists_leeway',
    loc_txt = {
        name = Fade_Gradient({HEX("FFFFFF"),HEX("FFFFFF"),HEX("FFFFFF"),HEX("3EB6FF")},'artists_leeway','Artist\'s Leeway',2,false),
        text = {
            'Suit changing tarots',
            'in {C:enhanced}Tarot packs',
            'are {C:attention}free{} to use'
        }
    },
    rarity = 1,
    cost = 4,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_artists_leeway',
    pos = {x = 0, y = 0},
    
    calculate = function(self, card, context)
        -- functionality in patch
    end
}