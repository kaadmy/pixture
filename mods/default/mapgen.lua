-- minetest/default/mapgen.lua

--
-- Aliases for map generator outputs(Might not be needed with v7, but JIC)
--

minetest.register_alias("mapgen_stone", "default:stone")
minetest.register_alias("mapgen_tree", "default:tree")
minetest.register_alias("mapgen_leaves", "default:leaves")
minetest.register_alias("mapgen_apple", "default:apple")
minetest.register_alias("mapgen_water_source", "default:water_source")
minetest.register_alias("mapgen_river_water_source", "default:river_water_source")
minetest.register_alias("mapgen_dirt", "default:dirt")
minetest.register_alias("mapgen_sand", "default:sand")
minetest.register_alias("mapgen_desert_sand", "default:sand")
minetest.register_alias("mapgen_desert_stone", "default:sandstone")
minetest.register_alias("mapgen_gravel", "default:gravel")
minetest.register_alias("mapgen_cobble", "default:cobble")
minetest.register_alias("mapgen_mossycobble", "default:reinforced_cobble")
minetest.register_alias("mapgen_dirt_with_grass", "default:dirt_with_grass")
minetest.register_alias("mapgen_junglegrass", "default:grass")
minetest.register_alias("mapgen_stone_with_coal", "default:stone_with_coal")
minetest.register_alias("mapgen_stone_with_iron", "default:stone_with_iron")
minetest.register_alias("mapgen_mese", "default:block_steel")
minetest.register_alias("mapgen_stair_cobble", "default:reinforced_frame")
minetest.register_alias("mapgen_lava_source", "default:water_source")

--
-- Ore generation
--

minetest.register_ore(
   {
      ore_type       = "scatter",
      ore            = "default:stone_with_coal",
      wherein        = "default:stone",
      clust_scarcity = 10*10*10,
      clust_num_ores = 6,
      clust_size     = 4,
      height_min     = -31000,
      height_max     = 32,
   })

minetest.register_ore(
   {
      ore_type       = "scatter",
      ore            = "default:stone_with_coal",
      wherein        = "default:stone",
      clust_scarcity = 8*8*8,
      clust_num_ores = 8,
      clust_size     = 6,
      height_min     = -31000,
      height_max     = -32,
   })

minetest.register_ore(
   {
      ore_type       = "scatter",
      ore            = "default:stone_with_coal",
      wherein        = "default:stone",
      clust_scarcity = 9*9*9,
      clust_num_ores = 20,
      clust_size     = 10,
      height_min     = -31000,
      height_max     = -64,
   })

minetest.register_ore(
   {
      ore_type       = "scatter",
      ore            = "default:stone_with_iron",
      wherein        = "default:stone",
      clust_scarcity = 8*8*8,
      clust_num_ores = 6,
      clust_size     = 4,
      height_min     = -31000,
      height_max     = 0,
   })

minetest.register_ore(
   {
      ore_type       = "scatter",
      ore            = "default:stone_with_iron",
      wherein        = "default:stone",
      clust_scarcity = 8*8*8,
      clust_num_ores = 20,
      clust_size     = 10,
      height_min     = -31000,
      height_max     = -32,
   })

minetest.register_ore(
   {
      ore_type       = "blob",
      ore            = "default:block_steel",
      wherein        = "default:stone",
      clust_scarcity = 12*12*12,
      clust_num_ores = 10,
      clust_size     = 10,
      height_min     = -31000,
      height_max     = -128,
   })

--
-- Biome setup
--

minetest.clear_registered_biomes()

-- Biomes

minetest.register_biome(
   {
      name = "Deep Forest",
      node_top = "default:dirt_with_grass",		depth_top = 1,
      node_filler = "default:dirt",			depth_filler = 6,
      node_underwater = "default:dirt",
      node_shore_top = "default:dirt",
      node_shore_filler = "default:dirt",      	height_shore = 0,
      y_min = 10,					y_max = 50,
      heat_point = 30,			        humidity_point = 40,
   })

minetest.register_biome(
   {
      name = "Forest",
      node_top = "default:dirt_with_grass",		depth_top = 1,
      node_filler = "default:dirt",			depth_filler = 6,
      node_underwater = "default:dirt",
      node_shore_top = "default:sand",
      node_shore_filler = "default:sandstone",      	height_shore = 0,
      y_min = 0,					y_max = 200,
      heat_point = 35,			        humidity_point = 40,
   })

minetest.register_biome(
   {
      name = "Grassland Ocean",
      node_top = "default:sand",		depth_top = 3,
      node_filler = "default:dirt",			depth_filler = 1,
      node_underwater = "default:dirt",
      node_shore_top = "default:sand",
      node_shore_filler = "default:sand",      	height_shore = 0,
      y_min = -32000,					y_max = 2,
      heat_point = 50,			        humidity_point = 35,
   })

minetest.register_biome(
   {
      name = "Grassland",
      node_top = "default:dirt_with_grass",		depth_top = 1,
      node_filler = "default:dirt",			depth_filler = 3,
      node_underwater = "default:dirt",
      node_shore_top = "default:sand",
      node_shore_filler = "default:sand",      	height_shore = 0,
      y_min = 3,					y_max = 32000,
      heat_point = 50,			        humidity_point = 35,
   })

minetest.register_biome(
   {
      name = "Savanna",
      node_top = "default:dirt_with_dry_grass",	         	depth_top = 1,
      node_filler = "default:dirt",		depth_filler = 2,
      node_underwater = "default:dirt",
      node_shore_top = "default:sand",
      node_shore_filler = "default:sand",		height_shore = 0,
      y_min = -32000,					y_max = 32000,
      heat_point = 60,				humidity_point = 25,
   })

minetest.register_biome(
   {
      name = "Desert",
      node_top = "default:sand",	         	depth_top = 3,
      node_filler = "default:sandstone",		depth_filler = 8,
      node_underwater = "default:dirt",
      node_shore_top = "default:sand",
      node_shore_filler = "default:sand",		height_shore = 0,
      y_min = 0,					y_max = 32000,
      heat_point = 70,				humidity_point = 20,
   })

-- Decorations

minetest.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_grass"},
      sidelen = 16,
      fill_ratio = 0.005,
      biomes = {"Grassland"},
      flags = "place_center_x, place_center_z",
      schematic = minetest.get_modpath("default").."/schematics/default_tree.mts",
      y_min = -32000,
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
      replacements = {["default:leaves"] = "default:leaves_oak", ["default:tree"] = "default:tree_oak", ["default:apple"] = "air"},
      schematic = minetest.get_modpath("default").."/schematics/default_tree.mts",
      y_min = -32000,
      y_max = 32000,
   })

minetest.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_grass"},
      sidelen = 16,
      fill_ratio = 0.028,
      biomes = {"Deep Forest"},
      flags = "place_center_x, place_center_z",
--      replacements = {["default:leaves"] = "default:leaves_birch", ["default:tree"] = "default:tree_birch"},
      schematic = minetest.get_modpath("default").."/schematics/default_gigatree.mts",
      y_min = -32000,
      y_max = 32000,
   })

minetest.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_grass"},
      sidelen = 16,
      fill_ratio = 0.004,
      biomes = {"Forest"},
      flags = "place_center_x, place_center_z",
      replacements = {["default:leaves"] = "default:leaves_birch", ["default:tree"] = "default:tree_birch", ["default:apple"] = "air"},
      schematic = minetest.get_modpath("default").."/schematics/default_squaretree.mts",
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
      schematic = minetest.get_modpath("default").."/schematics/default_megatree.mts",
      y_min = -32000,
      y_max = 32000,
   })

minetest.register_decoration(
   {
      deco_type = "simple",
      place_on = {"default:sand", "default:dirt", "default:dirt_with_grass"},
      spawn_by = {"default:water_source", "default:water_flowing"},
      num_spawn_by = 1,
      sidelen = 16,
      fill_ratio = 0.08,
      biomes = {"Grassland Ocean", "Grassland", "Forest"},
      decoration = {"default:papyrus"},
      height = 2,
      height_max = 3,
      y_min = 0,
      y_max = 31000,
   })

minetest.register_decoration(
   {
      deco_type = "simple",
      place_on = {"default:sand", "default:dirt", "default:dirt_with_grass"},
      spawn_by = {"default:water_source", "default:water_flowing"},
      num_spawn_by = 1,
      sidelen = 16,
      fill_ratio = 0.22,
      biomes = {"Deep Forest"},
      decoration = {"default:papyrus"},
      height = 2,
      height_max = 3,
      y_min = 0,
      y_max = 31000,
   })

minetest.register_decoration(
   {
      deco_type = "simple",
      place_on = "default:dirt_with_grass",
      sidelen = 16,
      fill_ratio = 0.18,
      biomes = {"Grassland"},
      decoration = {"default:grass"},
      y_min = 0,
      y_max = 32000,
   })

minetest.register_decoration(
   {
      deco_type = "simple",
      place_on = "default:dirt_with_dry_grass",
      sidelen = 16,
      fill_ratio = 0.07,
      biomes = {"Savanna"},
      decoration = {"default:dry_grass"},
      y_min = 0,
      y_max = 50,
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
      biomes = {"Forest"},
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
      fill_ratio = 0.006,
      biomes = {"Grassland"},
      decoration = {"farming:wheat_4"},
      y_min = 0,
      y_max = 32000,
   })

minetest.register_decoration(
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

--[[minetest.register_decoration(
{
   deco_type = "schematic",
   place_on = {"default:dirt_with_grass"},
   noise_params = {
      offset = 0.03,
      scale = 0.03,
      spread = {x = 2000, y = 4000, z = 2000},
      seed = 2442,
      octaves = 1,
      persist = 0.01,
   },
   sidelen = 16,
   fill_ratio = 0.004,
   flags = "place_center_x, place_center_z, force_placement",
   schematic = minetest.get_modpath("default").."/schematics/default_house.mts",
   y_min = 5,
   y_max = 50,

   rotation = "random",
})--]]

minetest.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:sand"},
      sidelen = 16,
      fill_ratio = 0.004,
      biomes = {"Desert"},
      flags = "place_center_x, place_center_z",
      schematic = minetest.get_modpath("default").."/schematics/default_cactus.mts",
      y_min = 5,
      y_max = 32000,
      rotation = "random",
   })

--[[minetest.register_decoration(
{
   deco_type = "simple",
   place_on = "default:sand",
   sidelen = 16,
   fill_ratio = 0.004,
   biomes = {"Desert"},
   decoration = {"default:cactus"},
   height = 2,
   height_max = 3,
   y_min = 5,
   y_max = 32000,
})--]]

default.log("mapgen", "loaded")