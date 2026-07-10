SMODS.Atlas{
    key = "j_astrostock",
    path = "astrostock.png",
    px = 71,
    py = 95
}

-- for some reason all these implementations didn't work according to the following comments
-- TODO remove all these comments next commit
SMODS.Joker{
    key = 'astrostock',
    loc_txt = {
        name = Fade_Gradient({HEX("84C5D2"),HEX("899BBA"),HEX("DFF5FC")},'astrostock','Astro Stocks',4,false),
        text = {
            '{C:attention}+1{} Shop Slot if Shop',
            'contains a {C:planet}Planet{} card',
        }
    },
    rarity = 1,
    cost = 8,
    blueprint_compat=false,
    eternal_compat=true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_astrostock',
    pos = {x = 0, y = 0},
    config = {
        shop_slots = 0,
    },
    remove_from_deck = function(self, card, from_debuff)
        change_shop_size(-card.ability.shop_slots) 
        -- essentially when sold removes 0 or 1 slots, depending on whether you've seen a planet this shop or not
    end,
    calculate = function(self, card, context)
        if context.before_reroll or context.ending_shop then
            -- Reset slots before reroll (added new context) so I don't remove already generated cards by the shop
            if card.ability.shop_slots > 0 then 
                -- this 'if' never occurs (essentially shop_slots == 0), but I don't change the param anywhere else; why? idk
                change_shop_size(-card.ability.shop_slots)
                card.ability.shop_slots = 0
            end
            --change_shop_size(-1) -- but this works as intended, so my new context works as intended

        end

        -- have to change starting_shop (doesn't get the job done, shop slots probably load after that check)
        if context.starting_shop or context.reroll_shop then 
            -- Check for planets in rerolled shop
            hasPlanet = false
            for i = 1, #G.shop_jokers.cards do
                if G.shop_jokers.cards[i].ability.set == 'Planet' then
                    card.ability.shop_slots = 1
                    hasPlanet = true
                    break
                end
            end

            -- Add slots if needed
            if hasPlanet then
                change_shop_size(card.ability.shop_slots) -- succeeds in adding slot, so here the param is 1
            end
        end
    end
}
--[[

# Make context right before reroll
[[patches]
[patches.pattern]
target = 'functions/button_callbacks.lua'
pattern = '''
local final_free = G.GAME.current_round.free_rerolls > 0
'''
position = 'before'
payload = '''
for i = 1, #G.jokers.cards do
    G.jokers.cards[i]:calculate_joker({before_reroll = true})
end
'''
match_indent = true

-----------------------------
            G.E_MANAGER:add_event(Event({
                func = function()
                    if #G.shop_jokers.cards == G.GAME.shop.joker_max then
                        -- Check for planets in rerolled shop
                        hasPlanet = false
                        for i = 1, #G.shop_jokers.cards do
                            if G.shop_jokers.cards[i].ability.set == 'Planet' then
                                card.ability.shop_slots = 1
                                hasPlanet = true
                                break
                            end
                        end

                        -- Add slots if needed
                        if hasPlanet then
                            change_shop_size(card.ability.shop_slots) -- succeeds in adding slot, so here the param is 1
                        end
                        return true
                    end
                end
            }))

]]