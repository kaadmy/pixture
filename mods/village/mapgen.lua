minetest.register_node(
   "village:entity_spawner",
   {
      description = "Chunk defs may choose which entities to spawn here",
      tiles = {"default_brick.png^default_book.png"},
      is_ground_content = false,
      groups = {dig_immediate = 2},
      sounds = default.node_sound_wood_defaults({})
   })

minetest.register_node(
   "village:grassland_village",
   {
      description = "Spawns a village at this block when placed",
      tiles = {"default_grass.png^default_book.png"},
      is_ground_content = false,
      groups = {dig_immediate = 2},
      sounds = default.node_sound_wood_defaults({})
   })

minetest.register_node(
   "village:desert_village",
   {
      description = "Spawns a village at this block when placed",
      tiles = {"default_sand.png^default_book.png"},
      is_ground_content = false,
      groups = {dig_immediate = 2},
      sounds = default.node_sound_wood_defaults({})
   })

minetest.register_alias("village", "village:grassland_village")

minetest.register_abm(
   {
      nodenames = {"village:grassland_village"},
      interval = 1,
      chance = 1,
      action = function(pos, node)
		  print("Spawning a Grassland village at "..dump(pos))
		  minetest.remove_node(pos)
		  village.spawn_village(pos, PseudoRandom(minetest.get_mapgen_params().seed+pos.x+pos.y+pos.z))
	       end
   })

minetest.register_on_generated(
   function(minp, maxp, seed)
      
   end)