--
-- Farming mod
-- By Kaadmy, for Pixture
--

farming = {}

function farming.grow_plant(pos, name, plant)
   local my_node = minetest.get_node(pos)

   if minetest.find_node_near(pos, plant.growing_distance, plant.grows_near) == nil then return end

   local light = minetest.get_node_light(pos)
   if light ~= nil and (light < plant.light_min or light > plant.light_max) then return end

   local on_node = minetest.get_node({x = pos.x, y = pos.y-1, z = pos.z})
   local on_nodedef = minetest.registered_nodes[on_node.name]

   for _, can_grow_on in ipairs(plant.grows_on) do
      local group = string.match(can_grow_on, "group:(.*)")

      if (group ~= nil and on_nodedef.groups[group]) or (on_node.name == can_grow_on) then
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

function farming.register_plant(name, plant)
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
	 neighbors = plant.grows_on, -- checked later anyway, but also check neighbors in C++ code for performance
	 interval = 1,
	 chance = plant.grow_time / 4,
	 action = function(pos, node, active_object_count, active_object_count_wider)
		     farming.grow_plant(pos, name, plant)

		     local underdef = minetest.registered_nodes[minetest.get_node({x = pos.x, y = pos.y-1, z = pos.z}).name]

		     if under.groups and under.groups.plantable_fertilizer then
			print("Fertilizer!")
			farming.grow_plant(pos, name, plant)
		     end

		     if weather.weather == "storm" then
			farming.grow_plant(pos, name, plant)
		     end
		  end
      })
end

dofile(minetest.get_modpath("farming").."/nodes.lua")
dofile(minetest.get_modpath("farming").."/plants.lua")
dofile(minetest.get_modpath("farming").."/craft.lua")

default.log("mod:farming", "loaded")