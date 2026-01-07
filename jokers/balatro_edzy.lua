-- https://www.youtube.com/watch?v=7kGUYo6V9K8&t=4h8m24s

LAST_SAVED_SCORE = 0

local prev_play_to_discard = G.FUNCS.draw_from_play_to_discard
function G.FUNCS.draw_from_play_to_discard(e)
    prev_play_to_discard(e)
    RETURN_PLAYED_CARDS = false
end

SMODS.Atlas{
    key = "j_edzy",
    path = "balala_edzy.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'edzy',
    loc_txt = {
        name = 'Edzy\'s Special{C:inactive}#1#',
        text = {
            '{C:attention}Once per round{} at end of scoring process',
            '{C:attention}move{} joker to {C:attention}the rightest{}',
            'to {C:red}revert{} the played {C:chips}hand',
            '{C:inactive,s:0.7}A Pair of 7s is not considered a Straight'
        }
    },
    rarity = 3,
    cost = 10,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_edzy',
    pos = {x = 0, y = 0},
    loc_vars = function(self, info_queue, card)
        local text = ""
        if G.GAME and not card.ability.used then text = " (Active)" end
        return {vars = {text}}
    end,
    config = {
        used = false
    },
    
    -- Bosses: Eye, Mouth, Arm, Fish-House-Wheel-Mark, Ox, Hook, Cerulean Bell, debuff behaviour?
    calculate = function(self, card, context)
        if card.states.hover.is then
            card.children.center:set_sprite_pos({x = 1, y = 0})
        else
            card.children.center:set_sprite_pos({x = 0, y = 0})
        end

        if context.blind then
            card.ability.used = false
        end

        if context.after then
            LAST_SAVED_SCORE = G.GAME.chips
        end
    end
}