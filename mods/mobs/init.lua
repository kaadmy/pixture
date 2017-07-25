
--
-- Mobs mod
-- By PilzAdam, KrupnovPavel, Zeg9, TenPlus1
-- Tweaked by KaadmY, for Pixture
--

local path = minetest.get_modpath("mobs")

-- Mob API

dofile(path.."/api.lua")

-- Mob items and crafts

dofile(path.."/crafts.lua")

-- Achievements

dofile(path.."/achievements.lua")

-- Animals

dofile(path.."/mob_sheep.lua") -- PilzAdam
dofile(path.."/mob_boar.lua") -- KrupnoPavel
dofile(path.."/mob_skunk.lua") -- KaadmY
dofile(path.."/mob_mineturtle.lua") -- KaadmY
dofile(path.."/mob_walker.lua") -- KaadmY

-- NPC

dofile(path.."/mob_npc.lua") -- TenPlus1

default.log("mod:mobs", "loaded")
