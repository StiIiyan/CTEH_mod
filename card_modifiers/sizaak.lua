-- Art by vaga's editor

SMODS.Atlas{
    key = 'sizaak', 
    path = 'sizaak.png', 
    px = 71, 
    py = 95
}

SMODS.Enhancement {
    key = 'sizaak_enh',
    atlas = 'sizaak',
    pos = { x = 0, y = 0 },
    replace_base_card = true,
    shatters = true,
    always_scores = true,
    -- TODO figure out which of the following two makes the card not being generated
    weight = 0, -- not randomly generated
    in_pool = function(self, args)
        return false
    end,
    calculate = function(self, card, context)
        if context.destroy_card and context.cardarea == G.play and context.destroy_card == card then
            card.glass_trigger = true
            return { remove = true }
        end
    end,
}

-- Works with Trading Card, Vampire, Hanged Man, Midas, Death (only enhancement is kept), Suit Changers, Strength

-- Make enhancement unable to be overridden
local oldCardSetAbility = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    if self.config.center.key == 'm_CTEH_sizaak_enh' then return nil end
    return oldCardSetAbility(self, center, initial, delay_sprites)
end

-- Make enhancement indestructable
local oldShatter = Card.shatter
function Card:shatter()
    if not self.config.center.key == 'm_CTEH_sizaak_enh' then return oldShatter(self) end
    
    -- TODO if card is not destroyed by hand played but by other means (still don't work)
    if not G.STATE == G.STATES.HAND_PLAYED then return nil end

    oldShatter(self)
    sizEndGame()
end

-- Make suit unchangeable
local oldChangeSuit = Card.change_suit
function Card:change_suit(new_suit)
    if self.config.center.key == 'm_CTEH_sizaak_enh' then return nil end
    return oldChangeSuit(self, new_suit)
end

-- Make rank unchangeable
local oldSetBase = Card.set_base
function Card:set_base(card, initial)-- some weird signature shi, a whole convo in discord
    if self and self.config.center.key == 'm_CTEH_sizaak_enh' then return nil end
    return oldSetBase(self, card, initial)
end

-- TODO globalize: since I am doing a hook, function needs to be in a global space
function sizEndGame()
    local enh_cards = 0
    for _, playing_card in pairs(G.playing_cards or {}) do
        if next(SMODS.get_enhancements(playing_card)) then enh_cards = enh_cards + 1 end
    end
    if BUS_JUST_CRASHED and enh_cards == 15 then --15 after removing
        win_game()
    else
        end_round()
    end
end