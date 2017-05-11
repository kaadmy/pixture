--
-- Default mod
-- By Kaadmy, for Pixture
--

default = {}

default.SWAMP_WATER_ALPHA = 220
default.SWAMP_WATER_VISC = 4

default.RIVER_WATER_ALPHA = 160
default.RIVER_WATER_VISC = 2

default.WATER_ALPHA = 200
default.WATER_VISC = 1

default.LIGHT_MAX = 14

function default.log(text, type)
   core.log("action", "Pixture ["..type.."] "..text)
end

function default.dumpvec(v)
   return v.x..":"..v.y..":"..v.z
end

core.nodedef_default.stack_max = 60
core.craftitemdef_default.stack_max = 60

function core.nodedef_default.on_receive_fields(pos, form_name, fields, player)
   default.ui.receive_fields(player, form_name, fields)
end

dofile(core.get_modpath("default").."/formspec.lua")
dofile(core.get_modpath("default").."/functions.lua")
dofile(core.get_modpath("default").."/sounds.lua")
dofile(core.get_modpath("default").."/nodes.lua")
dofile(core.get_modpath("default").."/craftitems.lua")
dofile(core.get_modpath("default").."/crafting.lua")
dofile(core.get_modpath("default").."/tools.lua")
dofile(core.get_modpath("default").."/furnace.lua")
dofile(core.get_modpath("default").."/mapgen.lua")
dofile(core.get_modpath("default").."/hud.lua")
dofile(core.get_modpath("default").."/player.lua")
dofile(core.get_modpath("default").."/model.lua")

default.log("mod:default", "loaded")