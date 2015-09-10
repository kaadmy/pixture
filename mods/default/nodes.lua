--
-- Node definitions
--

minetest.register_node(
   "default:stone",
   {
      description = "Stone",
      tiles ={"default_stone.png"},
      groups = {cracky=2, stone=1},
      drop = "default:cobble",
      is_ground_content = true,
      sounds = default.node_sound_stone_defaults(),
   })

minetest.register_node(
   "default:cobble",
   {
      description = "Cobble",
      tiles ={"default_cobbles.png"},
      stack_max = 240,
      groups = {cracky=3, stone=1},
      sounds = default.node_sound_stone_defaults(),
      is_ground_content = true,
   })

minetest.register_node(
   "default:reinforced_cobble",
   {
      description = "Reinforced Cobble",
      tiles ={"default_reinforced_cobbles.png"},
      groups = {cracky=1, stone=1},
      is_ground_content = true,
      sounds = default.node_sound_stone_defaults(),
   })

minetest.register_node(
   "default:stone_with_coal",
   {
      description = "Stone with Coal",
      tiles ={"default_stone.png^default_mineral_coal.png"},
      groups = {cracky = 1, stone = 1, not_in_craftingguide = 1},
      drop = "default:lump_coal",
      is_ground_content = true,
      sounds = default.node_sound_stone_defaults(),
   })

minetest.register_node(
   "default:stone_with_iron",
   {
      description = "Stone with Iron",
      tiles ={"default_stone.png^default_mineral_iron.png"},
      groups = {cracky=1, stone=1, not_in_craftingguide = 1},
      drop = "default:lump_iron",
      is_ground_content = true,
      sounds = default.node_sound_stone_defaults(),
   })

minetest.register_node(
   "default:block_steel",
   {
      description = "Steel Block",
      tiles ={"default_block_steel.png"},
      groups = {cracky=1},
      is_ground_content = true,
      sounds = default.node_sound_stone_defaults(),
   })

minetest.register_node(
   "default:block_coal",
   {
      description = "Coal Block",
      tiles ={"default_block_coal.png"},
      groups = {choppy=3, oddly_breakable_by_hand = 3},
      is_ground_content = true,
      sounds = default.node_sound_wood_defaults(),
   })

minetest.register_node(
   "default:dirt",
   {
      description = "Dirt",
      tiles ={"default_dirt.png"},
      stack_max = 240,
      groups = {crumbly=3, soil=1, fall_damage_add_percent=-5},
      is_ground_content = true,
      sounds = default.node_sound_dirt_defaults(),
   })

minetest.register_node(
   "default:dirt_with_grass",
   {
      description = "Dirt with Grass",
      tiles ={"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
      groups = {crumbly=3, soil=1, fall_damage_add_percent=-5, not_in_craftingguide = 1},
      drop = {
	 max_items = 3,
	 items = {
	    {items = {"default:dirt"}, rarity = 1},
	    {items = {"default:grass 10"}, rarity = 30},
	    {items = {"default:grass 3"}, rarity = 9},
	    {items = {"default:grass 2"}, rarity = 6},
	    {items = {"default:grass 1"}, rarity = 3},
	 }
      },
      is_ground_content = true,
      sounds = default.node_sound_dirt_defaults(
	 {
	    footstep = {name="default_soft_footstep", gain=0.4},
	 }),
   })

minetest.register_node(
   "default:dirt_path",
   {
      description = "Dirt Path",
      drawtype = "nodebox",
      paramtype = "light",
      node_box = {
	 type = "fixed",
	 fixed = {-0.5, -0.5, -0.5, 0.5, 0.5-2/16, 0.5}
      },
      tiles ={"default_dirt.png"},
      groups = {crumbly=3, fall_damage_add_percent=-10},
      is_ground_content = true,
      sounds = default.node_sound_dirt_defaults(),
   })

minetest.register_node(
   "default:heated_dirt_path",
   {
      description = "Heated Dirt Path",
      drawtype = "nodebox",
      paramtype = "light",
      light_source = 6,
      node_box = {
	 type = "fixed",
	 fixed = {-0.5, -0.5, -0.5, 0.5, 0.5-2/16, 0.5}
      },
      tiles ={"default_dirt.png"},
      groups = {crumbly=3, fall_damage_add_percent=-10},
      is_ground_content = true,
      sounds = default.node_sound_dirt_defaults(),
   })

minetest.register_node(
   "default:brick",
   {
      description = "Brick",
      tiles ={"default_brick.png"},
      is_ground_content = false,
      groups = {cracky = 2},
      sounds = default.node_sound_stone_defaults(),
   })

minetest.register_node(
   "default:sand",
   {
      description = "Sand",
      tiles ={"default_sand.png"},
      groups = {crumbly = 3, falling_node = 1, sand = 1, fall_damage_add_percent = -10},
      is_ground_content = true,
      sounds = default.node_sound_sand_defaults(),
   })

minetest.register_node(
   "default:sandstone",
   {
      description = "Sandstone",
      tiles ={"default_sandstone.png"},
      groups = {crumbly = 2, cracky = 3},
      drop = "default:sand 2",
      is_ground_content = true,
      sounds = default.node_sound_stone_defaults(),
   })

minetest.register_node(
   "default:gravel",
   {
      description = "Gravel",
      tiles ={"default_gravel.png"},
      groups = {crumbly = 2, falling_node = 1},
      is_ground_content = true,
      sounds = default.node_sound_dirt_defaults(
	 {
	    footstep = {name="default_crunch_footstep", gain=0.45},
	 }),
   })

minetest.register_node(
   "default:sapling_oak",
   {
      description = "Oak Sapling",
      drawtype = "plantlike",
      visual_scale = 1.0,
      tiles ={"default_sapling_oak.png"},
      inventory_image = "default_sapling_oak_inventory.png",
      wield_image = "default_sapling_oak_inventory.png",
      paramtype = "light",
      walkable = false,
      selection_box = {
	 type = "fixed",
	 fixed = {-0.4, -0.5, -0.4, 0.4, 0.4, 0.4},
      },
      groups = {snappy = 2, dig_immediate = 2, attached_node = 1, sapling = 1},
      sounds = default.node_sound_defaults(),
   })

minetest.register_node(
   "default:tree_oak",
   {
      description = "Oak Tree",
      tiles = {"default_tree_oak_top.png", "default_tree_oak_top.png", "default_tree_oak.png"},
      groups = {snappy=1, choppy=1, tree=1, oddly_breakable_by_hand=1},
      sounds = default.node_sound_wood_defaults(),
   })

minetest.register_node(
   "default:leaves_oak",
   {
      description = "Oak Leaves",
      drawtype = "allfaces_optional",
      visual_scale = 1.3,
      tiles ={"default_leaves_oak.png"},
      paramtype = "light",
      waving = 1,
      is_ground_content = false,
      groups = {snappy=3, leafdecay=4, fall_damage_add_percent=-5, leaves = 1},
      drop = {
	 max_items = 1,
	 items = {
	    {
	       items = {"default:sapling_oak"},
	       rarity = 10,
	    },
	    {
	       items = {"default:leaves_oak"},
	    }
	 }
      },
      sounds = default.node_sound_leaves_defaults(),
   })

minetest.register_node( -- loks just like default oak leaves, except they decay much farther
   "default:leaves_oak_huge",
   {
      description = "Oak Leaves(Huge)",
      drawtype = "allfaces_optional",
      visual_scale = 1.3,
      tiles ={"default_leaves_oak.png"},
      paramtype = "light",
      waving = 1,
      is_ground_content = false,
      groups = {snappy=3, leafdecay=10, fall_damage_add_percent=-5, leaves = 1},
      drop = {
	 max_items = 1,
	 items = {
	    {
	       items = {"default:sapling_oak"},
	       rarity = 40,
	    },
	    {
	       items = {"default:leaves_oak"},
	       rarity = 10,
	    }
	 }
      },
      sounds = default.node_sound_leaves_defaults(),
   })

minetest.register_node(
   "default:sapling_birch",
   {
      description = "Birch Sapling",
      drawtype = "plantlike",
      visual_scale = 1.0,
      tiles ={"default_sapling_birch.png"},
      inventory_image = "default_sapling_birch_inventory.png",
      wield_image = "default_sapling_birch_inventory.png",
      paramtype = "light",
      walkable = false,
      selection_box = {
	 type = "fixed",
	 fixed = {-0.4, -0.5, -0.4, 0.4, 0.4, 0.4},
      },
      groups = {snappy=2, dig_immediate=2, attached_node=1, sapling = 1},
      sounds = default.node_sound_defaults(),
   })

minetest.register_node(
   "default:tree_birch",
   {
      description = "Birch Tree",
      tiles = {"default_tree_birch_top.png", "default_tree_birch_top.png", "default_tree_birch.png"},
      groups = {snappy=2, choppy=2, tree=1, oddly_breakable_by_hand=1},
      sounds = default.node_sound_wood_defaults(),
   })

minetest.register_node(
   "default:leaves_birch",
   {
      description = "Birch Leaves",
      drawtype = "allfaces_optional",
      visual_scale = 1.3,
      tiles ={"default_leaves_birch.png"},
      paramtype = "light",
      waving = 1,
      is_ground_content = false,
      groups = {snappy=3, leafdecay=6, fall_damage_add_percent=-5, leaves = 1},
      drop = {
	 max_items = 1,
	 items = {
	    {
	       items = {"default:sapling_birch"},
	       rarity = 10,
	    },
	    {
	       items = {"default:leaves_birch"},
	    }
	 }
      },
      sounds = default.node_sound_leaves_defaults(),
   })

minetest.register_node(
   "default:sapling",
   {
      description = "Sapling",
      drawtype = "plantlike",
      visual_scale = 1.0,
      tiles ={"default_sapling.png"},
      inventory_image = "default_sapling_inventory.png",
      wield_image = "default_sapling_inventory.png",
      paramtype = "light",
      walkable = false,
      selection_box = {
	 type = "fixed",
	 fixed = {-0.4, -0.5, -0.4, 0.4, 0.4, 0.4},
      },
      groups = {snappy=2, dig_immediate=2, attached_node=1, sapling = 1},
      sounds = default.node_sound_defaults(),
   })

minetest.register_node(
   "default:tree",
   {
      description = "Tree",
      tiles = {"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
      groups = {snappy=2,choppy=2,tree=1,oddly_breakable_by_hand=1},
      sounds = default.node_sound_wood_defaults(),
   })

minetest.register_node(
   "default:leaves",
   {
      description = "Leaves",
      drawtype = "allfaces_optional",
      visual_scale = 1.3,
      tiles ={"default_leaves.png"},
      paramtype = "light",
      waving = 1,
      is_ground_content = false,
      groups = {snappy=3, leafdecay=3, fall_damage_add_percent=-10, leaves = 1},
      drop = {
	 max_items = 1,
	 items = {
	    {
	       items = {"default:sapling"},
	       rarity = 10,
	    },
	    {
	       items = {"default:leaves"},
	    }
	 }
      },
      sounds = default.node_sound_leaves_defaults(),
   })

minetest.register_node(
   "default:cactus",
   {
      description = "Cactus",
      drawtype = "nodebox",
      paramtype = "light",
      node_box = {
	 type = "fixed",
	 fixed = {
	    {-0.5+(1/8), -0.5, -0.5+(1/8), 0.5-(1/8), 0.5, 0.5-(1/8)},
	    {-0.5, -0.5, -0.5+(1/3), 0.5, 0.5-(1/3), 0.5-(1/3)},
	    {-0.5+(1/3), -0.5, -0.5, 0.5-(1/3), 0.5-(1/3), 0.5},
	 },
      },
      tiles ={"default_cactus_top.png", "default_cactus_top.png", "default_cactus_sides.png"},
      --	damage_per_second = 1,
      groups = {snappy=2, choppy=2, fall_damage_add_percent=20},
      sounds = default.node_sound_wood_defaults(),
      after_dig_node = function(pos, node, metadata, digger)
			  default.dig_up(pos, node, digger)
		       end,
      on_use = minetest.item_eat({hp = 2, sat = 5}),
   })

minetest.register_node(
   "default:papyrus",
   {
      description = "Papyrus",
      drawtype = "nodebox",
      tiles ={"default_papyrus.png"},
      inventory_image = "default_papyrus_inventory.png",
      wield_image = "default_papyrus_inventory.png",
      paramtype = "light",
      walkable = false,
      climbable = true,
      selection_box = {
	 type = "fixed",
	 fixed = {-0.5+(2/16), -0.5, -0.5+(2/16), 0.5-(2/16), 0.5, 0.5-(2/16)}
      },
      node_box = {
	 type = "fixed",
	 fixed = {
	    {-0.5+(2/16), -0.5, -0.5+(2/16), -0.5+(4/16), 0.5, -0.5+(4/16)},
	    {0.5-(2/16), -0.5, -0.5+(2/16), 0.5-(4/16), 0.5, -0.5+(4/16)},
	    {-0.5+(2/16), -0.5, 0.5-(2/16), -0.5+(4/16), 0.5, 0.5-(4/16)},
	    {0.5-(2/16), -0.5, 0.5-(2/16), 0.5-(4/16), 0.5, 0.5-(4/16)},
	    {-1/16, -0.5, -1/16, 1/16, 0.5, 1/16},
	 }
      },
      groups = {snappy=3},
      sounds = default.node_sound_leaves_defaults(),
      after_dig_node = function(pos, node, metadata, digger)
			  default.dig_up(pos, node, digger)
		       end,
   })

minetest.register_node(
   "default:bookshelf",
   {
      description = "Bookshelf",
      tiles ={"default_wood.png", "default_wood.png", "default_bookshelf.png"},
      groups = {snappy=2,choppy=3,oddly_breakable_by_hand=2},
      sounds = default.node_sound_wood_defaults(),
      paramtype2 = "facedir",
      on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", default.ui.get_page("core_bookshelf"))
			meta:set_string("infotext", "Bookshelf")
			local inv = meta:get_inventory()
			inv:set_size("main", 4*2)
		     end,
      can_dig = function(pos,player)
		   local meta = minetest.get_meta(pos);
		   local inv = meta:get_inventory()
		   return inv:is_empty("main")
		end,
   })

minetest.register_node(
   "default:glass",
   {
      description = "Glass",
      drawtype = "glasslike_framed_optional",
      tiles ={"default_glass_frame.png", "default_glass.png"},
      paramtype = "light",
      --	sunlight_propagates = true,
      groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
      sounds = default.node_sound_glass_defaults(),
   })

minetest.register_node(
   "default:fence",
   {
      description = "Wooden Fence",
      drawtype = "fencelike",
      tiles ={"default_wood.png"},
      inventory_image = "default_fence.png",
      wield_image = "default_fence.png",
      paramtype = "light",
      collision_box = {
	 type = "fixed",
	 fixed = {-0.4, -0.5, -0.4, 0.4, 0.75, 0.4},
      },
      groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 2},
      sounds = default.node_sound_wood_defaults(),
      after_dig_node = function(pos, node, metadata, digger)
			  default.dig_up(pos, node, digger)
		       end,
   })

minetest.register_node(
   "default:ladder",
   {
      description = "Ladder",
      drawtype = "nodebox",
      tiles ={"default_ladder_sides.png", "default_ladder_sides.png", "default_ladder_sides.png", "default_ladder_sides.png", "default_ladder_sides.png", "default_ladder.png"},
      inventory_image = "default_ladder_inventory.png",
      wield_image = "default_ladder_inventory.png",
      paramtype = "light",
      paramtype2 = "facedir",
      walkable = false,
      climbable = true,
      node_box = {
	 type = "fixed",
	 fixed = {
	    {-0.5+(1/16), -0.5, 0.5, -0.5+(4/16), 0.5, 0.5-(2/16)},
	    {0.5-(1/16), -0.5, 0.5, 0.5-(4/16), 0.5, 0.5-(2/16)},
	    {-0.5+(4/16), 0.5-(3/16), 0.5, 0.5-(4/16), 0.5-(5/16), 0.5-(1/16)},
	    {-0.5+(4/16), -0.5+(3/16), 0.5, 0.5-(4/16), -0.5+(5/16), 0.5-(1/16)}
	 }
      },
      selection_box = {
	 type = "fixed",
	 fixed = {
	    {-0.5, -0.5, 0.5, 0.5, 0.5, 0.5-(2/15)}
	 }
      },
      groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 3},
      sounds = default.node_sound_wood_defaults(),
   })

minetest.register_node(
   "default:planks",
   {
      description = "Planks",
      tiles ={"default_wood.png"},
      groups = {planks = 1, snappy = 3, choppy = 3, oddly_breakable_by_hand = 3},
      sounds = default.node_sound_wood_defaults(),
   })

minetest.register_node(
   "default:planks_oak",
   {
      description = "Oak Planks",
      tiles ={"default_wood_oak.png"},
      groups = {planks = 1, snappy = 2, choppy = 2, oddly_breakable_by_hand = 3},
      sounds = default.node_sound_wood_defaults(),
   })

minetest.register_node(
   "default:planks_birch",
   {
      description = "Birch Planks",
      tiles ={"default_wood_birch.png"},
      groups = {planks = 1, snappy = 2, choppy = 2, oddly_breakable_by_hand = 2},
      sounds = default.node_sound_wood_defaults(),
   })

minetest.register_node(
   "default:frame",
   {
      description = "Frame",
      tiles ={"default_frame.png"},
      groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1},
      sounds = default.node_sound_wood_defaults(),
   })

minetest.register_node(
   "default:reinforced_frame",
   {
      description = "Reinforced Frame",
      tiles ={"default_reinforced_frame.png"},
      groups = {wood = 1, choppy = 1},
      sounds = default.node_sound_wood_defaults(),
   })

minetest.register_node(
   "default:water_flowing",
   {
      description = "Water (flowing)",
      inventory_image = minetest.inventorycube("default_water.png"),
      drawtype = "flowingliquid",
      tiles ={"default_water.png"},
      special_tiles = {
	 {
	    image = "default_water_animated.png",
	    backface_culling=false,
	    animation={type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 0.8}
	 },
	 {
	    image = "default_water_animated.png",
	    backface_culling=false,
	    animation={type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 0.8}
	 },
      },
      alpha = default.WATER_ALPHA,
      paramtype = "light",
      walkable = false,
      pointable = false,
      diggable = false,
      buildable_to = true,
      drowning = 1,
      liquidtype = "flowing",
      liquid_alternative_flowing = "default:water_flowing",
      liquid_alternative_source = "default:water_source",
      liquid_viscosity = default.WATER_VISC,
      post_effect_color = {a=90, r=40, g=40, b=250},
      groups = {water=1, liquid=1},
   })

minetest.register_node(
   "default:water_source",
   {
      description = "Water",
      inventory_image = minetest.inventorycube("default_water.png"),
      drawtype = "liquid",
      tiles ={"default_water.png"},
      special_tiles = {
	 {
	    image = "default_water.png",
	    backface_culling=false,
	 },
      },
      alpha = default.WATER_ALPHA,
      paramtype = "light",
      walkable = false,
      pointable = false,
      diggable = false,
      buildable_to = true,
      drowning = 1,
      liquidtype = "source",
      liquid_alternative_flowing = "default:water_flowing",
      liquid_alternative_source = "default:water_source",
      liquid_viscosity = default.WATER_VISC,
      post_effect_color = {a=90, r=40, g=40, b=250},
      groups = {water=1, liquid=1},
   })

minetest.register_node(
   "default:torch",
   {
      description = "Torch",
      drawtype = "nodebox",
      tiles ={
	 {
	    name = "default_torch_3d_ends.png",
	    animation = {
	       type = "vertical_frames",
	       aspect_w = 16,
	       aspect_h = 16,
	       length = 1.0,
	    },
	 },
	 {
	    name = "default_torch_3d_ends.png",
	    animation = {
	       type = "vertical_frames",
	       aspect_w = 16,
	       aspect_h = 16,
	       length = 1.0,
	    },
	 },
	 {
	    name = "default_torch_3d.png",
	    animation = {
	       type = "vertical_frames",
	       aspect_w = 16,
	       aspect_h = 16,
	       length = 1.0,
	    },
	 },
      },
      inventory_image = "default_torch.png",
      wield_image = "default_torch.png",
      paramtype = "light",
      paramtype2 = "wallmounted",
      sunlight_propagates = true,
      is_ground_content = false,
      walkable = false,
      light_source = default.LIGHT_MAX-1,
      node_box = {
	 type = "wallmounted",
	 wall_top = {-2/16, 0, -2/16, 2/16, 0.5, 2/16},
	 wall_bottom = {-2/16, -0.5, -2/16, 2/16, 0, 2/16},
	 wall_side = {-0.5, -8/16, -0.1, -0.5+4/16, 0, 0.1},
      },
      groups = {choppy=2, dig_immediate=3, attached_node=1},
      legacy_wallmounted = true,
      sounds = default.node_sound_defaults(),
   })

minetest.register_node(
   "default:sign",
   {
      description = "Sign",
      drawtype = "signlike",
      tiles = {"default_sign.png"},
      inventory_image = "default_sign.png",
      wield_image = "default_sign.png",
      paramtype = "light",
      paramtype2 = "wallmounted",
      sunlight_propagates = true,
      is_ground_content = false,
      walkable = false,
      selection_box = {
	 type = "wallmounted",
	 wall_top = {-0.5+(4/16), 0.5, -0.5+(1/16), 0.5-(4/16), 0.5-(1/16), 0.5-(1/16)},
	 wall_bottom = {-0.5+(4/16), -0.5, -0.5+(1/16), 0.5-(4/16), -0.5+(1/16), 0.5-(1/16)},
	 wall_side = {-0.5, -0.5+(4/16), -0.5+(1/16), -0.5+(1/16), 0.5-(4/16), 0.5-(1/16)},
	 --wall_top = <default>
	 --wall_bottom = <default>
	 --wall_side = <default>
      },
      groups = {choppy=2,dig_immediate=2,attached_node=1},
      legacy_wallmounted = true,
      sounds = default.node_sound_defaults(),
      on_construct = function(pos)
			--local n = minetest.get_node(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", default.ui.get_page("core_field"))
			--			"field[text;;${text}]")
			meta:set_string("infotext", '""')
		     end,
      on_receive_fields = function(pos, formname, fields, sender)
			     --print("Sign at "..minetest.pos_to_string(pos).." got "..dump(fields))
			     local meta = minetest.get_meta(pos)
			     fields.text = fields.text or ""
			     print((sender:get_player_name() or "").." wrote \""..fields.text..
				"\" to sign at "..minetest.pos_to_string(pos))
			     meta:set_string("text", fields.text)
			     meta:set_string("infotext", '"'..fields.text..'"')
			  end,
   })

minetest.register_node(
   "default:grass",
   {
      description = "Grass Clump",
      drawtype = "plantlike",
      selection_box = {
	 type = "fixed",
	 fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
      },
      visual_scale = 1.15,
      tiles ={"default_grass_clump.png"},
      inventory_image = "default_grass_clump_inventory.png",
      wield_image = "default_grass_clump_inventory.png",
      paramtype = "light",
      waving = 1,
      walkable = false,
      buildable_to = true,
      is_ground_content = true,
      groups = {snappy=2,dig_immediate=3,attached_node=1},
      sounds = default.node_sound_leaves_defaults(),
   })

minetest.register_node(
   "default:tall_grass",
   {
      description = "Tall Grass Clump",
      drawtype = "plantlike",
      selection_box = {
	 type = "fixed",
	 fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
      },
      visual_scale = 1.15,
      tiles ={"default_grass_clump_tall.png"},
      inventory_image = "default_grass_clump_inventory.png",
      wield_image = "default_grass_clump_inventory.png",
      wield_image = "default_grass_clump_tall.png",
      drop = "default:grass",
      paramtype = "light",
      waving = 1,
      walkable = false,
      buildable_to = true,
      is_ground_content = true,
      groups = {snappy=2,dig_immediate=3,attached_node=1},
      sounds = default.node_sound_leaves_defaults(),
   })

minetest.register_node(
   "default:apple",
   {
      description = "Apple",
      drawtype = "nodebox",
      visual_scale = 1.0,
      tiles ={"default_apple_top.png", "default_apple_bottom.png", "default_apple_side.png"},
      inventory_image = "default_apple.png",
      wield_image = "default_apple.png",
      paramtype = "light",
      node_box = {
	 type = "fixed",
	 fixed = {
	    {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
	    {-1/8, 0.25, -1/8, 1/8, 0.5, 1/8},
	 },
      },
      selection_box = {
	 type = "fixed",
	 fixed = {
	    {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
	    {-1/8, 0.25, -1/8, 1/8, 0.5, 1/8},
	 },
      },
      sunlight_propagates = true,
      walkable = false,
      groups = {fleshy=3,dig_immediate=2},
      on_use = minetest.item_eat({hp = 2, sat = 10}),
      sounds = default.node_sound_defaults(),
   })

minetest.register_node(
   "default:chest",
   {
      description = "Chest",
      tiles ={"default_chest_top.png", "default_chest_top.png", "default_chest_sides.png",
	      "default_chest_sides.png", "default_chest_sides.png", "default_chest_front.png"},
      paramtype2 = "facedir",
      groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
      legacy_facedir_simple = true,
      is_ground_content = false,
      sounds = default.node_sound_wood_defaults(),
      on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", default.ui.get_page("default_chest"))
			meta:set_string("infotext", "Chest")

			local inv = meta:get_inventory()
			inv:set_size("main", 8*4)
		     end,
      can_dig = function(pos, player)
		   local meta = minetest.get_meta(pos)
		   local inv = meta:get_inventory()
		   return inv:is_empty("main")
		end,
   })

local form_chest = default.ui.get_page("core_2part")
form_chest = form_chest .. "list[current_name;main;0.25,0.25;8,4;]"
form_chest = form_chest .. "listring[current_name;main]"
form_chest = form_chest .. default.ui.get_itemslot_bg(0.25, 0.25, 8, 4)

form_chest = form_chest .. "list[current_player;main;0.25,4.75;8,4;]"
form_chest = form_chest .. "listring[current_player;main]"
form_chest = form_chest .. default.ui.get_hotbar_itemslot_bg(0.25, 4.75, 8, 1)
form_chest = form_chest .. default.ui.get_itemslot_bg(0.25, 5.75, 8, 3)
default.ui.register_page("default_chest", form_chest)

default.log("nodes", "loaded")