-- minetest/default/mapgen.lua

--
-- Aliases for map generator outputs
--

minetest.register_alias("mapgen_stone", "default:stone")
minetest.register_alias("mapgen_tree", "default:tree")
minetest.register_alias("mapgen_leaves", "default:leaves")
minetest.register_alias("mapgen_apple", "default:apple")
minetest.register_alias("mapgen_water_source", "default:water_source")
minetest.register_alias("mapgen_river_water_source", "default:water_source")
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
      clust_scarcity = 8*8*8,
      clust_num_ores = 6,
      clust_size     = 4,
      height_min     = -128,
      height_max     = 32,
   })

minetest.register_ore(
   {
      ore_type       = "scatter",
      ore            = "default:stone_with_coal",
      wherein        = "default:stone",
      clust_scarcity = 8*8*8,
      clust_num_ores = 20,
      clust_size     = 10,
      height_min     = -128,
      height_max     = -32,
   })

minetest.register_ore(
   {
      ore_type       = "scatter",
      ore            = "default:stone_with_iron",
      wherein        = "default:stone",
      clust_scarcity = 8*8*8,
      clust_num_ores = 6,
      clust_size     = 4,
      height_min     = -128,
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
      height_min     = -128,
      height_max     = -32,
   })

minetest.register_ore(
   {
      ore_type       = "blob",
      ore            = "default:block_steel",
      wherein        = "default:stone",
      clust_scarcity = 8*8*8,
      clust_num_ores = 10,
      clust_size     = 10,
      height_min     = -128,
      height_max     = -64,
   })

function default.make_papyrus(pos, size)
   for y=0,size-1 do
      local p = {x=pos.x, y=pos.y+y, z=pos.z}
      local nn = minetest.get_node(p).name
      if minetest.registered_nodes[nn] and
	 minetest.registered_nodes[nn].buildable_to then
	 minetest.set_node(p, {name="default:papyrus"})
      else
	 return
      end
   end
end

function default.make_cactus(pos, size)
   for y=0,size-1 do
      local p = {x=pos.x, y=pos.y+y, z=pos.z}
      local nn = minetest.get_node(p).name
      if minetest.registered_nodes[nn] and
	 minetest.registered_nodes[nn].buildable_to then
	 minetest.set_node(p, {name="default:cactus"})
      else
	 return
      end
   end
end

function default.mgv6_ongen(minp, maxp, seed)
   -- Generate cactuses
   local perlin1 = minetest.get_perlin(230, 3, 0.6, 100)
   -- Assume X and Z lengths are equal
   local divlen = 16
   local divs = (maxp.x-minp.x)/divlen+1;
   for divx=0,divs-1 do
      for divz=0,divs-1 do
	 local x0 = minp.x + math.floor((divx+0)*divlen)
	 local z0 = minp.z + math.floor((divz+0)*divlen)
	 local x1 = minp.x + math.floor((divx+1)*divlen)
	 local z1 = minp.z + math.floor((divz+1)*divlen)
	 -- Determine cactus amount from perlin noise
	 local cactus_amount = math.floor(perlin1:get2d({x=x0, y=z0}) * 6 - 3)
	 -- Find random positions for cactus based on this random
	 local pr = PseudoRandom(seed+1)
	 for i=0,cactus_amount do
	    local x = pr:next(x0, x1)
	    local z = pr:next(z0, z1)
	    -- Find ground level (0...15)
	    local ground_y = nil
	    for y=30,0,-1 do
	       if minetest.get_node({x=x,y=y,z=z}).name ~= "air" then
		  ground_y = y
		  break
	       end
	    end
	    if (ground_y and ground_y > 10) and minetest.get_node({x=x,y=ground_y,z=z}).name == "default:sand" then
	       default.make_cactus({x=x,y=ground_y+1,z=z}, pr:next(2, 3))
	    end
	 end
      end
   end

   local pr = PseudoRandom(seed+541)
   for x=minp.x,maxp.x do
      for z=minp.z,maxp.z do
	 local perlin1=((minetest.get_perlin(5123, 3, 0.6, 1):get2d({x=x*0.03, y=z*0.03}) * 0.5) + 0.5)*60
	 if pr:next(0, 15) > perlin1 then
	    local ground_y = nil

	    for y=2,0,-1 do
	       if minetest.get_node({x=x,y=y,z=z}).name ~= "air" then
		  ground_y = y
		  break
	       end
	    end

	    local pos={x=x, y=ground_y, z=z}

	    if (ground_y and ground_y < 20) and minetest.get_node(pos).name == "default:sand" then
	       if minetest.find_node_near(pos, 3, {"group:water"}) then
		  default.make_papyrus({x=pos.x, y=pos.y+1, z=pos.z}, pr:next(1, 3))
	       end
	    end
	 end

	 local perlin2=((minetest.get_perlin(8175, 12, 0.8, 0.7):get2d({x=x*0.025, y=z*0.025}) * 0.5) + 0.5)*1000
	 if pr:next(0, 15) > perlin2 then
	    local ground_y = nil
	    for y=30,0,-1 do
	       if minetest.get_node({x=x,y=y,z=z}).name ~= "air" then
		  ground_y = y
		  break
	       end
	    end
	    if ground_y ~= nil then
	       local p = {x = x, y = ground_y+1, z = z}
	       local nn=minetest.get_node(p).name
	       if minetest.registered_nodes[nn] and
		  minetest.registered_nodes[nn].buildable_to then
		  nn = minetest.get_node({x=x,y=ground_y,z=z}).name
		  if nn == "default:dirt_with_grass" then
		     if pr:next(0, 100) < 1 then
			minetest.set_node(p, {name = "farming:wheat_4"})
		     else
			minetest.set_node(p, {name = "default:grass"})
		     end
		  elseif nn == "default:sand" and pr:next(0, 300) < 1 then
		     minetest.set_node(p, {name = "farming:cotton_4"})
		  end
	       end
	    end
	 end
      end
   end
end

local mg_params = minetest.get_mapgen_params()

if mg_params.mgname == "v6" then
   default.log("please use v5 or v7 mapgen instead; v6 mapgen may not work and is not supported.", "info")
   --   minetest.register_on_generated(default.mgv6_ongen)
end

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
      name = "Desert",
      node_top = "default:sand",	         	depth_top = 3,
      node_filler = "default:sandstone",		depth_filler = 8,
      node_underwater = "default:dirt",
      node_shore_top = "default:sand",
      node_shore_filler = "default:sand",		height_shore = 0,
      y_min = -32000,					y_max = 32000,
      heat_point = 80,				humidity_point = 10,
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
      place_on = "default:sand",
      spawn_by = "default:water_source",
      num_spawn_by = 2,
      sidelen = 16,
      fill_ratio = 0.07,
      biomes = {"Grassland Ocean"},
      decoration = {"default:papyrus"},
      height = 2,
      height_max = 3,
      y_min = 0,
      y_max = 5,
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