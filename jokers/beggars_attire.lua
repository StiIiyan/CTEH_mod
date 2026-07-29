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