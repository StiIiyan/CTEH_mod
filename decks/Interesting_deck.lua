SMODS.Atlas{
    key = "d_interesting",
    path = "decks.png",
    px = 71,
    py = 95
}
SMODS.Back {
    key = "interesting_deck",
    atlas = 'd_interesting',
    pos = { x = 5, y = 0 },
    config = { voucher = 'v_CTEH_dividends' },
    loc_txt = {
        name = "Interesting Deck",
        text = {
            'Start with the',
            '{C:cteh_interest}Dividends{} voucher'
        }
    },
    loc_vars = function(self, info_queue, back)
        return {
            vars = { localize { type = 'name_text', key = self.config.voucher, set = 'Voucher' }}
        }
    end,
}