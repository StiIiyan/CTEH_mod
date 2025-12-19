-- Make it so multiple instances of Square Joker stack their scaling, scalability and even rental/eternal stickers

function SQUARE_UP()
    local scaled_chips = 0
    local scaling = 0
    local add_eternal = false
    local add_rental = false
    local square_count = 0

    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].ability.name == 'Square Joker' then
            local squareJ = G.jokers.cards[i]
            scaled_chips = scaled_chips + squareJ.ability.extra.chips
            scaling = scaling + squareJ.ability.extra.chip_mod
            
            if square_count >= 1 then
                add_rental = add_rental or squareJ.ability.rental
                add_eternal = add_eternal or squareJ.ability.eternal
                SMODS.destroy_cards(squareJ, nil, nil, true)
            end
            
            square_count = square_count + 1
        end
    end

    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].ability.name == 'Square Joker' and square_count > 1 then
            local squareJ = G.jokers.cards[i]
            squareJ.ability.extra.chips = scaled_chips
            squareJ.ability.extra.chip_mod = scaling
            if add_eternal and not squareJ.ability.eternal then
                squareJ:set_eternal(true)
            end
            if add_rental and not G.jokers.cards[i].ability.rental then
                squareJ:set_rental(true)
            end
            card_eval_status_text(squareJ, 'extra', nil, nil, nil, {message = "Square up!", colour = G.C.CHIPS})

            break
        end
    end
end



SMODS.Joker:take_ownership('square',
{
    key = "square",
    blueprint_compat = true,
    perishable_compat = false,
    rarity = 1,
    cost = 4,
    pos = { x = 9, y = 11 },
    pixel_size = { h = 71 },
    config = { extra = { chips = 0, chip_mod = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod } }
    end,
    add_to_deck = function(self, card, from_debuff)
        SQUARE_UP()
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint and (#context.full_hand == 4 or next(SMODS.find_card("j_CTEH_square_hole"))) then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
})