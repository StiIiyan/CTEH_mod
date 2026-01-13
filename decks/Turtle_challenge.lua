SMODS.Challenge {
    key = 'turtle',
    jokers = {
        { id = 'j_CTEH_magic_bean', eternal = true, beaned = true }
    },
    rules = {
        custom = {
            { id = 'empty_deck_lose_condition' },
            { id = 'all_magic_beaned' },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'j_juggler' },
            { id = 'j_troubadour' },
            { id = 'j_turtle_bean' },
            { id = 'j_CTEH_bean_juggler' },
        },
        banned_tags = {
            { id = 'tag_juggle' },
        }
    }
}