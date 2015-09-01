minetest.register_node(
   "farming:wheat_1",
   {
      description = "Wheat Seed",
      drawtype = "plantlike",
      tiles = {"farming_wheat_1.png"},
      inventory_image = "farming_wheat_4.png",
      paramtype = "light",
      waving = 1,
      walkable = false,
      buildable_to = true,
      is_ground_content = true,
      drop = {
	 items = {
	    {items = {"farming:wheat"}, rarity = 3}
	 }
      },
      selection_box = {
	 type = "fixed",
	 fixed = {-0.5, -0.5, -0.5, 0.5, -0.5+(4/16), 0.5}
      },
      groups = {dig_immediate=2},
      sounds=default.node_sound_leaves_defaults()
   })

minetest.register_node(
   "farming:wheat_2",
   {
      description = "Wheat",
      drawtype = "plantlike",
      tiles = {"farming_wheat_2.png"},
      paramtype = "light",
      waving = 1,
      walkable = false,
      buildable_to = true,
      is_ground_content = true,
      drop = {
	 items = {
	    {items = {"farming:wheat"}, rarity = 2}
	 }
      },
      selection_box = {
	 type = "fixed",
	 fixed = {-0.5, -0.5, -0.5, 0.5, -0.5+(4/16), 0.5}
      },
      groups = {dig_immediate=2, not_in_craftingguide = 1},
      sounds=default.node_sound_leaves_defaults()
   })

minetest.register_node(
   "farming:wheat_3",
   {
      description = "Wheat",
      drawtype = "plantlike",
      tiles = {"farming_wheat_3.png"},
      paramtype = "light",
      waving = 1,
      walkable = false,
      buildable_to = true,
      is_ground_content = true,
      drop = {
	 items = {
	    {items = {"farming:wheat"}, rarity = 1}
	 }
      },
      selection_box = {
	 type = "fixed",
	 fixed = {-0.5, -0.5, -0.5, 0.5, -0.5+(4/16), 0.5}
      },
      groups = {dig_immediate=2, not_in_craftingguide = 1},
      sounds=default.node_sound_leaves_defaults()
   })

minetest.register_node(
   "farming:wheat_4",
   {
      description = "Wheat",
      drawtype = "plantlike",
      tiles = {"farming_wheat_4.png"},
      paramtype = "light",
      waving = 1,
      walkable = false,
      buildable_to = true,
      is_ground_content = true,
      drop = {
	 items = {
	    {items = {"farming:wheat"}, rarity = 1},
	    {items = {"farming:wheat 2"}, rarity = 4},
	    {items = {"farming:wheat_1"}, rarity = 1},
	    {items = {"farming:wheat_1"}, rarity = 2},
	 }
      },
      selection_box = {
	 type = "fixed",
	 fixed = {-0.5, -0.5, -0.5, 0.5, -0.5+(4/16), 0.5}
      },
      groups = {dig_immediate=2, not_in_craftingguide = 1},
      sounds=default.node_sound_leaves_defaults()
   })

minetest.register_node(
   "farming:cotton_1",
   {
      description = "Cotton Seed",
      drawtype = "plantlike",
      tiles = {"farming_cotton_1.png"},
      inventory_image = "farming_cotton_4.png",
      paramtype = "light",
      waving = 1,
      walkable = false,
      buildable_to = true,
      is_ground_content = true,
      drop = {
	 items = {
	    {items = {"farming:cotton"}, rarity = 3}
	 }
      },
      selection_box = {
	 type = "fixed",
	 fixed = {-0.5, -0.5, -0.5, 0.5, -0.5+(4/16), 0.5}
      },
      groups = {dig_immediate=2},
      sounds=default.node_sound_leaves_defaults()
   })

minetest.register_node(
   "farming:cotton_2",
   {
      description = "Cotton",
      drawtype = "plantlike",
      tiles = {"farming_cotton_2.png"},
      paramtype = "light",
      waving = 1,
      walkable = false,
      buildable_to = true,
      is_ground_content = true,
      drop = {
	 items = {
	    {items = {"farming:cotton"}, rarity = 2}
	 }
      },
      selection_box = {
	 type = "fixed",
	 fixed = {-0.5, -0.5, -0.5, 0.5, -0.5+(4/16), 0.5}
      },
      groups = {dig_immediate=2, not_in_craftingguide = 1},
      sounds=default.node_sound_leaves_defaults()
   })

minetest.register_node(
   "farming:cotton_3",
   {
      description = "Cotton",
      drawtype = "plantlike",
      tiles = {"farming_cotton_3.png"},
      paramtype = "light",
      waving = 1,
      walkable = false,
      buildable_to = true,
      is_ground_content = true,
      drop = {
	 items = {
	    {items = {"farming:cotton"}, rarity = 1}
	 }
      },
      selection_box = {
	 type = "fixed",
	 fixed = {-0.5, -0.5, -0.5, 0.5, -0.5+(4/16), 0.5}
      },
      groups = {dig_immediate=2, not_in_craftingguide = 1},
      sounds=default.node_sound_leaves_defaults()
   })

minetest.register_node(
   "farming:cotton_4",
   {
      description = "Cotton",
      drawtype = "plantlike",
      tiles = {"farming_cotton_4.png"},
      paramtype = "light",
      waving = 1,
      walkable = false,
      buildable_to = true,
      is_ground_content = true,
      drop = {
	 items = {
	    {items = {"farming:cotton"}, rarity = 1},
	    {items = {"farming:cotton 2"}, rarity = 4},
	    {items = {"farming:cotton_1"}, rarity = 1},
	    {items = {"farming:cotton_1"}, rarity = 2},
	 }
      },
      selection_box = {
	 type = "fixed",
	 fixed = {-0.5, -0.5, -0.5, 0.5, -0.5+(4/16), 0.5}
      },
      groups = {dig_immediate=2, not_in_craftingguide = 1},
      sounds=default.node_sound_leaves_defaults()
   })

minetest.register_node(
   "farming:cotton_bale",
   {
      description = "Cotton Bale",
      tiles ={"farming_cotton_bale.png"},
      is_ground_content = false,
      groups = {snappy=2, oddly_breakable_by_hand=3, fall_damage_add_percent=-15, fuzzy = 1},
      sounds = default.node_sound_leaves_defaults(),
   })

default.log("nodes", "loaded")