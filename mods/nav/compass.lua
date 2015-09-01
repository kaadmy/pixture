-- Compass handling

minetest.register_craftitem(
   "nav:compass_0",
   {
      description = "Compass(East)",

      inventory_image = "nav_compass_0.png^[transformR90",

      groups = {nav_compass = 1},
      stack_max = 1,
   })

minetest.register_craftitem(
   "nav:compass_1",
   {
      description = "Compass(North-East)",

      inventory_image = "nav_compass_1.png^[transformR90",

      groups = {nav_compass = 1},
      stack_max = 1,
   })

minetest.register_craftitem(
   "nav:compass_2",
   {
      description = "Compass(North)",

      inventory_image = "nav_compass_0.png",

      groups = {nav_compass = 1},
      stack_max = 1,
   })

minetest.register_craftitem(
   "nav:compass_3",
   {
      description = "Compass(North-West)",

      inventory_image = "nav_compass_1.png",

      groups = {nav_compass = 1},
      stack_max = 1,
   })

minetest.register_craftitem(
   "nav:compass_4",
   {
      description = "Compass(West)",

      inventory_image = "nav_compass_0.png^[transformR270",

      groups = {nav_compass = 1},
      stack_max = 1,
   })

minetest.register_craftitem(
   "nav:compass_5",
   {
      description = "Compass(South-West)",

      inventory_image = "nav_compass_1.png^[transformR270",

      groups = {nav_compass = 1},
      stack_max = 1,
   })

minetest.register_craftitem(
   "nav:compass_6",
   {
      description = "Compass(South)",

      inventory_image = "nav_compass_0.png^[transformR180",

      groups = {nav_compass = 1},
      stack_max = 1,
   })

minetest.register_craftitem(
   "nav:compass_7",
   {
      description = "Compass(South-East)",

      inventory_image = "nav_compass_1.png^[transformR180",

      groups = {nav_compass = 1},
      stack_max = 1,
   })

minetest.register_alias("nav:compass", "nav:compass_3")

minetest.register_craft(
   {
      output = "nav:compass_2",
      recipe = {
	 {"", "default:ingot_carbonsteel", ""},
	 {"default:ingot_steel", "default:stick", "default:ingot_steel"},
	 {"", "default:ingot_steel", ""},
      }
   })

function step(dtime)
   for _, player in pairs(minetest.get_connected_players()) do
      local inv = player:get_inventory()

      local yaw = player:get_look_yaw()
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
	 
	 if item.groups.nav_compass then
	    inv:set_stack("main", i, ItemStack("nav:compass_"..dir))
	 end
      end
   end
end

minetest.register_globalstep(step)
