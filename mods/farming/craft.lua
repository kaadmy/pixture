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

minetest.register_craft(
   {
      output = "farming:flour",
      recipe = {
	 {"farming:wheat", "farming:wheat"},
	 {"farming:wheat", "farming:wheat"},
      }
   })

minetest.register_craft(
   {
      output = "farming:cotton_bale 2",
      recipe = {
	 {"farming:cotton", "farming:cotton"},
	 {"farming:cotton", "farming:cotton"},
      }
   })

minetest.register_craft(
   {
      type = "cooking",
      output = "farming:bread",
      recipe = "farming:flour",
      cooktime = 15,
   })

default.log("craft", "loaded")