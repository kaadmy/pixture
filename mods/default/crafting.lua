--
-- Crafting
--

-- Tools
minetest.register_craft(
   {
      output = "default:pick_wood",
      recipe = {
	 {"", "group:planks", "default:fiber"},
	 {"", "default:stick", "group:planks"},
	 {"default:stick", "", ""},
      }
   })

minetest.register_craft(
   {
      output = "default:pick_stone",
      recipe = {
	 {"", "group:stone", "default:fiber"},
	 {"", "default:stick", "group:stone"},
	 {"default:stick", "", ""},
      }
   })

minetest.register_craft(
   {
      output = "default:pick_steel",
      recipe = {
	 {"", "default:ingot_steel", "default:fiber"},
	 {"", "default:stick", "default:ingot_steel"},
	 {"default:stick", "", ""},
      }
   })

minetest.register_craft(
   {
      output = "default:pick_carbonsteel",
      recipe = {
	 {"", "default:ingot_carbonsteel", "default:fiber"},
	 {"", "default:stick", "default:ingot_carbonsteel"},
	 {"default:stick", "", ""},
      }
   })

minetest.register_craft(
   {
      output = "default:shovel_wood",
      recipe = {
	 {"", "group:planks", ""},
	 {"group:planks", "default:fiber", "group:planks"},
	 {"", "default:stick", ""},
      }
   })

minetest.register_craft(
   {


      output = "default:shovel_stone",
      recipe = {
	 {"", "group:stone", ""},
	 {"group:stone", "default:fiber", "group:stone"},
	 {"", "default:stick", ""},
      }
   })

minetest.register_craft(
   {
      output = "default:shovel_steel",
      recipe = {
	 {"", "default:ingot_steel", ""},
	 {"default:ingot_steel", "default:fiber", "default:ingot_steel"},
	 {"", "default:stick", ""},
      }
   })

minetest.register_craft(
   {
      output = "default:shovel_carbonsteel",
      recipe = {
	 {"", "default:ingot_carbonsteel", ""},
	 {"default:ingot_carbonsteel", "default:fiber", "default:ingot_carbonsteel"},
	 {"", "default:stick", ""},
      }
   })

minetest.register_craft(
   {
      output = "default:axe_wood",
      recipe = {
	 {"group:planks", "default:fiber"},
	 {"group:planks", "default:stick"},
	 {"", "default:stick"},
      }
   })

minetest.register_craft(
   {
      output = "default:axe_stone",
      recipe = {
	 {"group:stone", "default:fiber"},
	 {"group:stone", "default:stick"},
	 {"", "default:stick"},
      }
   })

minetest.register_craft(
   {
      output = "default:axe_steel",
      recipe = {
	 {"default:ingot_steel", "default:fiber"},
	 {"default:ingot_steel", "default:stick"},
	 {"", "default:stick"},
      }
   })

minetest.register_craft(
   {
      output = "default:axe_carbonsteel",
      recipe = {
	 {"default:ingot_carbonsteel", "default:fiber"},
	 {"default:ingot_carbonsteel", "default:stick"},
	 {"", "default:stick"},
      }
   })

minetest.register_craft(
   {
      output = "default:spear_wood",
      recipe = {
	 {"group:planks"},
	 {"default:fiber"},
	 {"default:stick"},
      }
   })

minetest.register_craft(
   {
      output = "default:spear_stone",
      recipe = {
	 {"group:stone"},
	 {"default:fiber"},
	 {"default:stick"},
      }
   })

minetest.register_craft(
   {
      output = "default:spear_steel",
      recipe = {
	 {"default:ingot_steel"},
	 {"default:fiber"},
	 {"default:stick"},
      }
   })

minetest.register_craft(
   {
      output = "default:spear_carbonsteel",
      recipe = {
	 {"default:ingot_carbonsteel"},
	 {"default:fiber"},
	 {"default:stick"},
      }
   })

-- Nodes

minetest.register_craft(
   {
      output = "default:dust_carbonsteel",
      type = "shapeless",
      recipe =  {"default:lump_coal", "default:lump_iron", "default:lump_iron"}
   })

minetest.register_craft(
   {
      output = "default:fiber",
      type = "shapeless",
      recipe = {
	 "default:grass"
      }
   })

minetest.register_craft(
   {
      output = "default:fiber 3",
      type = "shapeless",
      recipe = {
	 "group:leaves", "group:leaves", "group:leaves", "group:leaves"
      }
   })

minetest.register_craft(
   {
      output = "default:gravel",
      recipe = {
	 {"default:cobble"},
      }
   })

minetest.register_craft(
   {
      output = "default:bucket",
      recipe = {
	 {"default:fiber", "default:stick", "default:fiber"},
	 {"group:planks", "", "group:planks"},
	 {"group:planks", "group:planks", "group:planks"},
      }
   })

minetest.register_craft(
   {
      output = "default:brick",
      recipe = {
	 {"default:dirt", "default:gravel", "default:dirt"},
	 {"default:gravel", "default:dirt", "default:gravel"},
	 {"default:dirt", "default:gravel", "default:dirt"},
      }
   })
minetest.register_craft(
   {
      output = "default:block_steel",
      recipe = {
	 {"default:ingot_steel", "default:ingot_steel", "default:ingot_steel"},
	 {"default:ingot_steel", "default:ingot_steel", "default:ingot_steel"},
	 {"default:ingot_steel", "default:ingot_steel", "default:ingot_steel"},
      }
   })

minetest.register_craft(
   {
      output = "default:block_coal",
      recipe = {
	 {"default:lump_coal", "default:lump_coal", "default:lump_coal"},
	 {"default:lump_coal", "default:lump_coal", "default:lump_coal"},
	 {"default:lump_coal", "default:lump_coal", "default:lump_coal"},
      }
   })

minetest.register_craft(
   {
      output = "default:dirt_path 4",
      recipe = {
	 {"default:dirt", "default:dirt", "default:dirt"},
	 {"default:gravel", "default:gravel", "default:gravel"},
	 {"default:gravel", "default:gravel", "default:gravel"},
      }
   })

minetest.register_craft(
   {
      output = "default:heated_dirt_path 8",
      recipe = {
	 {"default:ingot_steel", "default:dirt_path", "default:ingot_steel"},
	 {"default:dirt_path", "default:dirt_path", "default:dirt_path"},
	 {"default:gravel", "default:gravel", "default:gravel"},
      }
   })

minetest.register_craft(
   {
      output = "default:planks 4",
      recipe = {
	 {"default:tree"},
      }
   })

minetest.register_craft(
   {
      output = "default:planks_oak 4",
      recipe = {
	 {"default:tree_oak"},
      }
   })

minetest.register_craft(
   {
      output = "default:planks_birch 4",
      recipe = {
	 {"default:tree_birch"},
      }
   })

minetest.register_craft(
   {
      output = "default:frame",
      recipe = {
	 {"default:fiber", "default:stick", "default:fiber"},
	 {"default:stick", "group:planks", "default:stick"},
	 {"default:fiber", "default:stick", "default:fiber"},
      }
   })

minetest.register_craft(
   {
      output = "default:reinforced_frame",
      recipe = {
	 {"default:fiber", "default:stick", "default:fiber"},
	 {"default:stick", "default:frame", "default:stick"},
	 {"default:fiber", "default:stick", "default:fiber"},
      }
   })

minetest.register_craft(
   {
      output = "default:stick 4",
      recipe = {
	 {"group:planks"},
      }
   })

minetest.register_craft(
   {
      output = "default:fence 4",
      recipe = {
	 {"default:stick", "", "default:stick"},
	 {"default:fiber", "group:planks", "default:fiber"},
	 {"default:stick", "", "default:stick"},
      }
   })

minetest.register_craft(
   {
      output = "default:sign 2",
      recipe = {
	 {"group:planks", "default:fiber", "group:planks"},
	 {"group:planks", "group:planks", "group:planks"},
	 {"", "default:stick", ""},
      }
   })

minetest.register_craft(
   {
      output = "default:reinforced_cobble",
      recipe = {
	 {"default:fiber", "default:stick", "default:fiber"},
	 {"default:stick", "default:cobble", "default:stick"},
	 {"default:fiber", "default:stick", "default:fiber"},
      }
   })

minetest.register_craft(
   {
      output = "default:torch 4",
      recipe = {
	 {"default:lump_coal"},
	 {"default:fiber"},
	 {"default:stick"},
      }
   })

minetest.register_craft(
   {
      output = "default:chest",
      recipe = {
	 {"group:planks", "group:planks", "group:planks"},
	 {"group:planks", "default:fiber", "group:planks"},
	 {"group:planks", "group:planks", "group:planks"},
      }
   })

minetest.register_craft(
   {
      output = "default:chest_locked",
      recipe = {
	 {"default:fiber", "default:stick", "default:fiber"},
	 {"default:stick", "default:chest", "default:stick"},
	 {"default:fiber", "default:ingot_steel", "default:fiber"},
      }
   })

minetest.register_craft(
   {
      output = "default:furnace",
      recipe = {
	 {"group:stone", "group:stone", "group:stone"},
	 {"group:stone", "", "group:stone"},
	 {"group:stone", "group:stone", "group:stone"},
      }
   })

minetest.register_craft(   
   {
      output = "default:sandstone 2",
      recipe = {
	 {"default:sand", "default:sand"},
	 {"default:sand", "default:sand"},
      }
   })

minetest.register_craft(
   {
      output = "default:paper",
      recipe = {
	 {"default:papyrus", "default:papyrus", "default:papyrus"},
      }
   })

minetest.register_craft(
   {
      output = "default:book",
      recipe = {
	 {"default:fiber", "default:stick", "default:paper"},
	 {"default:fiber", "default:stick", "default:paper"},
	 {"default:fiber", "default:stick", "default:paper"},
      }
   })

minetest.register_craft(
   {
      output = "default:bookshelf",
      recipe = {
	 {"group:planks", "group:planks", "group:planks"},
	 {"default:book", "default:book", "default:book"},
	 {"group:planks", "group:planks", "group:planks"},
      }
   })

minetest.register_craft(
   {
      output = "default:ladder 2",
      recipe = {
	 {"default:stick", "", "default:stick"},
	 {"default:fiber", "default:stick", "default:fiber"},
	 {"default:stick", "", "default:stick"},
      }
   })

--
-- Crafting (tool repair)
--
minetest.register_craft(
   {
      type = "toolrepair",
      additional_wear = -0.1,
   })

--
-- Cooking recipes
--

minetest.register_craft(
   {
      type = "cooking",
      output = "default:glass",
      recipe = "default:sand",
      cooktime = 3,
   })

minetest.register_craft(
   {
      type = "cooking",
      output = "default:lump_coal",
      recipe = "default:tree",
      cooktime = 4,
   })

minetest.register_craft(
   {
      type = "cooking",
      output = "default:stone",
      recipe = "default:cobble",
      cooktime = 6,
   })

minetest.register_craft(
   {
      type = "cooking",
      output = "default:ingot_steel",
      recipe = "default:lump_iron",
      cooktime = 3,
   })

minetest.register_craft(
   {
      type = "cooking",
      output = "default:ingot_carbonsteel",
      recipe = "default:dust_carbonsteel",
      cooktime = 5,
   })

minetest.register_craft(
   {
      type = "cooking",
      output = "default:lump_sugar",
      recipe = "default:papyrus",
      cooktime = 7,
   })

--
-- Fuels
--

minetest.register_craft(
   {
      type = "fuel",
      recipe = "group:tree",
      burntime = 20,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "group:planks",
      burntime = 9,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:planks_oak",
      burntime = 12,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:planks_birch",
      burntime = 12,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:frame",
      burntime = 12,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:reinforced_frame",
      burntime = 17,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "group:leaves",
      burntime = 1,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:cactus",
      burntime = 10,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:papyrus",
      burntime = 2,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:bookshelf",
      burntime = 30,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:fence",
      burntime = 10,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:ladder",
      burntime = 5,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "group:planks",
      burntime = 5,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:torch",
      burntime = 5,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:sign",
      burntime = 10,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:chest",
      burntime = 20,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "group:sapling",
      burntime = 7,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:apple",
      burntime = 3,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:lump_coal",
      burntime = 30,
   })

minetest.register_craft(
   {
      type = "fuel",
      recipe = "default:block_coal",
      burntime = 270,
   })

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
   "default:bucket_water",
   {
      description = "Water Bucket",
      inventory_image = "default_bucket_water.png",
      stack_max = 1,
      wield_scale = {x=1,y=1,z=2},
      liquids_pointable = true,
      on_place = function(itemstack, user, pointed_thing)
		    if pointed_thing.type ~= "node" then return end

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
   "default:bucket",
   {
      description = "Empty Bucket",
      inventory_image = "default_bucket.png",
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
		  end

		  return itemstack
	       end
      
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
      description = "Sugar lump",
      inventory_image = "default_lump_sugar.png",
      on_use = minetest.item_eat({hp = 1, sat = 10})
   })

default.log("crafting", "loaded")