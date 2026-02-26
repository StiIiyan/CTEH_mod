-- Make it so multiple instances of Square Joker stack their scaling, scalability and even rental/eternal stickers

function SQUARE_UP()
    local scaled_chips = 0
    local scaling = 0
    local add_stickers = {eternal = false, rental = false, yolky = false, beaned = false, magic_beaned = false}
    local square_count = 0
    local first_square

    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].ability.name == 'Square Joker' then
            local squareJ = G.jokers.cards[i]
            scaled_chips = scaled_chips + squareJ.ability.extra.chips
            scaling = scaling + squareJ.ability.extra.chip_mod
            
            if square_count >= 1 then
                add_stickers.rental = add_stickers.rental or squareJ.ability.rental
                add_stickers.eternal = add_stickers.eternal or squareJ.ability.eternal
                add_stickers.yolky = add_stickers.yolky or squareJ.ability.sticker_yolky
                add_stickers.beaned = add_stickers.beaned or squareJ.ability.sticker_beaned
                add_stickers.magic_beaned = add_stickers.magic_beaned or squareJ.ability.sticker_magic_beaned -- resets the count

                squareJ:set_eternal(false)
                SMODS.destroy_cards(squareJ, nil, nil, true)
                card_eval_status_text(first_square, 'extra', nil, nil, nil, {message = "Square up!", colour = G.C.CHIPS})
            end
            
            if square_count == 0 then first_square = squareJ end
            square_count = square_count + 1
        end
    end

    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].ability.name == 'Square Joker' then
            local squareJ = G.jokers.cards[i]
            squareJ.ability.extra.chips = scaled_chips
            squareJ.ability.extra.chip_mod = scaling
            if add_stickers.eternal and not squareJ.ability.eternal then
                squareJ:set_eternal(true)
            end
            if add_stickers.rental and not G.jokers.cards[i].ability.rental then
                squareJ:set_rental(true)
            end
            if add_stickers.yolky and not G.jokers.cards[i].ability.sticker_yolky then
                squareJ:add_sticker('CTEH_egg', true)
            end
            if add_stickers.beaned and not G.jokers.cards[i].ability.sticker_beaned then
                squareJ:add_sticker('CTEH_bean', true)
            end
            if add_stickers.magic_beaned and not G.jokers.cards[i].ability.sticker_magic_beaned then
                squareJ:add_sticker('CTEH_magic_bean', true)
            end
        end
    end
end

local showman_ref = SMODS.showman
function SMODS.showman(card_key)
	if card_key == 'j_square' and G.GAME.selected_back.effect.center.key == "b_CTEH_square_deck" then return true end
	return showman_ref(card_key)
end

SMODS.Joker:take_ownership('square',
{
    key = "square",
    blueprint_compat = true,
    perishable_compat = false,
    rarity = 1,
    cost = 4,
    pos = { x = 9, y = 11 },
    config = { extra = { chips = 0, chip_mod = 4 }, check_for_squaring_up = false },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod } }
    end,
    calculate = function(self, card, context)
        if not card.ability.check_for_squaring_up then
            card.ability.check_for_squaring_up = true
            SQUARE_UP()
        end

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