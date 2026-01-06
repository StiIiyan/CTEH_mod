SMODS.Atlas{
    key = "j_boss_payout",
    path = "boss_payout.png",
    px = 71,
    py = 95
}

SMODS.Gradient {
    key = "boss_payout",
    colours = {
        HEX("C6E0EB"),
        HEX("C6E0EB"),
    }
}

SMODS.Joker{
    key = 'boss_payout',
    loc_txt = {
        name = '{C:cteh_boss_payout}Boss Payout',
        text = {
            'When {C:attention}Boss Blind{} is defeated',
            '{C:green}#1# in #2#{} to create any {C:cteh_interest}Interest voucher',
            'Add {C:green}1/3{} when {C:attention}Shop{} from {C:attention}Small{} or {C:attention}Big Blind',
            'is {C:attention}exited{} with full {C:cteh_interest}interest',
        }
    },
    rarity = 2,
    cost = (G.GAME and G.GAME.interest_rate + 3) or 8,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_boss_payout',
    pos = {x = 0, y = 0},
    
    config = {
        numerator_odds = 1,
        odds = 3,
        last_blind = 'Boss'
    },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator =
            SMODS.get_probability_vars(card, card.ability.numerator_odds, card.ability.odds, "boss_payout")
        return {vars = {numerator, denominator}}
    end,
    calculate = function(self, card, context)     
        if context.blind then
            card.ability.last_blind = G.GAME.blind:get_type()
        end
        
        if context.ending_shop and card.ability.last_blind ~= 'Boss' and is_interest_full() then
            card.ability.numerator_odds = card.ability.numerator_odds + 1
        end

        if G.GAME.blind:get_type() == 'Boss' and context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            if not SMODS.pseudorandom_probability(card, "boss_payout", card.ability.numerator_odds, card.ability.odds) then
                card.ability.numerator_odds = 1
                return
            end
            card.ability.numerator_odds = 1
            
            local voucher_key = get_next_interest_voucher_key()

            if voucher_key == "" then return end

            local voucher_card = SMODS.create_card({ area = G.play, key = voucher_key })
            voucher_card:start_materialize()
            voucher_card.cost = 0
            G.play:emplace(voucher_card)
            delay(0.8)
            voucher_card:redeem()
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.5,
                func = function()
                    voucher_card:start_dissolve()
                    return true
                end
            }))

        end
    end
}