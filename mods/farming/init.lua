
--
-- Farming mod
-- By Kaadmy, for Pixture
--

farming = {}

dofile(minetest.get_modpath("farming").."/api.lua")
dofile(minetest.get_modpath("farming").."/nodes.lua")
dofile(minetest.get_modpath("farming").."/plants.lua")
dofile(minetest.get_modpath("farming").."/craft.lua")
dofile(minetest.get_modpath("farming").."/achievements.lua")

default.log("mod:farming", "loaded")
