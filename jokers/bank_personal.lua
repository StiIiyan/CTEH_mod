SMODS.Atlas{
    key = "j_bank_personal",
    path = "bank_personal.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'bank_personal',
    loc_txt = {
        name = Fade_Gradient({HEX("FFFFFF"),HEX("FFFFFF"),HEX("FFFFFF"),HEX("FFFFFF"),HEX("FFFFFF"),HEX("FFEF87")},'bank_personal','Personal Bank',3,false),
        text = {
            'At end of round earn {C:attention}double{} your {C:cteh_interest}interest cap',
            'with an {C:cteh_interest}interest rate{} of {C:gold}$1{} lower',
            '{C:inactive}(Joker\'s interest rate is {C:gold}$#1#{C:inactive}, cap is {C:gold}$#2#{C:inactive})',
            '{C:inactive}(Joker\'s total interest caps at {C:gold}$#3#{C:inactive})'
        }
    },
    rarity = 3,
    cost = (G.GAME and 2 * G.GAME.interest_rate) or 10,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_bank_personal',
    pos = {x = 0, y = 0},
    
    config = {
        interest_rate = (G and G.GAME and G.GAME.interest_rate - 1) or 4,
        interest_cap = (G and G.GAME and 2 * G.GAME.interest_cap) or 10
    },
    loc_vars = function(self, info_queue, card)
        card.ability.interest_rate = (G and G.GAME and G.GAME.interest_rate - 1) or 4
        card.ability.interest_cap = (G and G.GAME and 2 * G.GAME.interest_cap) or 10
        local total_cap = card.ability.interest_cap * card.ability.interest_rate
        return {vars = {card.ability.interest_rate,card.ability.interest_cap,total_cap}}
    end,    
    calc_dollar_bonus = function(self, card)
        return  G.GAME.interest_amount*math.min(math.floor(G.GAME.dollars/card.ability.interest_rate), card.ability.interest_cap)
    end
}