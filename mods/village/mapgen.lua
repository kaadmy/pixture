minetest.register_node(
   "village:entity_spawner",
   {
      description = "Chunk defs may choose which entities to spawn here",
      tiles = {"default_brick.png^default_book.png"},
      is_ground_content = false,
      groups = {dig_immediate = 2},
      sounds = default.node_sound_wood_defaults()
   })

minetest.register_node(
   "village:grassland_village",
   {
      description = "Spawns a village at this block when placed",
      tiles = {"default_grass.png^default_book.png"},
      is_ground_content = false,
      groups = {dig_immediate = 2},
      sounds = default.node_sound_wood_defaults()
   })

minetest.register_node(
   "village:grassland_village_mg",
   {
      description = "Mapgen village spawner(Has chance of not spawning village)",
      tiles = {"default_grass.png^default_book.png"},
      is_ground_content = false,
      groups = {dig_immediate = 2},
      sounds = default.node_sound_wood_defaults()
   })

minetest.register_abm(
   {
      nodenames = {"village:grassland_village", "village:grassland_village_mg"},
      interval = 1,
      chance = 1,
      action = function(pos, node)
		  minetest.remove_node(pos)
		  local pr = PseudoRandom(minetest.get_mapgen_params().seed+pos.x+pos.y+pos.z)
		  if node.name  == "village:grassland_village_mg" then
		     if pr:next(1, 100) == 1 then
			print("Spawning a (Mapgen)Grassland village at "..dump(pos))
			village.spawn_village(pos, pr)
		     end
		  else
		     print("Spawning a Grassland village at "..dump(pos))
		     village.spawn_village(pos, pr)
		  end
	       end
   })

minetest.register_decoration(
   {
      deco_type = "simple",
      place_on = "default:dirt_with_grass",
      sidelen = 16,
      fill_ratio = 0.005,
      biomes = {"Grassland", "Forest"},
      decoration = {"village:grassland_village_mg"},
      y_min = 1,
      y_max = 1000,
   })