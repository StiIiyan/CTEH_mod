INTEREST_HEX_VAL = HEX("5F897B")

SMODS.Gradient {
    key = "interest",
    colours = {
        INTEREST_HEX_VAL,
        INTEREST_HEX_VAL,
    }
}

SMODS.ObjectType({
    key = "Interest_Jokers",
    default = "j_to_the_moon",
    cards = {
        j_to_the_moon = true,
        j_CTEH_bank_personal = true,
    }
})
SMODS.ObjectType({
    key = "Interest_Vouchers",
    default = "v_seed_money",
    cards = {
        v_seed_money = true,
        v_money_tree = true,
        v_CTEH_dividends = true,
        v_CTEH_bank_pass = true,
        v_CTEH_astral_interest = true,
        v_CTEH_paycheck_collector = true,
    }
})

function get_total_interest()
    local total_interest = 0

    local default_interest = G.GAME.interest_amount*math.min(math.floor(G.GAME.dollars/G.GAME.interest_rate), G.GAME.interest_cap)

    total_interest = total_interest + default_interest

    -- only jokers which themselves generate interest, not any joker from the pool
    for i = 1, #G.jokers.cards do
        local current_joker = G.jokers.cards[i]
        if current_joker.ability.interest_rate and G.jokers.cards[i].ability.interest_cap then
            total_interest = total_interest + G.GAME.interest_amount*math.min(math.floor(G.GAME.dollars/current_joker.ability.interest_rate), current_joker.ability.interest_cap)
        end
    end

    return total_interest
end

function generate_interest()
    ease_dollars(get_total_interest(), true)
end

function is_interest_full()
    local interest_is_full = true

    interest_is_full = interest_is_full and (math.min(math.floor(G.GAME.dollars/G.GAME.interest_rate), G.GAME.interest_cap) == G.GAME.interest_cap)

    for i = 1, #G.jokers.cards do
        local current_joker = G.jokers.cards[i]
        if current_joker.ability.interest_rate and G.jokers.cards[i].ability.interest_cap then
            interest_is_full = interest_is_full and (math.min(math.floor(G.GAME.dollars/current_joker.ability.interest_rate), current_joker.ability.interest_cap) == current_joker.ability.interest_cap)
        end
    end

    return interest_is_full
end