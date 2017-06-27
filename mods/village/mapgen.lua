
--
-- Mapgen
--

local spawn_pos = minetest.setting_get_pos("static_spawnpoint") or {x = 0, y = 0, z = 0}
local spawn_radius = minetest.settings:get("static_spawn_radius") or 256

-- Nodes

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
      description = "Village spawner",
      tiles = {"default_grass.png^default_book.png"},
      is_ground_content = false,
      groups = {dig_immediate = 2},
      sounds = default.node_sound_wood_defaults(),

      on_construct = function(pos)
         minetest.remove_node(pos)

         local pr = PseudoRandom(minetest.get_mapgen_params().seed
                                    + pos.x + pos.y + pos.z)

         village.spawn_village(pos, pr)
      end,
})

minetest.register_node(
   "village:grassland_village_mg",
   {
      description = "Mapgen village spawner(Has chance of not spawning village)",
      drawtype = "airlike",
      paramtype = "light",
      sunlight_propagates = true,
      walkable = false,
      pointable = false,
      diggable = false,
      buildable_to = false,
      is_ground_content = true,
      air_equivalent = true,
      drop = "",
      groups = {not_in_craftingguide = 1},
})

-- Spawning LBM

minetest.register_lbm(
   {
      name = "village:spawn_village",
      label = "Village spawning",
      nodenames = {
         "village:grassland_village_mg",
      },

      run_at_every_load = true,

      action = function(pos, node)
         minetest.remove_node(pos)

         if minetest.settings:get_bool("mapgen_disable_villages") == true then
            return
         end

         local pr = PseudoRandom(minetest.get_mapgen_params().seed
                                    + pos.x + pos.y + pos.z)

         if ((minetest.get_mapgen_params().seed + pos.x + pos.y + pos.z) % 30) == 1 then
            local nearest = village.get_nearest_village(pos)

            if nearest.dist > village.min_spawn_dist then
               if vector.distance(spawn_pos, pos) > spawn_radius then
                  minetest.log("Spawning a Grassland village at " .. "(" .. pos.x
                                  .. ", " .. pos.y .. ", " .. pos.z .. ")")

                  minetest.after(
                     2.0,
                     function()
                        village.spawn_village(pos, pr)
                  end)
               else
                  minetest.log("Cannot spawn village, too near the static spawnpoint")
               end
            else
               minetest.log("Cannot spawn village, too near another village")
            end
         end
      end,
})

-- Spawn decoration

if not minetest.settings:get_bool("mapgen_disable_villages") then
   minetest.register_decoration(
      {
         deco_type = "simple",
         place_on = "default:dirt_with_grass",
         sidelen = 16,
         fill_ratio = 0.005,
         biomes = {
            "Grassland",
            "Forest"
         },
         decoration = {
            "village:grassland_village_mg"
         },
         y_min = 1,
         y_max = 1000,
   })
end
