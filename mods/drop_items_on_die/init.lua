--
-- Drop items on die mod
-- By Kaadmy, for Pixture
--

drop_items_on_die = {}

drop_items_on_die.registered_listnames = {}

local enable_drop = minetest.settings:get_bool("drop_items_on_die") or false

function drop_items_on_die.register_listname(listname)
   table.insert(drop_items_on_die.registered_listnames, listname)
end

local function on_die(player)
   local pos = player:getpos()

   local inv = player:get_inventory()

   for _, listname in ipairs(drop_items_on_die.registered_listnames) do
      for i = 1, inv:get_size(listname) do
         local item = inv:get_stack(listname, i)

         local rpos = {
            x = pos.x + math.random(-0.3, 0.3),
            y = pos.y,
            z = pos.z + math.random(-0.3, 0.3)
         }

         local drop = minetest.add_item(rpos, item)

         if drop ~= nil then
            local x = math.random(1, 5)
            if math.random(1, 2) == 1 then
               x = -x
            end
            local z = math.random(1, 5)
            if math.random(1, 2) == 1 then
               z = -z
            end

            drop:setvelocity({x = 1 / x, y = drop:getvelocity().y, z = 1 / z})
         end

         item:clear()

         inv:set_stack(listname, i, item)
      end
   end
end

if enable_drop then
   minetest.register_on_dieplayer(on_die)

   drop_items_on_die.register_listname("main")
end

default.log("mod:drop_items_on_die", "loaded")
