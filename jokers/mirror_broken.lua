SMODS.Atlas{
    key = "j_broken_mirror",
    path = "broken_mirror.png",
    px = 71,
    py = 95
}

-- broken mirror currently don't work
BROKEN_BROKEN_MIRROR = true

SMODS.Joker{
    key = 'broken_mirror',
    loc_txt = {
        name = 'Broken mirror',
        text = {
            '{X:purple,C:white}Nemesis\'{} probability denominator',
            'increases by {C:attention}1',
            '{C:inactive}(ex: {C:green}1 in 2 {C:inactive}-> {C:green}1 in 3{C:inactive})'
        }
    },
	loc_vars = function(self, info_queue, card)
		if loaded_BMP() then 
            MP.UTILS.add_nemesis_info(info_queue) 
        end
		return { vars = {} }
	end,
    rarity = 2,
    cost = 6,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_broken_mirror',
    pos = {x = 0, y = 0},
    in_pool = function(self, args)
        return false
    end,

    add_to_deck = function(self, card, from_debuff)
        --TODO link multi_player to actual parameter when I finish with the probability expansion
		if playing_multiplayer() and not from_debuffed and (not card.edition or card.edition.type ~= "mp_phantom") then
            MP.GAME.multi_player:increase_denominator_value_nemesis(1)
			MP.ACTIONS.send_phantom("j_CTEH_broken_mirror")
		end
    end,
    remove_from_deck = function(self, card, from_debuff)
		if playing_multiplayer() and not from_debuff and (not card.edition or card.edition.type ~= "mp_phantom") then
            MP.GAME.multi_player:increase_denominator_value_nemesis(-1)
			MP.ACTIONS.remove_phantom("j_CTEH_broken_mirror")
		end
    end
}