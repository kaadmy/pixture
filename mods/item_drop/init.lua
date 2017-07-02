
--
-- Item drop mod
-- By PilzAdam
-- Tweaked by Kaadmy, for Pixture
--

item_drop = {}

function item_drop.drop_item(pos, itemstack)
   local rpos = {
      x = pos.x + math.random(-0.3, 0.3),
      y = pos.y,
      z = pos.z + math.random(-0.3, 0.3)
   }

   local drop = minetest.add_item(rpos, itemstack)

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
end

local function valid(object)
   return object:get_luaentity().timer ~= nil and object:get_luaentity().timer > 1
end

minetest.register_globalstep(
   function(dtime)
      for _,player in ipairs(minetest.get_connected_players()) do
	 if player:get_hp() > 0 or not minetest.settings:get_bool("enable_damage") then
	    local pos = player:getpos()
	    local inv = player:get_inventory()

            local in_radius = minetest.get_objects_inside_radius(pos, 6.0)

	    for _,object in ipairs(in_radius) do
	       if not object:is_player() and object:get_luaentity()
               and object:get_luaentity().name == "__builtin:item" and valid(object) then
                  local pos1 = pos

                  pos1.y = pos1.y + 0.2

                  local pos2 = object:getpos()

                  local vec = {
                     x = pos1.x - pos2.x,
                     y = pos1.y - pos2.y,
                     z = pos1.z - pos2.z
                  }

                  local len = vector.length(vec)

                  if len < 1.35 then
                     if inv and inv:room_for_item("main", ItemStack(object:get_luaentity().itemstring)) then
                        if len > 0.5 then
                           vec = vector.divide(vec, len) -- It's a normalize but we have len yet (vector.normalize(vec))

                           vec.x = vec.x*3
                           vec.y = vec.y*3
                           vec.z = vec.z*3

                           object:setvelocity(vec)

                           object:get_luaentity().physical_state = false

                           object:get_luaentity().object:set_properties({physical = false})
                        else
                           local lua = object:get_luaentity()

                           if object == nil or lua == nil or lua.itemstring == nil then
                              return
                           end

                           if inv:room_for_item("main", ItemStack(lua.itemstring)) then
                              inv:add_item("main", ItemStack(lua.itemstring))

                              if lua.itemstring ~= "" then
                                 minetest.sound_play(
                                    "item_drop_pickup",
                                    {
                                       pos = pos,
                                       gain = 0.3,
                                       max_hear_distance = 16
                                 })
                              end

                              lua.itemstring = ""
                              object:remove()
                           end
                        end
                     end
                  else
                     object:setvelocity({x = 0, y = object:getvelocity().y, z = 0})

                     object:get_luaentity().physical_state = true

                     object:get_luaentity().object:set_properties({physical = true})
                  end
               end
            end
         end
      end
end)

function minetest.handle_node_drops(pos, drops, digger)
   for _,item in ipairs(drops) do
      local count, name
      if type(item) == "string" then
	 count = 1
	 name = item
      else
	 count = item:get_count()
	 name = item:get_name()
      end
      for i=1,count do
	 local obj = minetest.add_item(pos, name)
	 if obj ~= nil then
	    local x = math.random(1, 5)
	    if math.random(1,2) == 1 then
	       x = -x
	    end
	    local z = math.random(1, 5)
	    if math.random(1,2) == 1 then
	       z = -z
	    end
	    obj:setvelocity({x=1/x, y=obj:getvelocity().y, z=1/z})

	    -- FIXME this doesnt work for deactiveted objects
	    if minetest.settings:get("remove_items") and tonumber(minetest.settings:get("remove_items")) then
	       minetest.after(tonumber(minetest.settings:get("remove_items")), function(obj)
                                 obj:remove()
									      end, obj)
	    end
	 end
      end
   end
end

default.log("mod:item_drop", "loaded")
