-- For Edzy joker
local old_play_to_discard = G.FUNCS.draw_from_play_to_discard
function G.FUNCS.draw_from_play_to_discard(e)
    old_play_to_discard(e)
    RETURN_PLAYED_CARDS = false
end


-- Gigachad sprites
local old_calc_individ_effect = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
    TryChangeChadSprite(effect.card)
    
    return old_calc_individ_effect(effect, scored_card, key, amount, from_edition)
end


-- Beggar's Attire behaviour
local old_create_card = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if next(SMODS.find_card("j_CTEH_beggars_attire")) then
            create_additional_tarots(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    end
    
    return old_create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
end

-- Custom wincon, custom winning condition
local game_start_run_ref = Game.start_run
function Game:start_run(args)
    game_start_run_ref(self, args)

    G.GAME.win_ante = G.GAME.modifiers.alternate_wincon and 39 or G.GAME.win_ante
end

-- Make sizhancement indestructable
local old_shatter = Card.shatter
function Card:shatter()
    if self.config.center.key ~= 'm_CTEH_sizaak_enh' then 
        old_shatter(self) 
        return 
    end
    
    local force_lose = false
    if G.STATE ~= G.STATES.HAND_PLAYED then force_lose = true end

    old_shatter(self)
    siz_end_game(force_lose)
end

-- Make sizhancement unable to be overridden
local old_set_ability = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    if G.STATE ~= G.STATES.MENU and G.STATE ~= G.STATES.BLIND_SELECT and self.config.center.key == 'm_CTEH_sizaak_enh' then return end
    old_set_ability(self, center, initial, delay_sprites)
end

-- Make sizhancement rank unchangeable
local old_set_base = Card.set_base
function Card:set_base(card, initial)-- some weird signature shi, a whole convo in discord
    if G.STATE ~= G.STATES.MENU and G.STATE ~= G.STATES.BLIND_SELECT and self.config.center.key == 'm_CTEH_sizaak_enh' then return end
    old_set_base(self, card, initial)
end

-- Make sizhancement suit unchangeable
local old_change_suit = Card.change_suit
function Card:change_suit(new_suit)
    if G.STATE ~= G.STATES.MENU and G.STATE ~= G.STATES.BLIND_SELECT and self.config.center.key == 'm_CTEH_sizaak_enh' then return end
    old_change_suit(self, new_suit)
end

-- TODO (not priority) make siz edition unchangeable