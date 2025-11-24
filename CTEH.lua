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

-- Loading mod icon
SMODS.Atlas({
    key = "modicon",
    path = "icon.png",
    px = 34,
    py = 34
})

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
Balatro Discord: eremel_, _breuhh
]]