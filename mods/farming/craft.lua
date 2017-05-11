core.register_craftitem(
   "farming:cotton",
   {
      description = "Cotton",
      inventory_image = "farming_cotton.png"
   })

core.register_craftitem(
   "farming:wheat",
   {
      description = "Wheat",
      inventory_image = "farming_wheat.png"
   })

core.register_craftitem(
   "farming:flour",
   {
      description = "Flour",
      inventory_image = "farming_flour.png"
   })

core.register_craftitem(
   "farming:bread",
   {
      description = "Bread",
      inventory_image = "farming_bread.png",
      on_use = core.item_eat({hp = 4, sat = 40})
   })

core.register_craft(
   {
      output = "farming:flour",
      recipe = {
	 {"farming:wheat", "farming:wheat"},
	 {"farming:wheat", "farming:wheat"},
      }
   })

core.register_craft(
   {
      output = "farming:cotton_bale 2",
      recipe = {
	 {"farming:cotton", "farming:cotton"},
	 {"farming:cotton", "farming:cotton"},
      }
   })

core.register_craft(
   {
      type = "cooking",
      output = "farming:bread",
      recipe = "farming:flour",
      cooktime = 15,
   })

default.log("craft", "loaded")