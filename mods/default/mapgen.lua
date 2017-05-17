
--
-- Mapgen
--

-- Uncomment this to cut a big portion of ground out for visualizing ore spawning

--[[
local function on_generated(minp, maxp, blockseed)
   for x = minp.x, maxp.x do
      if x > 0 then
         return
      end

      for z = minp.z, maxp.z do
         if z > -16 and z < 16 then
            for y = minp.y, maxp.y do
               minetest.remove_node({x = x, y = y, z = z})
            end
         end
      end
   end
end

minetest.register_on_generated(on_generated)
--]]

-- Aliases for map generator outputs
-- v7 still needs them.. sigh..

minetest.register_alias("mapgen_stone", "default:stone")
minetest.register_alias("mapgen_sandstone", "default:sandstone")

minetest.register_alias("mapgen_water_source", "default:water_source")
minetest.register_alias("mapgen_river_water_source", "default:river_water_source")

minetest.register_alias("mapgen_lava_source", "default:water_source")

-- Biome setup

minetest.clear_registered_biomes()

-- Aboveground biomes

minetest.register_biome(
   {
      name = "Marsh",

      node_top = "default:dirt_with_grass",
      node_filler = "default:dirt",

      depth_filler = 0,
      depth_top = 1,

      y_min = 2,
      y_max = 6,

      heat_point = 35,
      humidity_point = 55,
})

minetest.register_biome(
   {
      name = "Swamp",

      node_top = "default:dirt_with_swamp_grass",
      node_filler = "default:swamp_dirt",

      depth_filler = 7,
      depth_top = 1,

      y_min = 2,
      y_max = 7,

      heat_point = 30,
      humidity_point = 42,
})

minetest.register_biome(
   {
      name = "Deep Forest",

      node_top = "default:dirt_with_grass",
      node_filler = "default:dirt",

      depth_filler = 6,
      depth_top = 1,

      y_min = 30,
      y_max = 40,

      heat_point = 33,
      humidity_point = 40,
})

minetest.register_biome(
   {
      name = "Forest",

      node_top = "default:dirt_with_grass",
      node_filler = "default:dirt",

      depth_filler = 6,
      depth_top = 1,

      y_min = 2,
      y_max = 200,

      heat_point = 35,
      humidity_point = 40,
})

minetest.register_biome(
   {
      name = "Grove",

      node_top = "default:dirt_with_grass",
      node_filler = "default:dirt",

      depth_filler = 4,
      depth_top = 1,

      y_min = 3,
      y_max = 32000,

      heat_point = 40,
      humidity_point = 38,
})

minetest.register_biome(
   {
      name = "Wilderness",

      node_top = "default:dirt_with_grass",
      node_filler = "default:dirt",

      depth_filler = 6,
      depth_top = 1,

      y_min = 3,
      y_max = 32000,

      heat_point = 46,
      humidity_point = 35,
})

minetest.register_biome(
   {
      name = "Grassland",

      node_top = "default:dirt_with_grass",
      node_filler = "default:dirt",

      depth_filler = 4,
      depth_top = 1,

      y_min = 3,
      y_max = 20,

      heat_point = 50,
      humidity_point = 33,
})

minetest.register_biome(
   {
      name = "Orchard",

      node_top = "default:dirt_with_grass",
      node_filler = "default:dirt",

      depth_filler = 4,
      depth_top = 1,

      y_min = 21,
      y_max = 32000,

      heat_point = 50,
      humidity_point = 33,
})

minetest.register_biome(
   {
      name = "Chaparral",

      node_top = "default:dirt_with_dry_grass",
      node_filler = "default:dry_dirt",

      depth_filler = 0,
      depth_top = 1,

      y_min = 56,
      y_max = 32000,

      heat_point = 60,
      humidity_point = 30,
})

minetest.register_biome(
   {
      name = "Savanna",

      node_top = "default:dirt_with_dry_grass",
      node_filler = "default:dry_dirt",

      depth_filler = 2,
      depth_top = 1,

      y_min = 1,
      y_max = 55,

      heat_point = 60,
      humidity_point = 25,
})

minetest.register_biome(
   {
      name = "Desert",

      node_top = "default:sand",
      node_filler = "default:sandstone",

      depth_filler = 8,
      depth_top = 3,

      y_min = 1,
      y_max = 32000,

      heat_point = 75,
      humidity_point = 20,
})

minetest.register_biome(
   {
      name = "Wasteland",

      node_top = "default:dry_dirt",
      node_filler = "default:sandstone",

      depth_filler = 3,
      depth_top = 1,

      y_min = -32000,
      y_max = 32000,

      heat_point = 80,
      humidity_point = 20,
})

-- Oceans

minetest.register_biome(
   {
      name = "Grassland Ocean",

      node_top = "default:sand",
      node_filler = "default:dirt",

      depth_filler = 1,
      depth_top = 3,

      y_min = -32000,
      y_max = 2,

      heat_point = 50,
      humidity_point = 35,
})

minetest.register_biome(
   {
      name = "Gravel Beach",

      node_top = "default:gravel",
      node_filler = "default:sand",

      depth_filler = 2,
      depth_top = 1,

      y_min = -5,
      y_max = 1,

      heat_point = 59,
      humidity_point = 31,
})

minetest.register_biome(
   {
      name = "Savanna Ocean",

      node_top = "default:dirt",
      node_filler = "dfault:dirt",

      depth_filler = 0,
      depth_top = 1,

      y_min = -32000,
      y_max = 0,

      heat_point = 60,
      humidity_point = 30,
})

-- Tree decorations

minetest.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_grass"},
      sidelen = 16,
      fill_ratio = 0.004,
      biomes = {"Forest"},
      flags = "place_center_x, place_center_z",
      replacements = {
         ["default:leaves"] = "default:leaves_birch",
         ["default:tree"] = "default:tree_birch",
         ["default:apple"] = "air"
      },
      schematic = minetest.get_modpath("default")
         .. "/schematics/default_squaretree.mts",
      y_min = -32000,
      y_max = 32000,
})

minetest.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_grass"},
      sidelen = 16,
      fill_ratio = 0.007,
      biomes = {"Orchard"},
      flags = "place_center_x, place_center_z",
      schematic = minetest.get_modpath("default")
         .. "/schematics/default_tree.mts",
      y_min = 10,
      y_max = 32000,
})

minetest.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_grass"},
      sidelen = 16,
      fill_ratio = 0.009,
      biomes = {"Forest", "Deep Forest"},
      flags = "place_center_x, place_center_z",
      replacements = {
         ["default:leaves"] = "default:leaves_oak",
         ["default:tree"] = "default:tree_oak",
         ["default:apple"] = "air",
      },
      schematic = minetest.get_modpath("default")
         .. "/schematics/default_tree.mts",
      y_min = -32000,
      y_max = 32000,
})

minetest.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_grass"},
      sidelen = 16,
      fill_ratio = 0.008,
      biomes = {"Forest"},
      flags = "place_center_x, place_center_z",
      schematic = minetest.get_modpath("default")
         .. "/schematics/default_megatree.mts",
      y_min = -32000,
      y_max = 32000,
})

minetest.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_grass"},
      sidelen = 16,
      fill_ratio = 0.023,
      biomes = {"Deep Forest"},
      flags = "place_center_x, place_center_z",
      schematic = minetest.get_modpath("default")
         .. "/schematics/default_gigatree.mts",
      y_min = -32000,
      y_max = 32000,
})

minetest.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_grass"},
      sidelen = 16,
      fill_ratio = 0.004,
      biomes = {"Wilderness"},
      flags = "place_center_x, place_center_z",
      replacements = {
         ["default:apple"] = "air",
      },
      schematic = minetest.get_modpath("default")
         .. "/schematics/default_tree.mts",
      y_min = -32000,
      y_max = 32000,
})

minetest.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_grass"},
      sidelen = 16,
      fill_ratio = 0.004,
      biomes = {"Wilderness"},
      flags = "place_center_x, place_center_z",
      replacements = {
         ["default:leaves"] = "default:leaves_oak",
         ["default:tree"] = "default:tree_oak",
         ["default:apple"] = "air",
      },
      schematic = minetest.get_modpath("default")
         .. "/schematics/default_tree.mts",
      y_min = -32000,
      y_max = 32000,
})

minetest.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_grass"},
      sidelen = 16,
      fill_ratio = 0.004,
      biomes = {"Grove"},
      flags = "place_center_x, place_center_z",
      schematic = minetest.get_modpath("default")
         .. "/schematics/default_talltree.mts",
      y_min = 0,
      y_max = 32000,
})

-- Papyrus decorations

minetest.register_decoration(
   {
      deco_type = "simple",
      place_on = {"default:sand", "default:dirt", "default:dirt_with_grass"},
      spawn_by = {"default:water_source", "default:water_flowing"},
      num_spawn_by = 1,
      sidelen = 16,
      fill_ratio = 0.08,
      biomes = {"Grassland Ocean", "Grassland", "Forest", "Deep Forest", "Wilderness"},
      decoration = {"default:papyrus"},
      height = 2,
      y_max = 3,
      y_min = 0,
})

-- Flower decorations

minetest.register_decoration(
   {
      deco_type = "simple",
      place_on = "default:dirt_with_grass",
      sidelen = 16,
      fill_ratio = 0.04,
      biomes = {"Grassland", "Wilderness", "Orchard"},
      decoration = {"default:flower"},
      y_min = -32000,
      y_max = 32000,
})

-- Grass decorations

minetest.register_decoration(
   {
      deco_type = "simple",
      place_on = "default:dirt_with_grass",
      sidelen = 16,
      fill_ratio = 0.18,
      biomes = {"Grassland", "Orchard"},
      decoration = {"default:grass"},
      y_min = 10,
      y_max = 32000,
})

minetest.register_decoration(
   {
      deco_type = "simple",
      place_on = "default:dirt_with_swamp_grass",
      sidelen = 16,
      fill_ratio = 0.04,
      biomes = {"Swamp"},
      decoration = {"default:swamp_grass"},
      y_min = 2,
      y_max = 40,
})

minetest.register_decoration(
   {
      deco_type = "simple",
      place_on = "default:dirt_with_dry_grass",
      sidelen = 16,
      fill_ratio = 0.07,
      biomes = {"Desert", "Savanna", "Chaparral"},
      decoration = {"default:dry_grass"},
      y_min = 10,
      y_max = 500,
})

minetest.register_decoration(
   {
      deco_type = "simple",
      place_on = "default:dirt_with_grass",
      sidelen = 16,
      fill_ratio = 0.08,
      biomes = {"Forest", "Deep Forest"},
      decoration = {"default:grass"},
      y_min = 0,
      y_max = 32000,
})

minetest.register_decoration(
   {
      deco_type = "simple",
      place_on = "default:dirt_with_grass",
      sidelen = 16,
      fill_ratio = 0.08,
      biomes = {"Forest", "Marsh", "Grove"},
      decoration = {"default:tall_grass"},
      y_min = 0,
      y_max = 32000,
})

minetest.register_decoration(
   {
      deco_type = "simple",
      place_on = "default:dirt_with_grass",
      sidelen = 16,
      fill_ratio = 0.15,
      biomes = {"Deep Forest"},
      decoration = {"default:tall_grass"},
      y_min = 0,
      y_max = 32000,
})

minetest.register_decoration(
   {
      deco_type = "simple",
      place_on = "default:dirt_with_grass",
      sidelen = 16,
      fill_ratio = 0.16,
      biomes = {"Wilderness"},
      decoration = {"default:grass"},
      y_min = -32000,
      y_max = 32000,
})

minetest.register_decoration(
   {
      deco_type = "simple",
      place_on = "default:dirt_with_grass",
      sidelen = 16,
      fill_ratio = 0.12,
      biomes = {"Wilderness"},
      decoration = {"default:tall_grass"},
      y_min = -32000,
      y_max = 32000,
})

-- Thistle decorations

minetest.register_decoration(
   {
      deco_type = "simple",
      place_on = "default:dirt_with_grass",
      sidelen = 16,
      fill_ratio = 0.024,
      biomes = {"Wilderness"},
      decoration = {"default:thistle"},
      height = 2,
      y_min = -32000,
      y_max = 32000,
})

-- Fern decorations

minetest.register_decoration(
   {
      deco_type = "simple",
      place_on = "default:dirt_with_grass",
      sidelen = 16,
      fill_ratio = 0.02,
      biomes = {"Wilderness", "Grove"},
      decoration = {"default:fern"},
      y_min = -32000,
      y_max = 32000,
})

-- Cactus decorations

minetest.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:sand"},
      sidelen = 16,
      fill_ratio = 0.004,
      biomes = {"Desert"},
      flags = "place_center_x, place_center_z",
      schematic = minetest.get_modpath("default") .. "/schematics/default_cactus.mts",
      y_min = 10,
      y_max = 500,
      rotation = "random",
})

-- Shrub decorations

minetest.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_dry_grass"},
      sidelen = 16,
      fill_ratio = 0.005,
      biomes = {"Savanna", "Chaparral"},
      flags = "place_center_x, place_center_z",
      replacements = {["default:leaves"] = "default:dry_leaves"},
      schematic = minetest.get_modpath("default") .. "/schematics/default_shrub.mts",
      y_min = 3,
      y_max = 32000,
      rotation = "0",
})

minetest.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_dry_grass"},
      sidelen = 16,
      fill_ratio = 0.06,
      biomes = {"Chaparral"},
      flags = "place_center_x, place_center_z",
      replacements = {["default:leaves"] = "default:dry_leaves"},
      schematic = minetest.get_modpath("default") .. "/schematics/default_bush.mts",
      y_min = -32000,
      y_max = 32000,
      rotation = "0",
})

minetest.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_grass"},
      sidelen = 16,
      fill_ratio = 0.004,
      biomes = {"Wilderness", "Grove"},
      flags = "place_center_x, place_center_z",
      schematic = minetest.get_modpath("default") .. "/schematics/default_bush.mts",
      y_min = 3,
      y_max = 32000,
      rotation = "0",
})

-- Rock decorations

minetest.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dry_dirt"},
      sidelen = 16,
      fill_ratio = 0.006,
      biomes = {"Wasteland"},
      flags = "place_center_x, place_center_z",
      schematic = minetest.get_modpath("default")
         .. "/schematics/default_small_rock.mts",
      y_min = -32000,
      y_max = 32000,
      rotation = "random",
})

minetest.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dry_dirt"},
      sidelen = 16,
      fill_ratio = 0.004,
      biomes = {"Wasteland"},
      flags = "place_center_x, place_center_z",
      schematic = minetest.get_modpath("default")
         .. "/schematics/default_large_rock.mts",
      y_min = -32000,
      y_max = 32000,
      rotation = "random",
})

-- Clam decorations

minetest.register_decoration(
   {
      deco_type = "simple",
      place_on = {"default:sand", "default:gravel"},
      sidelen = 16,
      fill_ratio = 0.02,
      biomes = {"Grassland Ocean", "Gravel Beach"},
      decoration = {"default:clam"},
      y_min = 0,
      y_max = 1,
})


-- Coal ore

minetest.register_ore( -- Even distribution
   {
      ore_type       = "scatter",
      ore            = "default:stone_with_coal",
      wherein        = "default:stone",
      clust_scarcity = 10*10*10,
      clust_num_ores = 8,
      clust_size     = 4,
      y_min          = -31000,
      y_max          = 32,
})

minetest.register_ore( -- Dense sheet
   {
      ore_type       = "scatter",
      ore            = "default:stone_with_coal",
      wherein        = "default:stone",
      clust_scarcity = 7*7*7,
      clust_num_ores = 10,
      clust_size     = 8,
      y_min          = -40,
      y_max          = -32,
})

minetest.register_ore( -- Deep ore sheet
   {
      ore_type       = "scatter",
      ore            = "default:stone_with_coal",
      wherein        = "default:stone",
      clust_scarcity = 6*6*6,
      clust_num_ores = 26,
      clust_size     = 12,
      y_min          = -130,
      y_max          = -120,
})

-- Iron ore

minetest.register_ore( -- Even distribution
   {
      ore_type       = "scatter",
      ore            = "default:stone_with_iron",
      wherein        = "default:stone",
      clust_scarcity = 12*12*12,
      clust_num_ores = 4,
      clust_size     = 3,
      y_min          = -31000,
      y_max          = -8,
})

minetest.register_ore( -- Dense sheet
   {
      ore_type       = "scatter",
      ore            = "default:stone_with_iron",
      wherein        = "default:stone",
      clust_scarcity = 8*8*8,
      clust_num_ores = 20,
      clust_size     = 12,
      y_min          = -32,
      y_max          = -24,
})

minetest.register_ore( -- Dense sheet
   {
      ore_type       = "scatter",
      ore            = "default:stone_with_iron",
      wherein        = "default:stone",
      clust_scarcity = 7*7*7,
      clust_num_ores = 17,
      clust_size     = 6,
      y_min          = -80,
      y_max          = -60,
})

-- Tin ore

minetest.register_ore( -- Even distribution
   {
      ore_type       = "scatter",
      ore            = "default:stone_with_tin",
      wherein        = "default:stone",
      clust_scarcity = 14*14*14,
      clust_num_ores = 8,
      clust_size     = 4,
      y_min          = -31000,
      y_max          = -100,
})

minetest.register_ore( -- Dense sheet
   {
      ore_type       = "scatter",
      ore            = "default:stone_with_tin",
      wherein        = "default:stone",
      clust_scarcity = 7*7*7,
      clust_num_ores = 10,
      clust_size     = 6,
      y_min          = -150,
      y_max          = -140,
})

-- Copper ore

minetest.register_ore( -- Begin sheet
   {
      ore_type       = "scatter",
      ore            = "default:stone_with_copper",
      wherein        = "default:stone",
      clust_scarcity = 6*6*6,
      clust_num_ores = 12,
      clust_size     = 5,
      y_min          = -90,
      y_max          = -80,
})

minetest.register_ore( -- Rare even distribution
   {
      ore_type       = "scatter",
      ore            = "default:stone_with_copper",
      wherein        = "default:stone",
      clust_scarcity = 13*13*13,
      clust_num_ores = 10,
      clust_size     = 5,
      y_min          = -31000,
      y_max          = -90,
})

minetest.register_ore( -- Large clusters
   {
      ore_type       = "scatter",
      ore            = "default:stone_with_copper",
      wherein        = "default:stone",
      clust_scarcity = 8*8*8,
      clust_num_ores = 22,
      clust_size     = 10,
      y_min          = -230,
      y_max          = -180,
})

-- Water

minetest.register_ore( -- Springs
   {
      ore_type       = "blob",
      ore            = "default:water_source",
      wherein        = "default:dirt_with_grass",
      biomes         = {"Grassland"},
      clust_scarcity = 26*26*26,
      clust_num_ores = 1,
      clust_size     = 1,
      y_min          = 20,
      y_max          = 31000,
})

minetest.register_ore( -- Pools
   {
      ore_type       = "blob",
      ore            = "default:water_source",
      wherein        = "default:dirt_with_grass",
      biomes         = {"Wilderness"},
      clust_scarcity = 32*32*32,
      clust_num_ores = 20,
      clust_size     = 6,
      y_min          = 10,
      y_max          = 30,
})

minetest.register_ore( -- Swamp
   {
      ore_type       = "blob",
      ore            = "default:swamp_water_source",
      wherein        = {"default:dirt_with_swamp_grass", "default:swamp_dirt"},
      biomes         = {"Swamp"},
      clust_scarcity = 14*14*14,
      clust_num_ores = 10,
      clust_size     = 4,
      y_min          = -31000,
      y_max          = 31000,
})

minetest.register_ore( -- Marsh
   {
      ore_type       = "blob",
      ore            = "default:swamp_water_source",
      wherein        = {"default:dirt_with_grass", "default:dirt"},
      biomes         = {"Marsh"},
      clust_scarcity = 8*8*8,
      clust_num_ores = 10,
      clust_size     = 6,
      y_min          = -31000,
      y_max          = 31000,
})

default.log("mapgen", "loaded")
