-- Lazy evaluation for life difference - some implementations about BMP
-- later somehow should make it BMP compatible without being BMP dependable
function playing_multiplayer()
    if MP and MP.LOBBY then return MP.LOBBY.code end
    return false
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

function amount_debuffed_jokers(joker_name)
    local result = 0;
    if not G.jokers then return result end
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].ability.name == joker_name and 
        (G.jokers.cards[i].ability.debuff or G.jokers.cards[i].ability.perma_debuff) then
            result = result + 1
        end
    end
    return result
end