SMODS.Atlas{
    key = "j_beggars_attire",
    path = "beggars_attire.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'beggars_attire',
    loc_txt = {
        name = 'Beggar\'s Attire',
        text = {
            '{C:attention}+#1#{} Consumable Slot,',
            '{C:enhanced}Tarot{} generators generate',
            'an additional {C:enhanced}Tarot{}',
        }
    },
    rarity = 3,
    cost = 8,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_beggars_attire',
    pos = {x = 0, y = 0},
    
    config = {
        consumable_slots = 1,
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.consumable_slots}}
    end,
    calculate = function(self, card, context)
        -- logic in the create_card hook
    end,
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.consumable_slots
            return true end }))
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.consumable_slots
            return true end }))
    end
}

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