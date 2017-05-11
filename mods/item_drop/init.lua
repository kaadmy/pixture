--
-- Item drop mod
-- By PilzAdam
-- Tweaked by Kaadmy, for Pixture
--

local function valid(object)
   return object:get_luaentity().timer ~= nil and object:get_luaentity().timer > 1
end

core.register_globalstep(
   function(dtime)
      for _,player in ipairs(core.get_connected_players()) do
	 if player:get_hp() > 0 or not core.setting_getbool("enable_damage") then
	    local pos = player:getpos()
	    local inv = player:get_inventory()
	    
	    for _,object in ipairs(core.get_objects_inside_radius(pos, 1.35)) do
	       if not object:is_player() and object:get_luaentity() and object:get_luaentity().name == "__builtin:item" and valid(object) then
		  if inv and inv:room_for_item("main", ItemStack(object:get_luaentity().itemstring)) then
		     local pos1 = pos
		     pos1.y = pos1.y+0.2
		     local pos2 = object:getpos()
			local vec = {x=pos1.x-pos2.x, y=pos1.y-pos2.y, z=pos1.z-pos2.z}
			local len = vector.length(vec)
			if len > 0.5 then
				vec = vector.divide(vec, len) -- it's a normalize but we have len yet (vector.normalize(vec))
			     vec.x = vec.x*3
			     vec.y = vec.y*3
			     vec.z = vec.z*3
		     	object:setvelocity(vec)
			     object:get_luaentity().physical_state = false
			     object:get_luaentity().object:set_properties(
				{
				   physical = false
				})
			else
			   local lua = object:get_luaentity()
			   if object == nil or lua == nil or lua.itemstring == nil then
			      return
			   end
			   if inv:room_for_item("main", ItemStack(lua.itemstring)) then
			      inv:add_item("main", ItemStack(lua.itemstring))
			      if lua.itemstring ~= "" then
				 core.sound_play("item_drop_pickup", {pos = pos, gain = 0.3, max_hear_distance = 16})
			      end
			      lua.itemstring = ""
			      object:remove()
			   else
			      object:setvelocity({x = 0, y = 0, z = 0})
			      lua.physical_state = true
			      lua.object:set_properties(
				 {
				    physical = true
				 })
			   end
			end
		  end
	       end
	    end
	 end
      end
   end)

function core.handle_node_drops(pos, drops, digger)
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
	 local obj = core.add_item(pos, name)
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
	    if core.setting_get("remove_items") and tonumber(core.setting_get("remove_items")) then
	       core.after(tonumber(core.setting_get("remove_items")), function(obj)
										 obj:remove()
									      end, obj)
	    end
	 end
      end
   end
end

default.log("mod:item_drop", "loaded")
