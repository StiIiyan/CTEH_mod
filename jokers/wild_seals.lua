function passive_joker_wild_seals()
    return next(SMODS.find_card("j_CTEH_wild_seals"))
end

WILD_SEAL_TABLE = {}

local function set_wild_seals(context)
    WILD_SEAL_TABLE = {}
    
    for i = 1, #G.hand.cards do
        local seal = G.hand.cards[i].seal
        if (seal ~= nil and not member(WILD_SEAL_TABLE, seal)) then 
            table.insert(WILD_SEAL_TABLE, seal)
        end 
        i = i + 1
    end
end

SMODS.Atlas{
    key = "j_wild_seals",
    path = "wild_seals.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'wild_seals',
    loc_txt = {
        name = 'Wild seals',
        text = {
            'Each {C:attention}Seal{} behaves like',
            'other held in hand {C:attention}Seals{}'
        }
    },
    in_pool = function(self, args)
        for _, card in pairs(G.playing_cards) do
            if card.seal then
                return true
            end
        end
        return false
    end,
    rarity = 1,
    cost = 6,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_wild_seals',
    pos = {x = 0, y = 0},
    calculate = function(self, card, context)
        if context.press_play or context.after or context.discard then
            set_wild_seals(context)
        end
    end  
}
