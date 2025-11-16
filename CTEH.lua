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
Contributions from
Balatro Discord: eremel_, _breuhh
]]