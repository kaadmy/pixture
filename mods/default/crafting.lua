--
-- Crafting
--

-- Pickaxes
core.register_craft(
   {
      output = "default:pick_wood",
      recipe = {
	 {"", "group:planks", "default:fiber"},
	 {"", "default:stick", "group:planks"},
	 {"default:stick", "", ""},
      }
   })

core.register_craft(
   {
      output = "default:pick_stone",
      recipe = {
	 {"", "group:stone", "default:fiber"},
	 {"", "default:stick", "group:stone"},
	 {"default:stick", "", ""},
      }
   })

core.register_craft(
   {
      output = "default:pick_steel",
      recipe = {
	 {"", "default:ingot_steel", "default:fiber"},
	 {"", "default:stick", "default:ingot_steel"},
	 {"default:stick", "", ""},
      }
   })

core.register_craft(
   {
      output = "default:pick_carbonsteel",
      recipe = {
	 {"", "default:ingot_carbonsteel", "default:fiber"},
	 {"", "default:stick", "default:ingot_carbonsteel"},
	 {"default:stick", "", ""},
      }
   })

-- Shovels

core.register_craft(
   {
      output = "default:shovel_wood",
      recipe = {
	 {"", "group:planks", "group:planks"},
	 {"", "default:fiber", "group:planks"},
	 {"default:stick", "", ""},
      }
   })

core.register_craft(
   {


      output = "default:shovel_stone",
      recipe = {
	 {"", "group:stone", "group:stone"},
	 {"", "default:fiber", "group:stone"},
	 {"default:stick", "", ""},
      }
   })

core.register_craft(
   {
      output = "default:shovel_steel",
      recipe = {
	 {"", "default:ingot_steel", "default:ingot_steel"},
	 {"", "default:fiber", "default:ingot_steel"},
	 {"default:stick", "", ""},
      }
   })

core.register_craft(
   {
      output = "default:shovel_carbonsteel",
      recipe = {
	 {"", "default:ingot_carbonsteel", "default:ingot_carbonsteel"},
	 {"", "default:fiber", "default:ingot_carbonsteel"},
	 {"default:stick", "", ""},
      }
   })

-- Axes

core.register_craft(
   {
      output = "default:axe_wood",
      recipe = {
	 {"group:planks", "default:fiber"},
	 {"group:planks", "default:stick"},
	 {"", "default:stick"},
      }
   })

core.register_craft(
   {
      output = "default:axe_stone",
      recipe = {
	 {"group:stone", "default:fiber"},
	 {"group:stone", "default:stick"},
	 {"", "default:stick"},
      }
   })

core.register_craft(
   {
      output = "default:axe_steel",
      recipe = {
	 {"default:ingot_steel", "default:fiber"},
	 {"default:ingot_steel", "default:stick"},
	 {"", "default:stick"},
      }
   })

core.register_craft(
   {
      output = "default:axe_carbonsteel",
      recipe = {
	 {"default:ingot_carbonsteel", "default:fiber"},
	 {"default:ingot_carbonsteel", "default:stick"},
	 {"", "default:stick"},
      }
   })

-- Spears

core.register_craft(
   {
      output = "default:spear_wood",
      recipe = {
	 {"", "", "group:planks"},
	 {"", "default:fiber", ""},
	 {"default:stick", "", ""},
      }
   })

core.register_craft(
   {
      output = "default:spear_stone",
      recipe = {
	 {"", "", "group:stone"},
	 {"", "default:fiber", ""},
	 {"default:stick", "", ""},
      }
   })

core.register_craft(
   {
      output = "default:spear_steel",
      recipe = {
	 {"", "", "default:ingot_steel"},
	 {"", "default:fiber", ""},
	 {"default:stick", "", ""},
      }
   })

core.register_craft(
   {
      output = "default:spear_carbonsteel",
      recipe = {
	 {"", "", "default:ingot_carbonsteel"},
	 {"", "default:fiber", ""},
	 {"default:stick", "", ""},
      }
   })

core.register_craft(
   {
      output = "default:shears",
      recipe = {
	 {"default:ingot_steel", ""},
	 {"group:stick", "default:ingot_steel"},
      }
   })

-- Broadsword

core.register_craft(
   {
      output = "default:broadsword",
      recipe = {
	 {"", "", "default:ingot_steel"},
	 {"default:fiber", "default:ingot_steel", ""},
	 {"default:stick", "default:fiber", ""},
      }
   })


-- Nodes/Items

core.register_craft(
   {
      output = "default:dust_carbonsteel",
      type = "shapeless",
      recipe =  {"default:lump_coal", "default:lump_iron", "default:lump_iron"}
   })

core.register_craft(
   {
      output = "default:rope",
      recipe = {
	 {"default:dry_grass"},
	 {"default:dry_grass"},
	 {"default:dry_grass"},
      }
   })

core.register_craft(
   {
      output = "default:fiber",
      type = "shapeless",
      recipe = {
	 "default:grass"
      }
   })

core.register_craft(
   {
      output = "default:fiber 3",
      type = "shapeless",
      recipe = {
	 "group:leaves", "group:leaves", "group:leaves", "group:leaves"
      }
   })

core.register_craft(
   {
      output = "default:gravel",
      recipe = {
	 {"default:cobble"},
      }
   })

core.register_craft(
   {
      output = "default:bucket",
      recipe = {
	 {"default:fiber", "default:stick", "default:fiber"},
	 {"group:planks", "", "group:planks"},
	 {"group:planks", "group:planks", "group:planks"},
      }
   })

core.register_craft(
   {
      output = "default:brick",
      recipe = {
	 {"group:soil", "default:gravel", "group:soil"},
	 {"default:gravel", "group:soil", "default:gravel"},
	 {"group:soil", "default:gravel", "group:soil"},
      }
   })
core.register_craft(
   {
      output = "default:block_steel",
      recipe = {
	 {"default:ingot_steel", "default:ingot_steel", "default:ingot_steel"},
	 {"default:ingot_steel", "default:ingot_steel", "default:ingot_steel"},
	 {"default:ingot_steel", "default:ingot_steel", "default:ingot_steel"},
      }
   })

core.register_craft(
   {
      output = "default:block_coal",
      recipe = {
	 {"default:lump_coal", "default:lump_coal", "default:lump_coal"},
	 {"default:lump_coal", "default:lump_coal", "default:lump_coal"},
	 {"default:lump_coal", "default:lump_coal", "default:lump_coal"},
      }
   })

core.register_craft(
   {
      output = "default:dirt_path 8",
      recipe = {
	 {"group:soil", "group:soil", "group:soil"},
	 {"default:gravel", "default:gravel", "default:gravel"},
	 {"default:gravel", "default:gravel", "default:gravel"},
      }
   })

core.register_craft(
   {
      output = "default:path_slab 3",
      recipe = {
	 {"group:soil_path", "group:soil_path", "group:soil_path"},
      }
   })

core.register_craft(
   {
      output = "default:heated_dirt_path",
      recipe = {
	 {"group:soil_path"},
	 {"default:ingot_steel"},
      }
   })

core.register_craft(
   {
      output = "default:planks 4",
      recipe = {
	 {"default:tree"},
      }
   })

core.register_craft(
   {
      output = "default:planks_oak 4",
      recipe = {
	 {"default:tree_oak"},
      }
   })

core.register_craft(
   {
      output = "default:planks_birch 4",
      recipe = {
	 {"default:tree_birch"},
      }
   })

core.register_craft(
   {
      output = "default:frame",
      recipe = {
	 {"default:fiber", "default:stick", "default:fiber"},
	 {"default:stick", "group:planks", "default:stick"},
	 {"default:fiber", "default:stick", "default:fiber"},
      }
   })

core.register_craft(
   {
      output = "default:reinforced_frame",
      recipe = {
	 {"default:fiber", "default:stick", "default:fiber"},
	 {"default:stick", "default:frame", "default:stick"},
	 {"default:fiber", "default:stick", "default:fiber"},
      }
   })

core.register_craft(
   {
      output = "default:stick 4",
      recipe = {
	 {"group:planks"},
      }
   })

core.register_craft(
   {
      output = "default:fence 4",
      recipe = {
	 {"default:stick", "", "default:stick"},
	 {"default:fiber", "default:planks", "default:fiber"},
	 {"default:stick", "", "default:stick"},
      }
   })

core.register_craft(
   {
      output = "default:fence_oak 4",
      recipe = {
	 {"default:stick", "", "default:stick"},
	 {"default:fiber", "default:planks_oak", "default:fiber"},
	 {"default:stick", "", "default:stick"},
      }
   })

core.register_craft(
   {
      output = "default:fence_birch 4",
      recipe = {
	 {"default:stick", "", "default:stick"},
	 {"default:fiber", "default:planks_birch", "default:fiber"},
	 {"default:stick", "", "default:stick"},
      }
   })

core.register_craft(
   {
      output = "default:sign 2",
      recipe = {
	 {"group:planks", "default:fiber", "group:planks"},
	 {"group:planks", "group:planks", "group:planks"},
	 {"", "default:stick", ""},
      }
   })

core.register_craft(
   {
      output = "default:reinforced_cobble",
      recipe = {
	 {"default:fiber", "default:stick", "default:fiber"},
	 {"default:stick", "default:cobble", "default:stick"},
	 {"default:fiber", "default:stick", "default:fiber"},
      }
   })

core.register_craft(
   {
      output = "default:torch 2",
      recipe = {
	 {"default:lump_coal"},
	 {"default:fiber"},
	 {"default:stick"},
      }
   })

core.register_craft(
   {
      output = "default:torch_weak 2",
      recipe = {
	 {"default:fiber"},
	 {"default:stick"},
      }
   })

core.register_craft(
   {
      output = "default:flint 2",
      type = "shapeless",
      recipe = {"default:gravel"},
   })

core.register_craft(
   {
      output = "default:flint_and_steel",
      recipe = {
	 {"default:ingot_steel", ""},
	 {"default:fiber", "default:flint"},
      },
   })

core.register_craft(
   {
      output = "default:chest",
      recipe = {
	 {"group:planks", "group:planks", "group:planks"},
	 {"group:planks", "default:fiber", "group:planks"},
	 {"group:planks", "group:planks", "group:planks"},
      }
   })

core.register_craft(
   {
      output = "default:chest_locked",
      recipe = {
	 {"default:fiber", "default:stick", "default:fiber"},
	 {"default:stick", "default:chest", "default:stick"},
	 {"default:fiber", "default:ingot_steel", "default:fiber"},
      }
   })

core.register_craft(
   {
      output = "default:furnace",
      recipe = {
	 {"group:stone", "group:stone", "group:stone"},
	 {"group:stone", "", "group:stone"},
	 {"group:stone", "group:stone", "group:stone"},
      }
   })

core.register_craft(
   {
      output = "default:sandstone 2",
      recipe = {
	 {"default:sand", "default:sand"},
	 {"default:sand", "default:sand"},
      }
   })

core.register_craft(
   {
      output = "default:sandstone 2",
      type = "shapeless",
      recipe = {"default:compressed_sandstone"},
   })

core.register_craft(
   {
      output = "default:compressed_sandstone",
      type = "shapeless",
      recipe = {"default:sandstone", "default:sandstone"},
   })

core.register_craft(
   {
      output = "default:paper",
      recipe = {
	 {"default:papyrus", "default:papyrus", "default:papyrus"},
      }
   })

core.register_craft(
   {
      output = "default:book",
      recipe = {
	 {"default:fiber", "default:stick", "default:paper"},
	 {"default:fiber", "default:stick", "default:paper"},
	 {"default:fiber", "default:stick", "default:paper"},
      }
   })

core.register_craft(
   {
      output = "default:bookshelf",
      recipe = {
	 {"group:planks", "group:planks", "group:planks"},
	 {"default:book", "default:book", "default:book"},
	 {"group:planks", "group:planks", "group:planks"},
      }
   })

core.register_craft(
   {
      output = "default:ladder 2",
      recipe = {
	 {"default:stick", "", "default:stick"},
	 {"default:fiber", "default:stick", "default:fiber"},
	 {"default:stick", "", "default:stick"},
      }
   })

core.register_craft(
   {
      output = "default:fertilizer 3",
      recipe = {
	 {"", "default:fiber", ""},
	 {"default:fern", "default:fern", "default:fern"},
	 {"default:fern", "default:fern", "default:fern"},
      },
   })

--
-- Tool repair
--
core.register_craft(
   {
      type = "toolrepair",
      additional_wear = -0.1,
   })

--
-- Cooking
--

core.register_craft(
   {
      type = "cooking",
      output = "default:torch_weak",
      recipe = "default:torch_dead",
      cooktime = 1,
   })

core.register_craft(
   {
      type = "cooking",
      output = "default:torch",
      recipe = "default:torch_weak",
      cooktime = 4,
   })

core.register_craft(
   {
      type = "cooking",
      output = "default:glass",
      recipe = "default:sand",
      cooktime = 3,
   })

core.register_craft(
   {
      type = "cooking",
      output = "default:lump_coal",
      recipe = "default:tree",
      cooktime = 4,
   })

core.register_craft(
   {
      type = "cooking",
      output = "default:lump_coal",
      recipe = "default:tree_oak",
      cooktime = 5,
   })

core.register_craft(
   {
      type = "cooking",
      output = "default:lump_coal",
      recipe = "default:tree_birch",
      cooktime = 5,
   })

core.register_craft(
   {
      type = "cooking",
      output = "default:stone",
      recipe = "default:cobble",
      cooktime = 6,
   })

core.register_craft(
   {
      type = "cooking",
      output = "default:ingot_steel",
      recipe = "default:lump_iron",
      cooktime = 3,
   })

core.register_craft(
   {
      type = "cooking",
      output = "default:ingot_carbonsteel",
      recipe = "default:dust_carbonsteel",
      cooktime = 5,
   })

core.register_craft(
   {
      type = "cooking",
      output = "default:lump_sugar",
      recipe = "default:papyrus",
      cooktime = 7,
   })

--
-- Fuels
--

core.register_craft(
   {
      type = "fuel",
      recipe = "group:leaves",
      burntime = 1,
   })

core.register_craft(
   {
      type = "fuel",
      recipe = "default:dry_grass",
      burntime = 1,
   })

core.register_craft(
   {
      type = "fuel",
      recipe = "default:fern",
      burntime = 2,
   })

core.register_craft(
   {
      type = "fuel",
      recipe = "default:papyrus",
      burntime = 2,
   })

core.register_craft(
   {
      type = "fuel",
      recipe = "default:apple",
      burntime = 3,
   })

core.register_craft(
   {
      type = "fuel",
      recipe = "default:ladder",
      burntime = 5,
   })

core.register_craft(
   {
      type = "fuel",
      recipe = "default:rope",
      burntime = 5,
   })

core.register_craft(
   {
      type = "fuel",
      recipe = "group:planks",
      burntime = 5,
   })

core.register_craft(
   {
      type = "fuel",
      recipe = "default:torch",
      burntime = 5,
   })

core.register_craft(
   {
      type = "fuel",
      recipe = "group:sapling",
      burntime = 7,
   })

core.register_craft(
   {
      type = "fuel",
      recipe = "default:fertilizer",
      burntime = 8,
   })

core.register_craft(
   {
      type = "fuel",
      recipe = "group:planks",
      burntime = 9,
   })

core.register_craft(
   {
      type = "fuel",
      recipe = "default:sign",
      burntime = 10,
   })

core.register_craft(
   {
      type = "fuel",
      recipe = "default:cactus",
      burntime = 10,
   })

core.register_craft(
   {
      type = "fuel",
      recipe = "default:fence",
      burntime = 10,
   })

core.register_craft(
   {
      type = "fuel",
      recipe = "default:fence_oak",
      burntime = 11,
   })

core.register_craft(
   {
      type = "fuel",
      recipe = "default:fence_birch",
      burntime = 11,
   })

core.register_craft(
   {
      type = "fuel",
      recipe = "default:planks_oak",
      burntime = 12,
   })

core.register_craft(
   {
      type = "fuel",
      recipe = "default:planks_birch",
      burntime = 12,
   })

core.register_craft(
   {
      type = "fuel",
      recipe = "default:frame",
      burntime = 12,
   })

core.register_craft(
   {
      type = "fuel",
      recipe = "default:reinforced_frame",
      burntime = 17,
   })

core.register_craft(
   {
      type = "fuel",
      recipe = "group:tree",
      burntime = 20,
   })

core.register_craft(
   {
      type = "fuel",
      recipe = "default:chest",
      burntime = 24,
   })

core.register_craft(
   {
      type = "fuel",
      recipe = "default:bookshelf",
      burntime = 30,
   })

core.register_craft(
   {
      type = "fuel",
      recipe = "default:lump_coal",
      burntime = 30,
   })

core.register_craft(
   {
      type = "fuel",
      recipe = "default:block_coal",
      burntime = 270,
   })

default.log("crafting", "loaded")
