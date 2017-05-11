--
-- Lumien mod
-- By Kaadmy, for Pixture
--

local lumien_on_radius = 2
local lumien_off_radius = 4

core.register_node(
   "lumien:crystal_on",
   {
      description = "Lumien Crystal",
      inventory_image = "lumien_crystal.png",
      tiles = {"lumien_block.png"},
      paramtype = "light",
      paramtype2 = "wallmounted",
      drawtype = "nodebox",
	 node_box = {
	    type = "wallmounted",
	    wall_top = {-4/16, 0.5-(4/16), -4/16, 4/16, 0.5, 4/16},
	    wall_side = {-0.5, -4/16, -4/16, -0.5+(4/16), 4/16, 4/16},
	    wall_bottom = {-4/16, -0.5, -4/16, 4/16, -0.5+(4/16), 4/16}
	 },

      groups = {crumbly = 3},
      light_source = 13,
      drop = "lumien:crystal_off",
      sounds = default.node_sound_glass_defaults(),
   })

core.register_node(
   "lumien:crystal_off",
   {
      description = "Lumien Crystal",
      inventory_image = "lumien_crystal.png",
      tiles = {"lumien_block.png"},
      paramtype = "light",
      paramtype2 = "wallmounted",
      drawtype = "nodebox",
	 node_box = {
	    type = "wallmounted",
	    wall_top = {-4/16, 0.5-(4/16), -4/16, 4/16, 0.5, 4/16},
	    wall_side = {-0.5, -4/16, -4/16, -0.5+(4/16), 4/16, 4/16},
	    wall_bottom = {-4/16, -0.5, -4/16, 4/16, -0.5+(4/16), 4/16}
	 },

      groups = {crumbly = 3},
      light_source = 2,
      sounds = default.node_sound_glass_defaults(),
   })

core.register_node(
   "lumien:block",
   {
      description = "Lumien Block",
      tiles = {"lumien_block.png"},
      groups = {cracky = 1, stone = 1},
      light_source = 14,
      sounds = default.node_sound_stone_defaults(),
   })

core.register_node(
   "lumien:ore",
   {
      description = "Lumien Ore",
      tiles = {"default_stone.png^lumien_mineral.png"},
      groups = {cracky = 1, stone = 1},
      drop = "lumien:block",
      sounds = default.node_sound_stone_defaults(),
   })

core.register_craft(
   {
      output = "lumien:crystal_off 9",
      recipe = {"lumien:block"},
      type = "shapeless",
   })

core.register_craft(
   {
      output = "lumien:block",
      recipe = {
	 {"lumien:crystal_off", "lumien:crystal_off", "lumien:crystal_off"},
	 {"lumien:crystal_off", "lumien:crystal_off", "lumien:crystal_off"},
	 {"lumien:crystal_off", "lumien:crystal_off", "lumien:crystal_off"}
      },
   })

core.register_ore(
   {
      ore_type       = "scatter",
      ore            = "lumien:ore",
      wherein        = "default:stone",
      clust_scarcity = 12*12*12,
      clust_num_ores = 10,
      clust_size     = 10,
      y_min     = -256,
      y_max     = -64,
   })

core.register_abm(
   {
      nodenames = {"lumien:crystal_on"},
      interval = 1,
      chance = 1,
      action = function(pos, node)
		  util.nodefunc(
		     {x = pos.x-1, y = pos.y-1, z = pos.z-1},
		     {x = pos.x+1, y = pos.y+1, z = pos.z+1},
		     "tnt:tnt",
		     function(pos)
			tnt.burn(pos)
		     end,
		     true
		  )

		  local ok = true
		  for _,object in ipairs(core.get_objects_inside_radius(pos, lumien_off_radius)) do
		     if object:is_player() then
			ok = false
		     end
		  end

		  if ok then
		     core.set_node(
			pos,
			{
			   name = "lumien:crystal_off",
			   param = node.param,
			   param2 = node.param2
			})
		  end
	       end,
   })

local function step(dtime)
   for _, player in ipairs(core.get_connected_players()) do
      local pos = player:getpos()

      util.nodefunc(
	 {x = pos.x-lumien_on_radius, y = pos.y-lumien_on_radius, z = pos.z-lumien_on_radius},
	 {x = pos.x+lumien_on_radius, y = pos.y+lumien_on_radius, z = pos.z+lumien_on_radius},
	 "lumien:crystal_off",
	 function(pos)
	    local node = core.get_node(pos)

	    core.set_node(
	       pos,
	       {
		  name = "lumien:crystal_on",
		  param = node.param,
		  param2 = node.param2
	       })
	 end,
	 true
      )
   end
end

core.register_globalstep(step)

-- Achievements

achievements.register_achievement(
   "enlightened",
   {
      title = "Enlightened",
      description = "Place 9 lumien crystals.",
      times = 9,
      plcenode = "lumien:lumien_crystal_off",
})

default.log("mod:lumien", "loaded")
