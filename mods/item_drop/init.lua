--
-- Item drop mod
-- By PilzAdam
-- Tweaked by Kaadmy, for Pixture
--

local function valid(object)
   return object:get_luaentity().timer ~= nil and object:get_luaentity().timer > 1
end

minetest.register_globalstep(
   function(dtime)
      for _,player in ipairs(minetest.get_connected_players()) do
	 if player:get_hp() > 0 or not minetest.setting_getbool("enable_damage") then
	    local pos = player:getpos()
	    local inv = player:get_inventory()
	    
	    for _,object in ipairs(minetest.get_objects_inside_radius(pos, 0.5)) do
	       if not object:is_player() and object:get_luaentity() and object:get_luaentity().name == "__builtin:item" and valid(object) then
		  if inv and inv:room_for_item("main", ItemStack(object:get_luaentity().itemstring)) then
		     inv:add_item("main", ItemStack(object:get_luaentity().itemstring))
		     if object:get_luaentity().itemstring ~= "" then
			minetest.sound_play("item_drop_pickup", {pos = pos, gain = 0.1, max_hear_distance = 8})
		     end
		     object:get_luaentity().itemstring = ""
		     object:remove()
		  end
	       end
	    end

	    for _,object in ipairs(minetest.get_objects_inside_radius(pos, 1.25)) do
	       if not object:is_player() and object:get_luaentity() and object:get_luaentity().name == "__builtin:item" and valid(object) then
		  if inv and inv:room_for_item("main", ItemStack(object:get_luaentity().itemstring)) then
		     local pos1 = pos
		     pos1.y = pos1.y+0.2
		     local pos2 = object:getpos()
		     local vec = vector.normalize({x=pos1.x-pos2.x, y=pos1.y-pos2.y, z=pos1.z-pos2.z})
		     vec.x = vec.x*3
		     vec.y = vec.y*3
		     vec.z = vec.z*3
		     object:setvelocity(vec)
		     object:get_luaentity().physical_state = false
		     object:get_luaentity().object:set_properties(
			{
			   physical = false
			})

		     minetest.after(
			1,
			function(args)
			   local lua = object:get_luaentity()
			   if object == nil or lua == nil or lua.itemstring == nil then
			      return
			   end
			   if inv:room_for_item("main", ItemStack(object:get_luaentity().itemstring)) then
			      inv:add_item("main", ItemStack(object:get_luaentity().itemstring))
			      if object:get_luaentity().itemstring ~= "" then
				 minetest.sound_play("item_drop_pickup", {pos = pos, gain = 0.3, max_hear_distance = 16})
			      end
			      object:get_luaentity().itemstring = ""
			      object:remove()
			   else
			      object:setvelocity({x = 0, y = 0, z = 0})
			      object:get_luaentity().physical_state = true
			      object:get_luaentity().object:set_properties(
				 {
				    physical = true
				 })
			   end
			end, {player, object})

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
	    if minetest.setting_get("remove_items") and tonumber(minetest.setting_get("remove_items")) then
	       minetest.after(tonumber(minetest.setting_get("remove_items")), function(obj)
										 obj:remove()
									      end, obj)
	    end
	 end
      end
   end
end

default.log("mod:item_drop", "loaded")