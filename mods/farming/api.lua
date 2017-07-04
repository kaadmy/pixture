
--
-- Farming and plant growing API
--

farming.registered_plants = {}

function farming.register_plant(name, plant)
   -- Note: You'll have to register 4 plant growing nodes before calling this!
   -- Format: "[mod:plant]_[stage from 1-4]"

   farming.registered_plants[name] = plant -- Might need to fully copy here?

   minetest.register_lbm(
      {
         label = "Grow legacy farming plants",
         name = "farming:grow_legacy_plants",

	 nodenames = {
	    name .. "_1",
	    name .. "_2",
	    name .. "_3",
	 },

	 action = function(pos, node)
            farming.grow_plant(pos, name)
         end,
      }
   )

   local function add_callbacks(nodename)
      minetest.override_item(
         nodename,
         {
            on_timer = function(pos)
               local name = string.gsub(minetest.get_node(pos).name, "_(%d+)", "")

               farming.grow_plant(pos, name)
            end,

            on_construct = function(pos)
               farming.begin_growing_plant(pos)
            end,

            on_place = farming.place_plant,
         }
      )
   end

   add_callbacks(name .. "_1")
   add_callbacks(name .. "_2")
   add_callbacks(name .. "_3")
end

function farming.begin_growing_plant(pos)
   local name = string.gsub(minetest.get_node(pos).name, "_(%d+)", "")

   local plant = farming.registered_plants[name]

   minetest.get_node_timer(pos):start(
      math.random(plant.grow_time / 8, plant.grow_time / 4))
end

function farming.place_plant(itemstack, placer, pointed_thing)
   local name = string.gsub(itemstack:get_name(), "_(%d+)", "")

   local plant = farming.registered_plants[name]

   local under = minetest.get_node(pointed_thing.under)

   for _, can_grow_on in ipairs(plant.grows_on) do
      local group = string.match(can_grow_on, "group:(.*)")

      if (group ~= nil and minetest.get_item_group(under.name, group) > 0) or
      (under.name == can_grow_on) then
         minetest.set_node(pointed_thing.above, {name = itemstack:get_name()})

         itemstack:take_item()

         break
      end
   end

   return itemstack
end

function farming.next_stage(pos, under, underdef, name, plant)
   local my_node = minetest.get_node(pos)

   if my_node.name == name .. "_1" then
      minetest.set_node(pos, {name = name .. "_2"})
   elseif my_node.name == name .. "_2" then
      minetest.set_node(pos, {name = name .. "_3"})
   elseif my_node.name == name .. "_3" then
      minetest.set_node(pos, {name = name .. "_4"})

      -- Stop the timer on the node so no more growing occurs until needed

      minetest.get_node_timer(pos):stop()
   end
end

function farming.grow_plant(pos, name)
   local plant = farming.registered_plants[name]

   -- Check nearby nodes such as water

   local my_node = minetest.get_node(pos)

   if plant.grows_near and
   minetest.find_node_near(pos, plant.growing_distance, plant.grows_near) == nil then
      return
   end

   -- Check light; if too dark check again soon

   local light = minetest.get_node_light(pos)

   if light ~= nil and (light < plant.light_min or light > plant.light_max) then
      minetest.get_node_timer(pos):start(
         math.random(plant.grow_time / 16, plant.grow_time / 4))

      return
   end

   -- Grow and check for rain and fertilizer

   local under = minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z})
   local underdef = minetest.registered_nodes[under.name]

   farming.next_stage(pos, under, underdef, name, plant)

   if minetest.get_item_group(under.name, "plantable_fertilizer") > 0 then
      farming.next_stage(pos, under, underdef, name, plant)
   end

   if weather.weather == "storm" then
      farming.next_stage(pos, under, underdefname, plant)
   end
end

default.log("api", "loaded")
