
--
-- Mobs mod
-- By PilzAdam, KrupnovPavel, Zeg9, TenPlus1
-- Tweaked by Kaadmy, for Pixture
--

local path = minetest.get_modpath("mobs")

-- Mob API

dofile(path.."/api.lua")

-- Animals

dofile(path.."/sheep.lua") -- PilzAdam
dofile(path.."/boar.lua") -- KrupnoPavel
dofile(path.."/skunk.lua") -- Kaadmy
dofile(path.."/mineturtle.lua") -- Kaadmy
dofile(path.."/walker.lua") -- Kaadmy

-- NPC

dofile(path.."/npc.lua") -- TenPlus1

-- Mob items and crafts

dofile(path.."/crafts.lua")

-- Achievements

dofile(path.."/achievements.lua")

default.log("mod:mobs", "loaded")
