--
-- Villages mod
-- By Kaadmy, for Pixture
--

village = {}

village.min_size = 2 -- min chunk gen iterations
village.max_size = 6 -- max chunk gen iterations

village.min_spawn_dist = 256 -- closest distance a village will spawn from another village

village.pr = PseudoRandom(core.get_mapgen_params().seed)

dofile(core.get_modpath("village").."/names.lua")
dofile(core.get_modpath("village").."/generate.lua")
dofile(core.get_modpath("village").."/mapgen.lua")

default.log("mod:village", "loaded")