function behaveLikeSeal(card,desiredSeal,recursive)
    if card.seal == desiredSeal then
        return true
    end

    if next(SMODS.find_card("j_CTEH_wild_seals")) and isConsideredSealed(card) and not recursive then
        for i = 1, #G.hand.cards do
            local card_in_hand = G.hand.cards[i]
            local return_value = behaveLikeSeal(card_in_hand,desiredSeal,true) or
                           isConsideredSealed(card_in_hand) and member(WILD_SEAL_TABLE,desiredSeal)
            if return_value then return return_value end
        end
    end

    -- seems to work with either card.playing_card or card.base (errors show up without any of them)
    if card.playing_card and next(SMODS.find_card("j_CTEH_suited_seals")) then
        if card:is_suit('Spades') and desiredSeal == 'Purple' then return true
        elseif card:is_suit('Hearts') and desiredSeal == 'Red' then return true 
        elseif card:is_suit('Diamonds') and desiredSeal == 'Gold' then return true 
        elseif card:is_suit('Clubs') and desiredSeal == 'Blue' then return true
        elseif SMODS.has_enhancement(card, 'm_stone') and desiredSeal == 'CTEH_stone' then return true
        end
    end

    return false
end

function isConsideredSealed(card)
    return card.seal or card.playing_card and next(SMODS.find_card("j_CTEH_suited_seals"))
end