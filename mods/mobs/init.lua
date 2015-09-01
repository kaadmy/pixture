--
-- Mobs mod
-- By PilzAdam, KrupnovPavel, Zeg9, TenPlus1
-- Tweaked by Kaadmy, for Pixture
--

local path = minetest.get_modpath("mobs")

-- Mob Api
dofile(path.."/api.lua")

-- Animals
dofile(path.."/sheep.lua") -- PilzAdam
dofile(path.."/boar.lua") -- KrupnoPavel
dofile(path.."/mineturtle.lua") -- Kaadmy

-- NPC
dofile(path.."/npc.lua") -- TenPlus1

-- Mob Items
dofile(path.."/crafts.lua")

default.log("mod:mobs", "loaded")
