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
        if context.setting_ability then
            card.ability.immutable = true
        end
    end,
}

-- Works with Trading Card, Vampire, Hanged Man, Midas, Death (only enhancement is kept), Suit Changers, Strength


-- Make enhancement indestructable
local oldShatter = Card.shatter
function Card:shatter()
    if not self.config.center.key == 'm_CTEH_sizaak_enh' then return oldShatter(self) end
    
    local force_lose = false
    if G.STATE ~= G.STATES.HAND_PLAYED then force_lose = true end

    oldShatter(self)
    sizEndGame(force_lose)
end

-- Make enhancement unable to be overridden
local oldCardSetAbility = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    if self and self.ability and self.ability.immutable then return nil end
    return oldCardSetAbility(self, center, initial, delay_sprites)
end

-- Make rank unchangeable
local oldSetBase = Card.set_base
function Card:set_base(card, initial)-- some weird signature shi, a whole convo in discord
    if self and self.ability and self.ability.immutable then return nil end
    return oldSetBase(self, card, initial)
end

-- Make suit unchangeable
local oldChangeSuit = Card.change_suit
function Card:change_suit(new_suit)
    if self and self.ability and self.ability.immutable then return nil end
    return oldChangeSuit(self, new_suit)
end

-- TODO globalize: since I am doing a hook, function needs to be in a global space
function sizEndGame(force_lose)
    local enh_cards = 0
    for _, playing_card in pairs(G.playing_cards or {}) do
        if next(SMODS.get_enhancements(playing_card)) then enh_cards = enh_cards + 1 end
    end
    -- WIN STEP 1: CRASH BUS                (for winning play at least 1 hand for bus to reset)
    if BUS_JUST_CRASHED and enh_cards == 16 and not force_lose then --15 after removing, allegedly
        -- loses instead of W at (== 15), wins instead of L at (== 16) eventhough oldShatter calls before this function
        win_game()
    else
        -- end_round() isn't necessarily lose_game() -> game doesn't end if it's end of round (played in winning hand)
        
        G.STATE = G.STATES.GAME_OVER
        if not G.GAME.won and not G.GAME.seeded and not G.GAME.challenge then 
            G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt = 0
        end
        G:save_settings()
        G.FILE_HANDLER.force = true
        G.STATE_COMPLETE = false
    end
end