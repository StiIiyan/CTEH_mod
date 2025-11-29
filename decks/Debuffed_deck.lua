SMODS.Atlas{
    key = "d_buffed",
    path = "deck_debuffed.png",
    px = 71,
    py = 95
}
SMODS.Back {
    key = "debuffed_deck",
    atlas = 'd_buffed',
    pos = { x = 0, y = 0 },
    config = { joker_slot = 3, jokers =  { 'j_CTEH_buff_joker' }},
    loc_txt = {
        name = "Debuffed Deck",
        text = {
            "{C:attention}+#1#{} Joker slots",
            "",
            "Begin with an eternal",
            "negative {C:dark_edition}Buff Joker{}"
        }
    },
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.joker_slot } }
    end
}


-- The following function again generates the joker, but the joker modifiers are decided by the deck
-- apply = function(self, back)
--     G.E_MANAGER:add_event(Event({
--         func = function()
--             local card = SMODS.create_card({
--                 set = 'Joker',
--                 area = G.jokers,
--                 key = 'j_CTEH_buff_joker',
--                 edition = "e_negative"
--             })
--             card:set_eternal(true)
--             G.jokers:emplace(card)
--             return true
--         end
--     })
--     )
-- end,