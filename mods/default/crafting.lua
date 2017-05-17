
--
-- Crafting/creation
--

-- Cooking

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
      recipe = "group:tree",
      cooktime = 4,
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
      output = "default:ingot_wrought_iron",
      recipe = "default:lump_iron",
      cooktime = 3,
})

minetest.register_craft(
   {
      type = "cooking",
      output = "default:ingot_bronze",
      recipe = "default:lump_bronze",
      cooktime = 6,
})

-- Fuels

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
      burntime = 9,
})

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:torch",
      burntime = 7,
})

minetest.register_craft(
   {
      type = "fuel",
      recipe = "group:sapling",
      burntime = 4,
})

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:sign",
      burntime = 6,
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
      recipe = "group:fence",
      burntime = 8,
})

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:frame",
      burntime = 13,
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
      burntime = 22,
})

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:chest",
      burntime = 25,
})

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:bookshelf",
      burntime = 32,
})

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:lump_coal",
      burntime = 20,
})

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:block_coal",
      burntime = 180,
})

default.log("crafting", "loaded")
