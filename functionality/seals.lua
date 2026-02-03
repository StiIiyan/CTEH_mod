function behaveLikeSeal(card,desiredSeal,recursive)
    -- TODO add recursive nil check
    if card.seal == desiredSeal then
        return true
    end

    if next(SMODS.find_card("j_CTEH_wild_seals")) and isConsideredSealed(card) and not recursive then
        local return_value = false
        for i = 1, #G.hand.cards do
            local card_in_hand = G.hand.cards[i]
            return_value = return_value or behaveLikeSeal(card_in_hand,desiredSeal,true) or
                           isConsideredSealed(card_in_hand) and member(WILD_SEAL_TABLE,desiredSeal)
            if return_value then return return_value end
        end
    end

    if next(SMODS.find_card("j_CTEH_suited_seals")) then
        if card.is_suit('Spades', false, false) and desiredSeal == 'Purple' then return true
        elseif card.is_suit('Hearts', false, false) and desiredSeal == 'Red' then return true 
        elseif card.is_suit('Diamonds', false, false) and desiredSeal == 'Gold' then return true 
        elseif card.is_suit('Clubs', false, false) and desiredSeal == 'Blue' then return true
        end
    end

    return false
end

function isConsideredSealed(card)
    return card.seal or next(SMODS.find_card("j_CTEH_suited_seals"))
end