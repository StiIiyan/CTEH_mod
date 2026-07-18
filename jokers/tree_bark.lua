SMODS.Atlas{
    key = "j_tree_bark",
    path = "tree_bark.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'tree_bark',
    loc_txt = {
        name = Fade_Gradient({HEX("473225"),HEX("6A4934"),HEX("D7A77F"),HEX("ADDA8A"),HEX("728665")},'tree_bark','Tree Bark',4,false),
        text = {
            'Gain a {C:attention}Ring{} for every played',
            'hand type this {C:attention}Ante',
            'After end of second Ante',
            'turn into {C:attention}Tree Stump',
            '{C:inactive}(Currently: #1# Rings)',
            '{C:inactive}(#2# antes finished)',
        }
    },
    config = {
        rings = 0,
        antes_ended = 0,
        hands = {
            ["Flush Five"] = false,
            ["Flush House"] = false,
            ["Five of a Kind"] = false,
            ["Straight Flush"] = false,
            ["Four of a Kind"] = false,
            ["Full House"] = false,
            ["Flush"] = false,
            ["Straight"] = false,
            ["Three of a Kind"] = false,
            ["Two Pair"] = false,
            ["Pair"] = false,
            ["High Card"] = false,
        }
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.rings,card.ability.antes_ended}}
    end,
    rarity = 2,
    cost = 6,
    blueprint_compat=false,
    eternal_compat=false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_tree_bark',
    pos = {x = 0, y = 0},
    remove_from_deck = function(self, card, from_debuff)
		card:set_ability("j_CTEH_tree_stump")
    end,
    calculate = function(self, card, context)
        if context.before and card.ability.hands[context.scoring_name] == false then
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "+Ring", colour = G.C.FILTER})
            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
            card.ability.hands[context.scoring_name] = true
            card.ability.rings = card.ability.rings + 1
        end

        if context.ante_change and context.ante_end then
            card.ability.antes_ended = card.ability.antes_ended + 1
            if card.ability.antes_ended == 2 then
                local rings = card.ability.rings
                card:set_ability("j_CTEH_tree_stump")
                card.ability.additional_interest_cap = rings
            end
            card.ability.hands["Flush Five"] = false
            card.ability.hands["Flush House"] = false
            card.ability.hands["Five of a Kind"] = false
            card.ability.hands["Straight Flush"] = false
            card.ability.hands["Four of a Kind"] = false
            card.ability.hands["Full House"] = false
            card.ability.hands["Flush"] = false
            card.ability.hands["Straight"] = false
            card.ability.hands["Three of a Kind"] = false
            card.ability.hands["Two Pair"] = false
            card.ability.hands["Pair"] = false
            card.ability.hands["High Card"] = false
        end
    end  
}