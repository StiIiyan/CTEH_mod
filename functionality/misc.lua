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

local game_start_run_ref = Game.start_run
function Game:start_run(args)
    game_start_run_ref(self, args)

    G.GAME.win_ante = G.GAME.modifiers.alternate_wincon and 39 or G.GAME.win_ante
end