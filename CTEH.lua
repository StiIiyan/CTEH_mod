local foo_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "functionality")
for _, file in ipairs(foo_src) do
    assert(SMODS.load_file("functionality/" .. file))()
end
local jokers_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "jokers")
for _, file in ipairs(jokers_src) do
    assert(SMODS.load_file("jokers/" .. file))()
end
local consumables_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "consumables")
for _, file in ipairs(consumables_src) do
    assert(SMODS.load_file("consumables/" .. file))()
end
local decks_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "decks")
for _, file in ipairs(decks_src) do
    assert(SMODS.load_file("decks/" .. file))()
end
local vouchers_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "vouchers")
for _, file in ipairs(vouchers_src) do
    assert(SMODS.load_file("vouchers/" .. file))()
end
local modifiers_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "card_modifiers")
for _, file in ipairs(modifiers_src) do
    assert(SMODS.load_file("card_modifiers/" .. file))()
end

--[[
Bottom Deck: Challenge, custom wincon: 1 ante
% side note: make custom ante-based wincon (not just custom wincon setting finishing ante to ante 39)

Customize deck (Invert colors of Black Deck)
(55443322) <- //mix up the suits so it's not unnatural, and mix up things so like, not always the same; 




]]

--[[
Contributions from
Balatro Discord: eremel_, _breuhh, deathmodereal, metanite64, nh6574, borb43, evgast, somethingcom515, wingedcatgirl, theonegoofali, aure__, unusedparadox, whitetailani

revoo_. -> some inscryption stuff
]]