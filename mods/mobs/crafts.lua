
--
-- Crafts and items
--

-- Wool

minetest.register_node(
   "mobs:wool",
   {
      description = "Wool Bundle",
      tiles ={"mobs_wool.png"},
      is_ground_content = false,
      groups = {snappy = 2, oddly_breakable_by_hand = 3, fall_damage_add_percent = -25, fuzzy = 1},
      sounds = default.node_sound_leaves_defaults(),
})

-- Raw meat

minetest.register_craftitem(
   "mobs:meat_raw",
   {
      description = "Raw Meat",
      inventory_image = "mobs_meat_raw.png",
      on_use = minetest.item_eat({hp = 3, sat = 30}),
})

-- Cooked meat

minetest.register_craftitem(
   "mobs:meat",
   {
      description = "Cooked Meat",
      inventory_image = "mobs_meat_cooked.png",
      on_use = minetest.item_eat({hp = 7, sat = 70}),
})

minetest.register_craft(
   {
      type = "cooking",
      output = "mobs:meat",
      recipe = "mobs:meat_raw",
      cooktime = 5,
})

-- Net

minetest.register_tool(
   "mobs:net",
   {
      description = "Net (Right-click to capture)",
      inventory_image = "mobs_net.png",
})

crafting.register_craft(
   {
      output = "mobs:net",
      items= {
         "default:fiber 3",
         "default:stick",
      }
})

-- Lasso

minetest.register_tool(
   "mobs:lasso",
   {
      description = "Lasso (Right-click to capture)",
      inventory_image = "mobs_lasso.png",
})

crafting.register_craft(
   {
      output = "mobs:lasso",
      items = {
         "default:rope 4",
         "default:stick",
      }
})
