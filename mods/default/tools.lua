--
-- Tool definition
--

local creative_digtime=0.5

local tool_levels=nil

-- Creative mode/hand defs
if minetest.setting_getbool("creative_mode") == true then
   tool_levels = {
      wood = {
	 [3] = creative_digtime,
	 [2] = creative_digtime,
      },
      stone = {
	 [3] = creative_digtime,
	 [2] = creative_digtime,
	 [1] = creative_digtime,
      },
      steel = {
	 [3] = creative_digtime,
	 [2] = creative_digtime,
	 [1] = creative_digtime,
      },
   }

   minetest.register_item(
      ":",
      {
	 type = "none",
	 wield_image = "wieldhand.png",
	 wield_scale = {x=1.5,y=3,z=3},
	 tool_capabilities = {
	    full_punch_interval = 1.0,
	    max_drop_level = 0,
	    groupcaps = {
	       fleshy = {times={[1]=creative_digtime, [2]=creative_digtime, [3]=creative_digtime}, uses=0, maxlevel=1},
	       crumbly = {times={[1]=creative_digtime, [2]=creative_digtime, [3]=creative_digtime}, uses=0, maxlevel=1},
	       choppy = {times={[1]=creative_digtime, [2]=creative_digtime, [3]=creative_digtime}, uses=0, maxlevel=1},
	       cracky = {times={[1]=creative_digtime, [2]=creative_digtime, [3]=creative_digtime}, uses=0, maxlevel=1},
	       snappy = {times={[1]=creative_digtime, [2]=creative_digtime, [3]=creative_digtime}, uses=0, maxlevel=1},
	       oddly_breakable_by_hand = {times={[1]=creative_digtime,[2]=creative_digtime,[3]=creative_digtime}, uses=0, maxlevel=3},
	    },
	    range = 3.8,
	    damage_groups = {fleshy = 1}
	 }
      })
else
   tool_levels = {
      wood = {
	 [3] = 1.6,
	 [2] = 2.4,
      },
      stone = {
	 [3] = 1.0,
	 [2] = 2.0,
	 [1] = 2.6,
      },
      steel = {
	 [3] = 0.4,
	 [2] = 1.2,
	 [1] = 2.0,
      },
   }

   minetest.register_item(
      ":",
      {
	 type = "none",
	 wield_image = "wieldhand.png",
	 wield_scale = {x=1.5,y=3,z=3},
	 tool_capabilities = {
	    full_punch_interval = 1.0,
	    max_drop_level = 0,
	    groupcaps = {
	       fleshy = {times={[2]=1.6, [3]=1.0}, uses=0, maxlevel=1},
	       crumbly = {times={[2]=3.0, [3]=2.0}, uses=0, maxlevel=1},
	       snappy = {times={[3]=0.8}, uses=0, maxlevel=1},
	       oddly_breakable_by_hand = {times={[1]=7.0,[2]=5.5,[3]=4.0}, uses=0, maxlevel=3},
	    },
	    range = 3.8,
	    damage_groups = {fleshy = 1}
	 }
      })
end

-- Pickaxes

minetest.register_tool(
   "default:pick_wood",
   {
      description = "Wooden Pickaxe",
      inventory_image = "default_pick_wood.png",
      tool_capabilities = {
	 max_drop_level=0,
	 groupcaps={
	    cracky={times=tool_levels.wood, uses=10, maxlevel=1}
	 },
	 damage_groups = {fleshy = 2}
      },
   })

minetest.register_tool(
   "default:pick_stone",
   {
      description = "Stone Pickaxe",
      inventory_image = "default_pick_stone.png",
      tool_capabilities = {
	 max_drop_level=0,
	 groupcaps={
	    cracky={times=tool_levels.stone, uses=20, maxlevel=1}
	 },
	 damage_groups = {fleshy = 3}
      },
   })

minetest.register_tool(
   "default:pick_steel",
   {
      description = "Steel Pickaxe",
      inventory_image = "default_pick_steel.png",
      tool_capabilities = {
	 max_drop_level=1,
	 groupcaps={
	    cracky={times=tool_levels.steel, uses=25, maxlevel=2}
	 },
	 damage_groups = {fleshy = 4}
      },
   })

minetest.register_tool(
   "default:pick_carbonsteel",
   {
      description = "Carbon Steel Pickaxe",
      inventory_image = "default_pick_carbonsteel.png",
      tool_capabilities = {
	 max_drop_level=1,
	 groupcaps={
	    cracky={times=tool_levels.steel, uses=35, maxlevel=2}
	 },
	 damage_groups = {fleshy = 6}
      },
   })

-- Shovels

minetest.register_tool(
   "default:shovel_wood",
   {
      description = "Wooden Shovel",
      inventory_image = "default_shovel_wood.png",
      tool_capabilities = {
	 max_drop_level=0,
	 groupcaps={
	    crumbly={times=tool_levels.wood, uses=10, maxlevel=1}
	 },
	 damage_groups = {fleshy = 2}
      },
   })

minetest.register_tool(
   "default:shovel_stone",
   {
      description = "Stone Shovel",
      inventory_image = "default_shovel_stone.png",
      tool_capabilities = {
	 max_drop_level=0,
	 groupcaps={
	    crumbly={times=tool_levels.stone, uses=20, maxlevel=1}
	 },
	 damage_groups = {fleshy = 3}
      },
   })

minetest.register_tool(
   "default:shovel_steel",
   {
      description = "Steel Shovel",
      inventory_image = "default_shovel_steel.png",
      tool_capabilities = {
	 max_drop_level=1,
	 groupcaps={
	    crumbly={times=tool_levels.steel, uses=25, maxlevel=2}
	 },
	 damage_groups = {fleshy = 4}
      },
   })

minetest.register_tool(
   "default:shovel_carbonsteel",
   {
      description = "Carbon Steel Shovel",
      inventory_image = "default_shovel_carbonsteel.png",
      tool_capabilities = {
	 max_drop_level=1,
	 groupcaps={
	    crumbly={times=tool_levels.steel, uses=35, maxlevel=2}
	 },
	 damage_groups = {fleshy = 6}
      },
   })

-- Axes

minetest.register_tool(
   "default:axe_wood",
   {
      description = "Wooden Axe",
      inventory_image = "default_axe_wood.png",
      tool_capabilities = {
	 max_drop_level=0,
	 groupcaps={
	    choppy={times=tool_levels.wood, uses=10, maxlevel=1},
	    fleshy={times={[2]=1.20, [3]=0.60}, uses=10, maxlevel=1}
	 },
	 damage_groups = {fleshy = 3}
      },
   })

minetest.register_tool(
   "default:axe_stone",
   {
      description = "Stone Axe",
      inventory_image = "default_axe_stone.png",
      tool_capabilities = {
	 max_drop_level=0,
	 groupcaps={
	    choppy={times=tool_levels.stone, uses=20, maxlevel=1},
	    fleshy={times={[2]=1.10, [3]=0.40}, uses=20, maxlevel=1}
	 },
	 damage_groups = {fleshy = 4}
      },
   })

minetest.register_tool(
   "default:axe_steel",
   {
      description = "Steel Axe",
      inventory_image = "default_axe_steel.png",
      tool_capabilities = {
	 max_drop_level=1,
	 groupcaps={
	    choppy={times=tool_levels.steel, uses=25, maxlevel=2},
	    fleshy={times={[2]=1.00, [3]=0.20}, uses=40, maxlevel=1}
	 },
	 damage_groups = {fleshy = 5}
      },
   })

minetest.register_tool(
   "default:axe_carbonsteel",
   {
      description = "Carbon Steel Axe",
      inventory_image = "default_axe_carbonsteel.png",
      tool_capabilities = {
	 max_drop_level=1,
	 groupcaps={
	    choppy={times=tool_levels.steel, uses=35, maxlevel=2},
	    fleshy={times={[2]=1.00, [3]=0.20}, uses=40, maxlevel=1}
	 },
	 damage_groups = {fleshy = 7}
      },
   })

-- Spears

minetest.register_tool(
   "default:spear_wood",
   {
      description = "Wooden Spear",
      inventory_image = "default_spear_wood.png",
      tool_capabilities = {
	 full_punch_interval = 1.0,
	 max_drop_level=0,
	 groupcaps={
	    fleshy={times={[2]=1.10, [3]=0.60}, uses=10, maxlevel=1},
	    snappy={times={[2]=1.00, [3]=0.50}, uses=10, maxlevel=1},
	    choppy={times={[3]=1.00}, uses=20, maxlevel=0}
	 },
	 damage_groups = {fleshy = 4}
      }
   })

minetest.register_tool(
   "default:spear_stone",
   {
      description = "Stone Spear",
      inventory_image = "default_spear_stone.png",
      tool_capabilities = {
	 full_punch_interval = 1.0,
	 max_drop_level=0,
	 groupcaps={
	    fleshy={times={[2]=0.80, [3]=0.40}, uses=20, maxlevel=1},
	    snappy={times={[2]=0.80, [3]=0.40}, uses=20, maxlevel=1},
	    choppy={times={[3]=0.90}, uses=20, maxlevel=0}
	 },
	 damage_groups = {fleshy = 5}
      }
   })

minetest.register_tool(
   "default:spear_steel",
   {
      description = "Steel Spear",
      inventory_image = "default_spear_steel.png",
      tool_capabilities = {
	 full_punch_interval = 1.0,
	 max_drop_level=1,
	 groupcaps={
	    fleshy={times={[1]=2.00, [2]=0.80, [3]=0.40}, uses=10, maxlevel=2},
	    snappy={times={[2]=0.70, [3]=0.30}, uses=40, maxlevel=1},
	    choppy={times={[3]=0.70}, uses=40, maxlevel=0}
	 },
	 damage_groups = {fleshy = 6}
      }
   })

minetest.register_tool(
   "default:spear_carbonsteel",
   {
      description = "Carbon Steel Spear",
      inventory_image = "default_spear_carbonsteel.png",
      tool_capabilities = {
	 full_punch_interval = 1.0,
	 max_drop_level=1,
	 groupcaps={
	    fleshy={times={[1]=2.00, [2]=0.80, [3]=0.40}, uses=25, maxlevel=2},
	    snappy={times={[2]=0.70, [3]=0.30}, uses=55, maxlevel=1},
	    choppy={times={[3]=0.70}, uses=55, maxlevel=0}
	 },
	 damage_groups = {fleshy = 10}
      }
   })

default.log("tools", "loaded")