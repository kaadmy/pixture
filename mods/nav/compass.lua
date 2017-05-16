
--
-- Compass handling
--

local wield_image_0 = "nav_compass_inventory_0.png"
local wield_image_1 = "nav_compass_inventory_1.png"

function on_globalstep(dtime)
   for _, player in pairs(minetest.get_connected_players()) do
      local inv = player:get_inventory()

      local yaw = player:get_look_horizontal()
      local dir = math.floor(((yaw / math.pi) * 4) + 0.5)

      if dir < 0 then
	 dir = dir + 8
      end

      if dir >= 8 then
	 dir = 0
      end

      for i = 1, 8 do
	 local itemstack = inv:get_stack("main", i)
	 local item = minetest.registered_items[itemstack:get_name()]

	 if item ~= nil then
	    if item.groups.nav_compass then
	       inv:set_stack("main", i, ItemStack("nav:compass_"..dir))
	    end
	 end
      end
   end
end

minetest.register_globalstep(on_globalstep)

-- Items

minetest.register_craftitem(
   "nav:compass_0",
   {
      description = "Compass",

      inventory_image = "nav_compass_inventory_0.png",
      wield_image = wield_image_0,

      groups = {nav_compass = 1},
      stack_max = 1,
})

minetest.register_craftitem(
   "nav:compass_1",
   {
      description = "Compass",

      inventory_image = "nav_compass_inventory_1.png",
      wield_image = wield_image_1,

      groups = {nav_compass = 1},
      stack_max = 1,
})

minetest.register_craftitem(
   "nav:compass_2",
   {
      description = "Compass",

      inventory_image = "nav_compass_inventory_0.png^[transformR270",
      wield_image = wield_image_0 .. "^[transformR270",

      groups = {nav_compass = 1},
      stack_max = 1,
})

minetest.register_craftitem(
   "nav:compass_3",
   {
      description = "Compass",

      inventory_image = "nav_compass_inventory_1.png^[transformR270",
      wield_image = wield_image_1 .. "^[transformR270",

      groups = {nav_compass = 1},
      stack_max = 1,
})


minetest.register_craftitem(
   "nav:compass_4",
   {
      description = "Compass",

      inventory_image = "nav_compass_inventory_0.png^[transformR180",
      wield_image = wield_image_0 .. "^[transformR180",

      groups = {nav_compass = 1},
      stack_max = 1,
})

minetest.register_craftitem(
   "nav:compass_5",
   {
      description = "Compass",

      inventory_image = "nav_compass_inventory_1.png^[transformR180",
      wield_image = wield_image_1 .. "^[transformR180",

      groups = {nav_compass = 1},
      stack_max = 1,
})

minetest.register_craftitem(
   "nav:compass_6",
   {
      description = "Compass",

      inventory_image = "nav_compass_inventory_0.png^[transformR90",
      wield_image = wield_image_0 .. "^[transformR90",

      groups = {nav_compass = 1},
      stack_max = 1,
})

minetest.register_craftitem(
   "nav:compass_7",
   {
      description = "Compass",

      inventory_image = "nav_compass_inventory_1.png^[transformR90",
      wield_image = wield_image_1 .. "^[transformR90",

      groups = {nav_compass = 1},
      stack_max = 1,
})

minetest.register_alias("nav:compass", "nav:compass_0")

-- Crafting

crafting.register_craft(
   {
      output = "nav:compass",
      items = {
         "default:ingot_steel 4",
         "default:stick",
      }
})

-- Achievements

achievements.register_achievement(
   "true_navigator",
   {
      title = "True Navigator",
      description = "Craft a compass",
      times = 1,
      craftitem = "nav:compass",
})

default.log("compass", "loaded")
