--
-- Farming mod
-- By Kaadmy, for Pixture
--

farming={}

grow_plant=function(pos, name, plant)
   local my_node = minetest.get_node(pos)

   if minetest.find_node_near(pos, plant.growing_distance, plant.grows_near) == nil then
      return
   end

   local light=minetest.get_node_light(pos)

   if light ~= nil and (light < plant.light_min or light > plant.light_max) then return end

   local on_node = minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z})
   
   for _,can_grow_on in ipairs(plant.grows_on) do
      if on_node.name == can_grow_on then
	 if my_node.name == "farming:"..name.."_1" then
	    minetest.set_node(pos, {name = "farming:"..name.."_2"})
	 elseif my_node.name == "farming:"..name.."_2" then
	    minetest.set_node(pos, {name = "farming:"..name.."_3"})
	 elseif my_node.name == "farming:"..name.."_3" then
	    minetest.set_node(pos, {name = "farming:"..name.."_4"})
	 end

	 break
      end
   end
end

farming.register_plant=function(name, plant)
			  -- note: you'll have to register 4
			  -- plant growing nodes before calling this!
			  --
			  -- format: "farming:[plant name]_[stage from 1-4]"
			  minetest.register_abm(
			     {
				nodenames = {
				   "farming:"..name.."_1",
				   "farming:"..name.."_2",
				   "farming:"..name.."_3",
				},
				neighbors = plant.grows_on,
				interval = 1,
				chance = plant.grow_time/4,
				action = function(pos, node, active_object_count, active_object_count_wider)
					    grow_plant(pos, name, plant)
					    if weather == "storm" then
					       grow_plant(pos, name, plant)
					    end
					 end
			     })
		       end

dofile(minetest.get_modpath("farming").."/nodes.lua")
dofile(minetest.get_modpath("farming").."/plants.lua")
dofile(minetest.get_modpath("farming").."/craft.lua")

default.log("mod:farming", "loaded")