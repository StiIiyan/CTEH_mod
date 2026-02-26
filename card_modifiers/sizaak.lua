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
            -- TODO send wincon signal
            return { remove = true }
        end
    end,
}