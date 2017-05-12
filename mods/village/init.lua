--
-- Villages mod
-- By Kaadmy, for Pixture
--

village = {}

village.min_size = 2 -- min chunk gen iterations
village.max_size = 6 -- max chunk gen iterations

village.min_spawn_dist = 256 -- closest distance a village will spawn from another village

village.pr = PseudoRandom(minetest.get_mapgen_params().seed)

dofile(minetest.get_modpath("village").."/names.lua")
dofile(minetest.get_modpath("village").."/generate.lua")
dofile(minetest.get_modpath("village").."/mapgen.lua")

default.log("mod:village", "loaded")