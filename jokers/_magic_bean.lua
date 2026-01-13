SMODS.Atlas{
    key = "j_magic_bean",
    path = "magic_bean.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'magic_bean',
    loc_txt = {
        name = 'Magic Bean',
        text = {
            '{C:attention}+#1#{} hand size,',
            'increases by',
            '{C:attention}#2#{} each round',
            '{C:inactive}(Current hand size: {C:attention}#3#{C:inactive})'
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'CTEH_unobtainable', set = 'Other'}

        local other_jokers_handsize = 0
        if G.jokers then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.sticker_magic_beaned then
                    other_jokers_handsize = other_jokers_handsize + G.jokers.cards[i].ability.sticker_magic_beaned
                end
            end
        end
        local total_handsize = G.GAME.starting_params.hand_size + card.ability.handsize + other_jokers_handsize
        return { vars = { card.ability.handsize, card.ability.handsize_increment, total_handsize } }
    end,
    config = {
        handsize = 5,
        handsize_increment = 1
    },
    rarity = 1,
    cost = 6,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'j_magic_bean',
    pos = {x = 0, y = 0},
    in_pool = function(self, args)
        return false
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.handsize = card.ability.handsize + card.ability.handsize_increment
            G.hand:change_size(card.ability.handsize_increment)
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "+1 Hand Size", colour = G.C.FILTER})
        end

        if G.GAME.modifiers.empty_deck_lose_condition and #G.deck.cards <= 0 then
            end_round()
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.handsize)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.handsize)
    end
}