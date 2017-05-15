
--
-- Cooking
--

minetest.register_craft(
   {
      type = "cooking",
      output = "default:torch_weak",
      recipe = "default:torch_dead",
      cooktime = 1,
   })

minetest.register_craft(
   {
      type = "cooking",
      output = "default:torch",
      recipe = "default:torch_weak",
      cooktime = 4,
   })

minetest.register_craft(
   {
      type = "cooking",
      output = "default:glass",
      recipe = "default:sand",
      cooktime = 3,
   })

minetest.register_craft(
   {
      type = "cooking",
      output = "default:lump_coal",
      recipe = "default:tree",
      cooktime = 4,
   })

minetest.register_craft(
   {
      type = "cooking",
      output = "default:lump_coal",
      recipe = "default:tree_oak",
      cooktime = 5,
   })

minetest.register_craft(
   {
      type = "cooking",
      output = "default:lump_coal",
      recipe = "default:tree_birch",
      cooktime = 5,
   })

minetest.register_craft(
   {
      type = "cooking",
      output = "default:stone",
      recipe = "default:cobble",
      cooktime = 6,
   })

minetest.register_craft(
   {
      type = "cooking",
      output = "default:ingot_steel",
      recipe = "default:lump_iron",
      cooktime = 3,
   })

minetest.register_craft(
   {
      type = "cooking",
      output = "default:ingot_carbonsteel",
      recipe = "default:dust_carbonsteel",
      cooktime = 5,
   })

minetest.register_craft(
   {
      type = "cooking",
      output = "default:lump_sugar",
      recipe = "default:papyrus",
      cooktime = 7,
   })

--
-- Fuels
--

minetest.register_craft(
   {
      type = "fuel",
      recipe = "group:leaves",
      burntime = 1,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:dry_grass",
      burntime = 1,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:fern",
      burntime = 2,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:papyrus",
      burntime = 2,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:apple",
      burntime = 3,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:ladder",
      burntime = 5,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:rope",
      burntime = 5,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "group:planks",
      burntime = 5,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:torch",
      burntime = 5,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "group:sapling",
      burntime = 7,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:fertilizer",
      burntime = 8,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "group:planks",
      burntime = 9,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:sign",
      burntime = 10,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:cactus",
      burntime = 10,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:fence",
      burntime = 10,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:fence_oak",
      burntime = 11,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:fence_birch",
      burntime = 11,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:planks_oak",
      burntime = 12,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:planks_birch",
      burntime = 12,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:frame",
      burntime = 12,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:reinforced_frame",
      burntime = 17,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "group:tree",
      burntime = 20,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:chest",
      burntime = 24,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:bookshelf",
      burntime = 30,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:lump_coal",
      burntime = 30,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:block_coal",
      burntime = 270,
   })

default.log("crafting", "loaded")
