local function fixateDeck()
    -- TODO undo
    add_tag(Tag('tag_coupon'))
    -- shouldn't ever trigger, try later without it
    if not (G and G.deck and G.deck.cards) then return end

    for i,val in ipairs({'2','3','4','5','7','8','9','10','Queen','King','6','Jack','Ace'}) do
        local amount = 0
        for j,card in ipairs(G.deck.cards) do
            if card.value == val then
            -- if amount < 4 and G.deck.cards[j] and G.deck.cards[4 * i + amount] then
                -- swap
                local temp_card = G.deck.cards[j]
                G.deck.cards[j] = G.deck.cards[4 * i + amount]
                G.deck.cards[4 * i + amount] = temp_card
                amount = amount + 1
            end
        end
    end
end

SMODS.Challenge {
    key = 'bottom',
    rules = {
        custom = {
            { id = 'fixed_deck_order' },
        }
    },
    restrictions = {
        banned_tags = {
            { id = 'tag_charm' },
            { id = 'tag_juggle' },
        },
    },
    -- instead debug in fixateDeck() (called during pseudoshuffle)

    -- calculate = function(self, context)
    --     if context.setting_blind then
    --         --fixateDeck()
    --     end
    -- end,
}

-- VVVVVVVVVVVVVVVVV follows some jank code VVVVVVVVVVVVVVVVV

--[[
Bottom Deck: Challenge, custom wincon: 1 ante
% side note: make custom ante-based wincon (not just custom wincon setting finishing ante to ante 39)
]]

local old_pshuffle = pseudoshuffle
function pseudoshuffle(list, seed)
    if true or not G.GAME.modifiers.fixed_deck_order then
        old_pshuffle(list, seed)
    else 
        fixateDeck()    
    end

    -- if list[1] and list[1].sort_id then
    --     table.sort(list,    
    --         function (a, b) 
    --             -- a or b?
    --             local rank_id = b.sort_id
    --             if rank_id > 12 then
    --                 return (a.sort_id or 1) > (b.sort_id or 2)
    --             end
    --             return (a.sort_id or 1) < (b.sort_id or 2) 
    --         end
    --     )
    -- end
end