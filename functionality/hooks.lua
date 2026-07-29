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