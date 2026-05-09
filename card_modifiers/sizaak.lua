-- Art by vaga's editor

SMODS.Atlas{
    key = 'sizaak', 
    path = 'sizaak.png', 
    px = 71, 
    py = 95
}

SMODS.Enhancement {
    key = 'sizaak_enh',
    atlas = 'sizaak',
    pos = { x = 0, y = 0 },
    replace_base_card = true,
    shatters = true,
    always_scores = true,
    in_pool = function(self, args)
        return false
    end,
    calculate = function(self, card, context)
        if context.destroy_card and context.cardarea == G.play and context.destroy_card == card then
            card.glass_trigger = true

            local enh_cards = 0
            for _, playing_card in pairs(G.playing_cards or {}) do
                if next(SMODS.get_enhancements(playing_card)) then enh_cards = enh_cards + 1 end
            end
            if JUST_CRASHED and enh_cards == 15 then --15 after removing, TODO carry that functionality outside
                win_game()
            else
                end_round()
            end
            return { remove = true }
        end
    end,
}