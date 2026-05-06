SMODS.Atlas{
    key = "j_cherry_andy",
    path = "cherry_andy.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'cherry_andy',
    loc_txt = {
        name = 'Cherry Andy',
        text = {
            '{C:red}+#1#{} discards',
            '{C:warning_bg}Die{} to discarding',
            '{C:red}NO{} faces'
        }
    },
    config = { d_size = 4 },
    rarity = 2,
    cost = 7,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_cherry_andy',
    pos = {x = 0, y = 0},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.d_size } }
    end,
    add_to_deck = function(self, card, from_debuff)
        ease_discard(card.ability.d_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        ease_discard(-card.ability.d_size)
    end,
    
    calculate = function(self, card, context)
        if context.discard and context.other_card == context.full_hand[#context.full_hand] then
            no_faces = true
            for _, discarded_card in ipairs(context.full_hand) do
                if discarded_card:is_face() then no_faces = false end
            end
            if no_faces then end_round() end
        end
    end  
}
