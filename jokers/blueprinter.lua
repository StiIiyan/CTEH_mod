SMODS.Atlas{
    key = "j_blue_printer",
    path = "blue_printer.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'blue_printer',
    loc_txt = {
        name = '#12#',
        text = {
            "#1#{C:attention}#2#{}#3#",
            "#4#{C:attention}#5#",
            "{C:green}#13##6##14#{}#7#",
            "#8#{C:attention}#9#",
            "#10#",
            "{C:warning_text}#11#",
        },
    },
    rarity = 1,
    cost = 4,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_blue_printer',
    pos = {x = 1, y = 0},
    config = {
        numerator_value = 0,
        odds = 1000
    },
    in_pool = function(self, args)
        return false
    end,
    loc_vars = function(self, info_queue, card)
        local in_game = G.jokers
        local in_joker_slots = false
        if in_game then
            for i=1,#G.jokers.cards do
                in_joker_slots = in_joker_slots or G.jokers.cards[i] == card
            end
        end
        local name = ""
        local rows = {[1] = "When", [2] = " Blind",[3]=" is selected",
                      [4] = "create a ",[5]="Misprint",
                      [6] = " in ", [7] = " to instead",
                      [8] = "turn into ", [9] = "Blueprint",
                      [10] = "Set odds to previous round's last Misprint trigger",
                      [11] = "Joker will appear as Misprint in Shop"}
        
                      local numerator, denominator =
                      SMODS.get_probability_vars(card, card.ability.numerator_value, card.ability.odds)
                      
        if not in_game then
            card.children.center:set_sprite_pos({x = 0, y = 0})
            name = "Blue Printer"
                return { vars = {rows[1],rows[2],rows[3],rows[4],rows[5],rows[6],rows[7],rows[8],rows[9],rows[10],rows[11],name,numerator,denominator} }
        else
            if not in_joker_slots then
                card.children.center:set_sprite_pos({x = 1, y = 0})
                name = "Misprint"
                -- begins logic misprint from vanilla remade
                local r_mults = {}
                for i = 0, 23 do
                    r_mults[#r_mults + 1] = tostring(i)
                end
                local loc_mult = ' ' .. (localize('k_mult')) .. ' '
                main_start = {
                    { n = G.UIT.T, config = { text = '  +', colour = G.C.MULT, scale = 0.32 } },
                    { n = G.UIT.O, config = { object = DynaText({ string = r_mults, colours = { G.C.RED }, pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.5, scale = 0.32, min_cycle_time = 0 }) } },
                    {
                        n = G.UIT.O,
                        config = {
                            object = DynaText({
                                string = {
                                    { string = 'rand()', colour = G.C.JOKER_GREY }, { string = "#@" .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.id or 11) .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.suit:sub(1, 1) or 'D'), colour = G.C.RED },
                                    loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult,
                                    loc_mult, loc_mult, loc_mult, loc_mult },
                                colours = { G.C.UI.TEXT_DARK },
                                pop_in_rate = 9999999,
                                silent = true,
                                random_element = true,
                                pop_delay = 0.2011,
                                scale = 0.32,
                                min_cycle_time = 0
                            })
                        }
                    },
                }                
                -- ends logic misprint from vanilla remade
                return { main_start = main_start, vars = {name} }
            else
                card.children.center:set_sprite_pos({x = 0, y = 0})
                name = "Blue Printer"
                return { vars = {rows[1],rows[2],rows[3],rows[4],rows[5],rows[6],rows[7],rows[8],rows[9],rows[10],"",name,numerator,denominator} }
            end
        end
    end,
    
    calculate = function(self, card, context)

    end
}