G.hypr = {}

assert(SMODS.load_file("modules/assets.lua"))()
assert(SMODS.load_file("modules/utils.lua"))()
assert(SMODS.load_file("modules/jokers.lua"))()
assert(SMODS.load_file("modules/challenges.lua"))()
assert(SMODS.load_file("modules/decks.lua"))()
--assert(SMODS.load_file("modules/hooks.lua"))()

SMODS.Atlas {
key = "modicon",
path = "hypr_icon.png",
px = 32,
py = 32
}