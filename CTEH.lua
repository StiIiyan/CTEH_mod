local foo_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "functionality")
for _, file in ipairs(foo_src) do
    assert(SMODS.load_file("functionality/" .. file))()
end
local jokers_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "jokers")
for _, file in ipairs(jokers_src) do
    assert(SMODS.load_file("jokers/" .. file))()
end
local decks_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "decks")
for _, file in ipairs(decks_src) do
    assert(SMODS.load_file("decks/" .. file))()
end
local vouchers_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "vouchers")
for _, file in ipairs(vouchers_src) do
    assert(SMODS.load_file("vouchers/" .. file))()
end
local stickers_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "stickers")
for _, file in ipairs(stickers_src) do
    assert(SMODS.load_file("stickers/" .. file))()
end

-- Loading mod icon
SMODS.Atlas({
    key = "modicon",
    path = "icon.png",
    px = 34,
    py = 34
})

--[[
Notes not in the Additions section: 
Planet Tycoon changed (read description), Magick Trick has all enhanced cards, Illusion has 20% for seals
Added Jiggle physics to Burnt Joker, Sixth Sense and Diet Cola (shake it)
Square Jokers now merge into one
Some prices go down with interest rate
Interest rate works with Oracle Deck as of Multiplayer 0.2.20
Not tested if Lucky mirror works when timer
]]

-- blue_eyes_white_joker -> perma gives playing cards retriggerss

-- CURSORS = false

-- -- Load cursor
-- local prev_load = love.load
-- local prev_pressed = love.mousepressed
-- local prev_released = love.mousereleased

-- function love.load()
--     cursor1 = love.mouse.newCursor("assets/2x/cursor.png", 0, 0)
--     cursor2 = love.mouse.newCursor("assets/2x/cursor_hold.png", 0, 0)

--     if cursor1 == nil then 
--         CURSORS = true 
--     else
--         CURSORS = true
--     end

--     love.mouse.setCursor(cursor1)

--     prev_load()

--     love.mouse.setVisible(true)
-- end


-- function love.mousepressed(x, y, button, touch)
--     if button == 1 then
--         love.mouse.setCursor(cursor2)
--     end

--     prev_pressed(x, y, button, touch)

--     love.mouse.setVisible(true)
-- end


-- function love.mousereleased(x, y, button)
--     if button == 1 then
--         love.mouse.setCursor(cursor1)
--     end

--     prev_released(x, y, button)

--     love.mouse.setVisible(true)
-- end








-- Intended BMP compatibilities are not yet compatible

--[[

--start game at:
local function action_start_game(seed, stake_str)
--reset params at:
MP.GAME = {
--enemy info
local spent = MP.GAME.enemy.spent_in_shop[MP.GAME.pincher_index]




--networking/action_handlers.lua
function MP.ACTIONS.custom_foo(param)
	Client.send("action:action_name,param:" .. tostring(param))
end

elseif parsedAction.action == "action_name" then
    server_side_func(parsedAction.custom_param)


]]


-- Glass joker shtuff

--[[]
-- HANGED MAN
local shattered_glass = 0
for k, val in ipairs(G.hand.highlighted) do
    if val.ability.name == 'Glass Card' then shattered_glass = shattered_glass + 1 end
end
if shattered_glass > 0 then
    self.ability.x_mult = self.ability.x_mult + self.ability.extra*shattered_glass
    G.E_MANAGER:add_event(Event({
        func = function() card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_xmult',vars={self.ability.x_mult}}}); return true
        end}))
end
return

-- REMOVE PLAYING CARDS
local glass_cards = 0
for k, val in ipairs(context.removed) do
    if val.shattered then glass_cards = glass_cards + 1 end
end
if glass_cards > 0 then 
    G.E_MANAGER:add_event(Event({
        func = function()
    G.E_MANAGER:add_event(Event({
        func = function()
            self.ability.x_mult = self.ability.x_mult + self.ability.extra*glass_cards
        return true
        end
    }))
    card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_xmult', vars = {self.ability.x_mult + self.ability.extra*glass_cards}}})
    return true
        end
    }))
end
return


local glass_cards = 0
for k, val in ipairs(context.removed) do
    if val.shattered then glass_cards = glass_cards + 1 end
end
if glass_cards > 0 then 
    self.ability.x_mult = self.ability.x_mult + self.ability.extra*glass_cards
    G.E_MANAGER:add_event(Event({
        func = function() card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_xmult', vars = {self.ability.x_mult}}}); return true
        end}))
end
return


]]




--[[
Contributions from
Balatro Discord: eremel_, _breuhh, deathmodereal, metanite64, nh6574
]]