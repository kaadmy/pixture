
--
-- Crafts and items
--

-- Items

minetest.register_craftitem(
   "farming:cotton",
   {
      description = "Cotton",
      inventory_image = "farming_cotton.png"
})

minetest.register_craftitem(
   "farming:wheat",
   {
      description = "Wheat",
      inventory_image = "farming_wheat.png"
})

minetest.register_craftitem(
   "farming:flour",
   {
      description = "Flour",
      inventory_image = "farming_flour.png"
})

minetest.register_craftitem(
   "farming:bread",
   {
      description = "Bread",
      inventory_image = "farming_bread.png",
      on_use = minetest.item_eat({hp = 4, sat = 40})
})

-- Craft recipes

crafting.register_craft(
   {
      output = "farming:flour",
      items = {
         "farming:wheat 4",
      }
})

crafting.register_craft(
   {
      output = "farming:cotton_bale 2",
      items = {
         "farming:cotton 2",
      }
})

-- Cooking

minetest.register_craft(
   {
      type = "cooking",
      output = "farming:bread",
      recipe = "farming:flour",
      cooktime = 15,
})

default.log("craft", "loaded")
