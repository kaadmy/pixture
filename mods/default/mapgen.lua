-- minetest/default/mapgen.lua

--
-- Aliases for map generator outputs(Might not be needed with v7, but JIC)
--

core.register_alias("mapgen_stone", "default:stone")
core.register_alias("mapgen_tree", "default:tree")
core.register_alias("mapgen_leaves", "default:leaves")
core.register_alias("mapgen_apple", "default:apple")
core.register_alias("mapgen_water_source", "default:water_source")
core.register_alias("mapgen_river_water_source", "default:river_water_source")
core.register_alias("mapgen_dirt", "default:dirt")
core.register_alias("mapgen_sand", "default:sand")
core.register_alias("mapgen_desert_sand", "default:sand")
core.register_alias("mapgen_desert_stone", "default:sandstone")
core.register_alias("mapgen_gravel", "default:gravel")
core.register_alias("mapgen_cobble", "default:cobble")
core.register_alias("mapgen_mossycobble", "default:reinforced_cobble")
core.register_alias("mapgen_dirt_with_grass", "default:dirt_with_grass")
core.register_alias("mapgen_junglegrass", "default:grass")
core.register_alias("mapgen_stone_with_coal", "default:stone_with_coal")
core.register_alias("mapgen_stone_with_iron", "default:stone_with_iron")
core.register_alias("mapgen_mese", "default:block_steel")
core.register_alias("mapgen_stair_cobble", "default:reinforced_frame")
core.register_alias("mapgen_lava_source", "default:water_source")

--
-- Biome setup
--

core.clear_registered_biomes()

-- Aboveground biomes

core.register_biome(
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

core.register_biome(
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

core.register_biome(
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

core.register_biome(
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

core.register_biome(
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

core.register_biome(
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

core.register_biome(
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

core.register_biome(
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

core.register_biome(
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

core.register_biome(
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

core.register_biome(
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

core.register_biome(
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

core.register_biome(
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

core.register_biome(
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

core.register_biome(
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

--
-- Decorations
--

-- Trees

core.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_grass"},
      sidelen = 16,
      fill_ratio = 0.004,
      biomes = {"Forest"},
      flags = "place_center_x, place_center_z",
      replacements = {["default:leaves"] = "default:leaves_birch", ["default:tree"] = "default:tree_birch", ["default:apple"] = "air"},
      schematic = core.get_modpath("default").."/schematics/default_squaretree.mts",
      y_min = -32000,
      y_max = 32000,
   })

core.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_grass"},
      sidelen = 16,
      fill_ratio = 0.007,
      biomes = {"Orchard"},
      flags = "place_center_x, place_center_z",
      schematic = core.get_modpath("default").."/schematics/default_tree.mts",
      y_min = 10,
      y_max = 32000,
   })

core.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_grass"},
      sidelen = 16,
      fill_ratio = 0.009,
      biomes = {"Forest", "Deep Forest"},
      flags = "place_center_x, place_center_z",
      replacements = {["default:leaves"] = "default:leaves_oak", ["default:tree"] = "default:tree_oak", ["default:apple"] = "air"},
      schematic = core.get_modpath("default").."/schematics/default_tree.mts",
      y_min = -32000,
      y_max = 32000,
   })

core.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_grass"},
      sidelen = 16,
      fill_ratio = 0.008,
      biomes = {"Forest"},
      flags = "place_center_x, place_center_z",
      schematic = core.get_modpath("default").."/schematics/default_megatree.mts",
      y_min = -32000,
      y_max = 32000,
   })

core.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_grass"},
      sidelen = 16,
      fill_ratio = 0.023,
      biomes = {"Deep Forest"},
      flags = "place_center_x, place_center_z",
      schematic = core.get_modpath("default").."/schematics/default_gigatree.mts",
      y_min = -32000,
      y_max = 32000,
   })

core.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_grass"},
      sidelen = 16,
      fill_ratio = 0.004,
      biomes = {"Wilderness"},
      flags = "place_center_x, place_center_z",
      replacements = {["default:apple"] = "air"},
      schematic = core.get_modpath("default").."/schematics/default_tree.mts",
      y_min = -32000,
      y_max = 32000,
   })

core.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_grass"},
      sidelen = 16,
      fill_ratio = 0.004,
      biomes = {"Wilderness"},
      flags = "place_center_x, place_center_z",
      replacements = {["default:leaves"] = "default:leaves_oak", ["default:tree"] = "default:tree_oak", ["default:apple"] = "air"},
      schematic = core.get_modpath("default").."/schematics/default_tree.mts",
      y_min = -32000,
      y_max = 32000,
   })

core.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_grass"},
      sidelen = 16,
      fill_ratio = 0.004,
      biomes = {"Grove"},
      flags = "place_center_x, place_center_z",
      schematic = core.get_modpath("default").."/schematics/default_talltree.mts",
      y_min = 0,
      y_max = 32000,
   })

-- Papyrus

core.register_decoration(
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

-- Flowers

core.register_decoration(
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

-- Grasses

core.register_decoration(
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

core.register_decoration(
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

core.register_decoration(
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

core.register_decoration(
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

core.register_decoration(
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

core.register_decoration(
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

core.register_decoration(
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

core.register_decoration(
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

-- Thistle

core.register_decoration(
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

-- Ferns

core.register_decoration(
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

-- Farming

if core.get_modpath("farming") ~= nil then
   core.register_decoration(
      {
	 deco_type = "simple",
	 place_on = "default:dirt_with_grass",
	 sidelen = 16,
	 fill_ratio = 0.008,
	 biomes = {"Wilderness"},
	 decoration = {"farming:wheat_4"},
	 y_min = 0,
	 y_max = 32000,
      })

   core.register_decoration(
      {
	 deco_type = "simple",
	 place_on = "default:dirt_with_grass",
	 sidelen = 16,
	 fill_ratio = 0.006,
	 biomes = {"Grassland", "Savanna"},
	 decoration = {"farming:wheat_4"},
	 y_min = 0,
	 y_max = 32000,
      })

   core.register_decoration(
      {
	 deco_type = "simple",
	 place_on = "default:sand",
	 sidelen = 16,
	 fill_ratio = 0.004,
	 biomes = {"Desert"},
	 decoration = {"farming:cotton_4"},
	 y_min = 0,
	 y_max = 32000,
      })
end

-- Cactus

core.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:sand"},
      sidelen = 16,
      fill_ratio = 0.004,
      biomes = {"Desert"},
      flags = "place_center_x, place_center_z",
      schematic = core.get_modpath("default").."/schematics/default_cactus.mts",
      y_min = 10,
      y_max = 500,
      rotation = "random",
   })

-- Shrubs

core.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_dry_grass"},
      sidelen = 16,
      fill_ratio = 0.005,
      biomes = {"Savanna", "Chaparral"},
      flags = "place_center_x, place_center_z",
      replacements = {["default:leaves"] = "default:dry_leaves"},
      schematic = core.get_modpath("default").."/schematics/default_shrub.mts",
      y_min = 3,
      y_max = 32000,
      rotation = "0",
   })

core.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_dry_grass"},
      sidelen = 16,
      fill_ratio = 0.06,
      biomes = {"Chaparral"},
      flags = "place_center_x, place_center_z",
      replacements = {["default:leaves"] = "default:dry_leaves"},
      schematic = core.get_modpath("default").."/schematics/default_bush.mts",
      y_min = -32000,
      y_max = 32000,
      rotation = "0",
   })

core.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_grass"},
      sidelen = 16,
      fill_ratio = 0.004,
      biomes = {"Wilderness", "Grove"},
      flags = "place_center_x, place_center_z",
      schematic = core.get_modpath("default").."/schematics/default_bush.mts",
      y_min = 3,
      y_max = 32000,
      rotation = "0",
   })

-- Rocks

core.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dry_dirt"},
      sidelen = 16,
      fill_ratio = 0.006,
      biomes = {"Wasteland"},
      flags = "place_center_x, place_center_z",
      schematic = core.get_modpath("default").."/schematics/default_small_rock.mts",
      y_min = -32000,
      y_max = 32000,
      rotation = "random",
   })

core.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dry_dirt"},
      sidelen = 16,
      fill_ratio = 0.004,
      biomes = {"Wasteland"},
      flags = "place_center_x, place_center_z",
      schematic = core.get_modpath("default").."/schematics/default_large_rock.mts",
      y_min = -32000,
      y_max = 32000,
      rotation = "random",
   })

-- Clams

core.register_decoration(
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


--
-- Ore generation
--

-- Coal

core.register_ore(
   {
      ore_type       = "scatter",
      ore            = "default:stone_with_coal",
      wherein        = "default:stone",
      clust_scarcity = 10*10*10,
      clust_num_ores = 6,
      clust_size     = 4,
      y_min          = -31000,
      y_max          = 32,
   })

core.register_ore(
   {
      ore_type       = "scatter",
      ore            = "default:stone_with_coal",
      wherein        = "default:stone",
      clust_scarcity = 8*8*8,
      clust_num_ores = 8,
      clust_size     = 6,
      y_min          = -31000,
      y_max          = -32,
   })

core.register_ore(
   {
      ore_type       = "scatter",
      ore            = "default:stone_with_coal",
      wherein        = "default:stone",
      clust_scarcity = 9*9*9,
      clust_num_ores = 20,
      clust_size     = 10,
      y_min          = -31000,
      y_max          = -64,
   })

-- Iron

core.register_ore(
   {
      ore_type       = "scatter",
      ore            = "default:stone_with_iron",
      wherein        = "default:stone",
      clust_scarcity = 8*8*8,
      clust_num_ores = 6,
      clust_size     = 4,
      y_min          = -31000,
      y_max          = 0,
   })

core.register_ore(
   {
      ore_type       = "scatter",
      ore            = "default:stone_with_iron",
      wherein        = "default:stone",
      clust_scarcity = 8*8*8,
      clust_num_ores = 20,
      clust_size     = 10,
      y_min          = -31000,
      y_max          = -32,
   })

-- Steel blocks

core.register_ore(
   {
      ore_type       = "blob",
      ore            = "default:block_steel",
      wherein        = "default:stone",
      clust_scarcity = 12*12*12,
      clust_num_ores = 10,
      clust_size     = 10,
      y_min          = -31000,
      y_max          = -128,
   })

-- Water

core.register_ore( -- Springs
   {
      ore_type       = "blob",
      ore            = "default:water_source",
      wherein        = "default:dirt_with_grass",
      biomes         = {"Grassland"},
      clust_scarcity = 18*18*18,
      clust_num_ores = 1,
      clust_size     = 1,
      y_min          = 20,
      y_max          = 31000,
   })

core.register_ore( -- Pools
   {
      ore_type       = "blob",
      ore            = "default:water_source",
      wherein        = "default:dirt_with_grass",
      biomes         = {"Wilderness"},
      clust_scarcity = 30*30*30,
      clust_num_ores = 20,
      clust_size     = 6,
      y_min          = 10,
      y_max          = 40,
   })

core.register_ore( -- Swamp
   {
      ore_type       = "blob",
      ore            = "default:swamp_water_source",
      wherein        = {"default:dirt_with_swamp_grass", "default:swamp_dirt"},
      biomes         = {"Swamp"},
      clust_scarcity = 10*10*10,
      clust_num_ores = 10,
      clust_size     = 4,
      y_min          = -31000,
      y_max          = 31000,
   })

core.register_ore( -- Marsh
   {
      ore_type       = "blob",
      ore            = "default:swamp_water_source",
      wherein        = {"default:dirt_with_grass", "default:dirt"},
      biomes         = {"Marsh"},
      clust_scarcity = 6*6*6,
      clust_num_ores = 10,
      clust_size     = 6,
      y_min          = -31000,
      y_max          = 31000,
   })

default.log("mapgen", "loaded")