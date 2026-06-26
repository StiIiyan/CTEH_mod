WILD_SEAL_TABLE = {}

local function set_wild_seal_table()
    WILD_SEAL_TABLE = {}
    
    -- that is also used for seal pool: G.P_CENTER_POOLS['Seal'] 
    -- (idk why I've previously commented the following code in thought of it not working)
    for seal, _ in pairs(G.P_SEALS) do
        if not member(WILD_SEAL_TABLE, seal) then
            for i = 1, #G.hand.cards do
                if behaveLikeSeal(G.hand.cards[i],seal,false) then 
                    table.insert(WILD_SEAL_TABLE, seal)
                    break
                end
            end
        end        
    end
end

SMODS.Atlas{
    key = "j_wild_seals",
    path = "wild_seals.png",
    px = 71,
    py = 95
}

SMODS.Gradient {
    key = "wild_seals",
    colours = {
        HEX("E8463D"),
        HEX("F7AF38"),
        HEX("009CFD"),
        HEX("A267E4"),
    }
}
SMODS.Gradient {
    key = "wild_seals2",
    colours = {
        HEX("009CFD"),
        HEX("A267E4"),
        HEX("E8463D"),
        HEX("F7AF38"),
    }
}

SMODS.Joker{
    key = 'wild_seals',
    loc_txt = {
        name = '{C:cteh_wild_seals}Wild seals',
        text = {
            'Each {C:cteh_wild_seals2}Seal{} behaves like',
            'other {C:attention}held in hand {C:cteh_wild_seals2}Seals{}'
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
            set_wild_seal_table()
        end
    end  
}
