--
-- Crafting items
--

minetest.register_craftitem(
   "default:fiber",
   {
      description = "Fiber",
      inventory_image = "default_fiber.png",
})

minetest.register_craftitem(
   "default:stick",
   {
      description = "Stick",
      inventory_image = "default_stick.png",
      groups = {stick = 1}
})

minetest.register_craftitem(
   "default:paper",
   {
      description = "Paper",
      inventory_image = "default_paper.png",
})

minetest.register_craftitem(
   "default:book",
   {
      description = "Book",
      inventory_image = "default_book.png",
      wield_scale = {x=1,y=1,z=2},
      stack_max = 1,
})

minetest.register_craftitem(
   "default:lump_coal",
   {
      description = "Coal Lump",
      inventory_image = "default_lump_coal.png",
})

minetest.register_craftitem(
   "default:lump_iron",
   {
      description = "Iron Lump",
      inventory_image = "default_lump_iron.png",
})

minetest.register_craftitem(
   "default:dust_carbonsteel",
   {
      description = "Carbon Steel Dust",
      inventory_image = "default_dust_carbonsteel.png",
})

minetest.register_craftitem(
   "default:ingot_steel",
   {
      description = "Steel Ingot",
      inventory_image = "default_ingot_steel.png",
})

minetest.register_craftitem(
   "default:ingot_carbonsteel",
   {
      description = "Carbon Steel Ingot",
      inventory_image = "default_ingot_carbonsteel.png",
})

minetest.register_craftitem(
   "default:lump_sugar",
   {
      description = "Sugar Lump",
      inventory_image = "default_lump_sugar.png",
      on_use = minetest.item_eat({hp = 1, sat = 10})
})

minetest.register_craftitem(
   "default:pearl",
   {
      description = "Pearl",
      inventory_image = "default_pearl.png",
})

minetest.register_craftitem(
   "default:flint",
   {
      description = "Flint Shard",
      inventory_image = "default_flint.png",
})

minetest.register_craftitem(
   "default:bucket_water",
   {
      description = "Water Bucket",
      inventory_image = "default_bucket_water.png",
      stack_max = 1,
      wield_scale = {x=1,y=1,z=2},
      liquids_pointable = true,
      on_place = function(itemstack, user, pointed_thing)
         if pointed_thing.type ~= "node" then return end

         local pos_protected = minetest.get_pointed_thing_position(pointed_thing, true)
         if minetest.is_protected(pos_protected, user) then return end

         itemstack:take_item()

         local inv=user:get_inventory()

         if inv:room_for_item("main", {name="default:bucket"}) then
            inv:add_item("main", "default:bucket")
         else
            local pos = user:getpos()
            pos.y = math.floor(pos.y + 0.5)
            minetest.add_item(pos, "default:bucket")
         end

         local pos = pointed_thing.above
         if minetest.registered_nodes[minetest.get_node(pointed_thing.under).name].buildable_to then
            pos=pointed_thing.under
         end
         minetest.add_node(pos, {name = "default:water_source"})

         return itemstack
      end
})

minetest.register_craftitem(
   "default:bucket_river_water",
   {
      description = "River Water Bucket",
      inventory_image = "default_bucket_river_water.png",
      stack_max = 1,
      wield_scale = {x=1,y=1,z=2},
      liquids_pointable = true,
      on_place = function(itemstack, user, pointed_thing)
         if pointed_thing.type ~= "node" then return end

         local pos_protected = minetest.get_pointed_thing_position(pointed_thing, true)
         if minetest.is_protected(pos_protected, user) then return end

         itemstack:take_item()

         local inv=user:get_inventory()

         if inv:room_for_item("main", {name="default:bucket"}) then
            inv:add_item("main", "default:bucket")
         else
            local pos = user:getpos()
            pos.y = math.floor(pos.y + 0.5)
            minetest.add_item(pos, "default:bucket")
         end

         local pos = pointed_thing.above
         if minetest.registered_nodes[minetest.get_node(pointed_thing.under).name].buildable_to then
            pos=pointed_thing.under
         end
         minetest.add_node(pos, {name = "default:river_water_source"})

         return itemstack
      end
})

minetest.register_craftitem(
   "default:bucket_swamp_water",
   {
      description = "Swamp Water Bucket",
      inventory_image = "default_bucket_swamp_water.png",
      stack_max = 1,
      wield_scale = {x=1,y=1,z=2},
      liquids_pointable = true,
      on_place = function(itemstack, user, pointed_thing)
         if pointed_thing.type ~= "node" then return end

         local pos_protected = minetest.get_pointed_thing_position(pointed_thing, true)
         if minetest.is_protected(pos_protected, user) then return end

         itemstack:take_item()

         local inv=user:get_inventory()

         if inv:room_for_item("main", {name="default:bucket"}) then
            inv:add_item("main", "default:bucket")
         else
            local pos = user:getpos()
            pos.y = math.floor(pos.y + 0.5)
            minetest.add_item(pos, "default:bucket")
         end

         local pos = pointed_thing.above
         if minetest.registered_nodes[minetest.get_node(pointed_thing.under).name].buildable_to then
            pos=pointed_thing.under
         end
         minetest.add_node(pos, {name = "default:swamp_water_source"})

         return itemstack
      end
})

minetest.register_craftitem(
   "default:bucket",
   {
      description = "Empty Bucket",
      inventory_image = "default_bucket.png",
      stack_max = 10,
      wield_scale = {x=1,y=1,z=2},
      liquids_pointable = true,
      on_use = function(itemstack, user, pointed_thing)
         if pointed_thing.type ~= "node" then return end

         local nodename=minetest.get_node(pointed_thing.under).name

         if nodename == "default:water_source" then
            itemstack:take_item()

            local inv=user:get_inventory()

            if inv:room_for_item("main", {name="default:bucket_water"}) then
               inv:add_item("main", "default:bucket_water")
            else
               local pos = user:getpos()
               pos.y = math.floor(pos.y + 0.5)
               minetest.add_item(pos, "default:bucket_water")
            end

            minetest.remove_node(pointed_thing.under)
         elseif nodename == "default:river_water_source" then
            itemstack:take_item()

            local inv=user:get_inventory()

            if inv:room_for_item("main", {name="default:bucket_river_water"}) then
               inv:add_item("main", "default:bucket_river_water")
            else
               local pos = user:getpos()
               pos.y = math.floor(pos.y + 0.5)
               minetest.add_item(pos, "default:bucket_river_water")
            end

            minetest.remove_node(pointed_thing.under)
         elseif nodename == "default:swamp_water_source" then
            itemstack:take_item()

            local inv=user:get_inventory()

            if inv:room_for_item("main", {name="default:bucket_swamp_water"}) then
               inv:add_item("main", "default:bucket_swamp_water")
            else
               local pos = user:getpos()
               pos.y = math.floor(pos.y + 0.5)
               minetest.add_item(pos, "default:bucket_swamp_water")
            end

            minetest.remove_node(pointed_thing.under)
         end

         return itemstack
      end

})


minetest.register_craftitem(
   "default:fertilizer",
   {
      description = "Fertilizer",
      inventory_image = "default_fertilizer_inventory.png",
      wield_scale = {x=1,y=1,z=2},
      on_place = function(itemstack, user, pointed_thing)
         local pos = pointed_thing.above

         local underdef = minetest.registered_nodes[minetest.get_node(pointed_thing.under).name]

         if underdef.groups then
            if underdef.groups.plantable_soil then
               minetest.remove_node(pos)
               minetest.set_node(pointed_thing.under, {name = "default:fertilized_dirt"})
            elseif underdef.groups.plantable_sandy then
               minetest.remove_node(pos)
               minetest.set_node(pointed_thing.under, {name = "default:fertilized_sand"})
            end
         end

         itemstack:take_item()

         return itemstack
      end,
})

default.log("craftitems", "loaded")
