SMODS.Atlas{
    key = "j_buried_treasure",
    path = "buried_treasure.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'buried_treasure',
    loc_txt = {
        name = 'Buried Treasure',
        text = {
            'Your last {C:attention}#1#{} cards contain',
            '{C:attention}#2#{} enhancements, {C:attention}#3#{} editions and {C:attention}#4#{} seals',
            'Earn {C:gold}$#5#{} upon finishing a blind',
            'without drawing these cards',
            '{C:inactive}(Increase prize with {C:gold}$1{C:inactive} per modifier)',
            '{C:inactive}(Card amount equals {C:attention}double{C:inactive} your {C:attention}handsize{C:inactive})',
        }
    },
    rarity = 2,
    cost = 6,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_buried_treasure',
    pos = {x = 0, y = 0},
    
    config = {
        enh_cards = 0,
        ed_cards = 0,
        seal_cards = 0,
        trigger = true
    },
    loc_vars = function(self, info_queue, card)
        local double_handsize = G and G.hand and 2 * #G.hand.cards or 16
        local prize = card.ability.enh_cards + card.ability.ed_cards + card.ability.seal_cards

        return {vars = {double_handsize,card.ability.enh_cards,
                        card.ability.ed_cards,card.ability.seal_cards,prize}}
    end,
    calculate = function(self, card, context)
        -- no reshuffling mechanics so only does math when round beginning
        if context.first_hand_drawn then
            card.ability.trigger = true

            local double_handsize = 2 * #G.hand.cards
            card.ability.enh_cards = 0
            card.ability.ed_cards = 0
            card.ability.seal_cards = 0
            
            local remaining_cards = math.min(double_handsize, #G.deck.cards)

            for i = 1, remaining_cards do 
                local deck_card = G.deck.cards[i]
                if deck_card.seal then
                    card.ability.seal_cards = 1 + card.ability.seal_cards
                end
                if next(SMODS.get_enhancements(deck_card)) then
                    card.ability.enh_cards = 1 + card.ability.enh_cards
                end
                if deck_card.edition then
                    card.ability.ed_cards = 1 + card.ability.ed_cards
                end
            end
        end

        -- Joker works even if handsize changes during round :)
        if context.before then
            card.ability.trigger = (#G.deck.cards >= 2 * (#G.hand.cards + #G.play.cards))
        end
    end,
        
    calc_dollar_bonus = function(self, card)
        if card.ability.trigger then
            return card.ability.enh_cards + card.ability.ed_cards + card.ability.seal_cards
        end
    end
}