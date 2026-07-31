-- Lazy evaluation for life difference - some implementations about BMP
function playing_multiplayer()
    if MP and MP.LOBBY then return MP.LOBBY.code end
    return false
end

function loaded_BMP()
    return next(SMODS.find_mod("Multiplayer"))
end

function life_difference()
    if not playing_multiplayer() then
        return 0
    end
    return MP.GAME.enemy.lives - MP.GAME.lives
end

function life_difference_nonnegative()
    if not playing_multiplayer() then
        return 0
    end
    return math.max(life_difference(), 0)
end

function member(table,element)
    local i = 1
    local contains = false

    repeat 
        if (table[i] == element) then 
            contains = true
        end 
        i = i + 1 
    until(i > #table)

    return contains 
end

local tarot_keys = {"c_fool","c_magician","c_high_priestess","c_empress","c_emperor","c_heirophant","c_lovers",
                    "c_chariot","c_justice","c_hermit","c_wheel_of_fortune","c_strength","c_hanged_man","c_death",
                    "c_temperance","c_devil","c_tower","c_star","c_moon","c_sun","c_judgement","c_world"}

function is_key_tarot(key)
    return member(tarot_keys,key)
end

SMODS.ObjectType({
    key = "Uncopyable_Jokers",
    default = "j_CTEH_buff_joker",
    cards = {
        j_CTEH_buff_joker = true,
        j_CTEH_magic_bean = true,
    }
})


function create_additional_tarots(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local beggars_attire_condition = ((_type == 'Tarot' or _type == 'Tarot_Planet' and is_key_tarot(G.GAME.last_tarot_planet))
        and not soublable and key_append ~= "sho" and area == G.consumeables 
        and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit)

    if not beggars_attire_condition then return end

    local additional_cards = math.min((G.consumeables.config.card_limit - (#G.consumeables.cards + G.GAME.consumeable_buffer)),#SMODS.find_card('j_CTEH_beggars_attire'))
    
    for i = 1, additional_cards do
        local card = old_create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
        card:add_to_deck()
        area:emplace(card)
    end
end


-- Custom wincon, sizaak win condition
function siz_end_game(force_lose)
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