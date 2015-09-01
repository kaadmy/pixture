--
-- Bed mod
-- By PilzAdam, thefamilygrog66
-- Tweaked by Kaadmy, for Pixture
--

local players_in_bed = 0

minetest.register_node(
   "bed:bed_foot",
   {
      description = "Bed",
      drawtype = "nodebox",
      tiles = {"bed_foot.png", "default_wood.png", "bed_side.png"},
      inventory_image = "bed_bed_inventory.png",
      wield_image = "bed_bed_inventory.png",
      sunlight_propagates = true,
      paramtype = "light",
      paramtype2 = "facedir",
      groups = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
      sounds = default.node_sound_wood_defaults(),
      node_box = {
	 type = "fixed",
	 fixed = {
	    {-0.5, -0.5, -0.5, 0.5, 2/16, 0.5},
	 }
      },
      selection_box = {
	 type = "fixed",
	 fixed = {
	    {-0.5, -0.5, -0.5, 0.5, 2/16, 1.5},
	 }
      },
      after_place_node = function(pos, placer, itemstack)
			    local node = minetest.env:get_node(pos)
			    local p = {x = pos.x, y = pos.y, z = pos.z}
			    local param2 = node.param2
			    node.name = "bed:bed_head"
			    if param2 == 0 then
			       pos.z = pos.z + 1
			    elseif param2 == 1 then
			       pos.x = pos.x + 1
			    elseif param2 == 2 then
			       pos.z = pos.z - 1
			    elseif param2 == 3 then
			       pos.x = pos.x - 1
			    end
			    if minetest.registered_nodes[minetest.env:get_node(pos).name].buildable_to then
			       minetest.env:set_node(pos, node)
			    else
			       minetest.env:remove_node(p)
			       return true
			    end
			 end,
      
      on_destruct = function(pos)
		       local node = minetest.env:get_node(pos)
		       local param2 = node.param2
		       if param2 == 0 then
			  pos.z = pos.z+1
		       elseif param2 == 1 then
			  pos.x = pos.x+1
		       elseif param2 == 2 then
			  pos.z = pos.z-1
		       elseif param2 == 3 then
			  pos.x = pos.x-1
		       end
		       if (minetest.env:get_node({x = pos.x, y = pos.y, z = pos.z}).name == "bed:bed_head") then
			  if (minetest.env:get_node({x = pos.x, y = pos.y, z = pos.z}).param2 == param2) then
			     minetest.env:remove_node(pos)
			  end	
		       end
		    end,
      
      on_rightclick =function(pos, node, clicker)
			if not clicker:is_player()
			or not minetest.is_singleplayer()
		     and not minetest.setting_getbool("bed_enabled") then return end
		  
		  local meta = minetest.env:get_meta(pos)
		  local param2 = node.param2
		  if param2 == 0 then
		     pos.z = pos.z + 0.5
		  elseif param2 == 1 then
		     pos.x = pos.x + 0.5
		  elseif param2 == 2 then
		     pos.z = pos.z - 0.5
		  elseif param2 == 3 then
		     pos.x = pos.x - 0.5
		  end
		  
		  if clicker:get_player_name() == meta:get_string("player") then
		     if param2 == 0 then
			pos.x = pos.x - 1
		     elseif param2 == 1 then
			pos.z = pos.z + 1
		     elseif param2 == 2 then
			pos.x = pos.x + 1
		     elseif param2 == 3 then
			pos.z = pos.z - 1
		     end
		     clicker:set_physics_override({speed = 1.0, jump = 1.0, sneak = true})
		     pos.y = pos.y - 0.5
		     clicker:setpos(pos)
		     clicker:set_eye_offset({x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0})
		     meta:set_string("player", "")
		     players_in_bed = players_in_bed - 1
		     default.player_attached[clicker:get_player_name()] = false
		     clicker:set_local_animation({x=0, y=79}, {x=168, y=187}, {x=189, y=198}, {x=200, y=219}, 30)
		     default.player_set_animation(clicker, "stand", 30)
		  elseif meta:get_string("player") == "" then
		     default.player_attached[clicker:get_player_name()] = true
		     clicker:set_local_animation({x=162, y=166}, {x=162, y=166}, {x=162, y=166}, {x=162, y=168}, 30)
		     default.player_set_animation(clicker, "lay", 30)
		     clicker:set_physics_override({speed = 0.0, jump = 0.0, sneak = false})
		     pos.y = pos.y + 0.5625
		     clicker:setpos(pos)
		     clicker:set_eye_offset({x = 0, y = -13, z = 0}, {x = 0, y = -13, z = 0})
		     if param2 == 0 then
			clicker:set_look_yaw(math.pi)
		     elseif param2 == 1 then
			clicker:set_look_yaw(0.5 * math.pi)
		     elseif param2 == 2 then
			clicker:set_look_yaw(0)
		     elseif param2 == 3 then
			clicker:set_look_yaw(1.5 * math.pi)
		     end
		     
		     meta:set_string("player", clicker:get_player_name())
		     players_in_bed = players_in_bed + 1
		  end
	       end
   })

minetest.register_node(
   "bed:bed_head",
   {
      drawtype = "nodebox",
      tiles = {"bed_head.png", "default_wood.png", "bed_side.png"},
      paramtype = "light",
      paramtype2 = "facedir",
      groups = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
      sounds = default.node_sound_wood_defaults(),
      node_box = {
	 type = "fixed",
	 fixed = {
	    {-0.5, -0.5, -0.5, 0.5, 2/16, 0.5},
	 }
      },
      selection_box = {type = "fixed", fixed = {{0, 0, 0, 0, 0, 0},}},
   })

minetest.register_alias("bed:bed", "bed:bed_foot")

minetest.register_craft(
   {
      output = "bed:bed",
      recipe = {
	 {"group:fuzzy", "group:fuzzy", "group:fuzzy"},
	 {"group:planks", "group:planks", "group:planks"},
      }
   })

bed_player_spawns = {}

local file = io.open(minetest.get_worldpath().."/bed.txt", "r")
if file then
   bed_player_spawns = minetest.deserialize(file:read("*all"))
   file:close()
end

local timer = 0
local wait = false

minetest.register_globalstep(
   function(dtime)
      if timer < 2 then
	 timer = timer + dtime
	 return
      end
      timer = 0
      
      local players = #minetest.get_connected_players()
      if players ~= 0 and players * 0.5 < players_in_bed then
	 if minetest.env:get_timeofday() < 0.2 or minetest.env:get_timeofday() > 0.8 then
	    if not wait then
	       minetest.chat_send_all("[zzz] " .. players_in_bed .. " of " .. players .. " players slept, skipping to day.")
	       minetest.after(2, function()
				    minetest.env:set_timeofday(0.23)
				    wait = false
				 end)
	       wait = true
	       for _,player in ipairs(minetest.get_connected_players()) do
		  bed_player_spawns[player:get_player_name()] = player:getpos()
	       end
	       local file = io.open(minetest.get_worldpath().."/bed.txt", "w")
	       if file then
		  file:write(minetest.serialize(bed_player_spawns))
		  file:close()
	       end
	    end
	 end
      end
   end)

minetest.register_on_respawnplayer(
   function(player)
      local name = player:get_player_name()
      if bed_player_spawns[name] then
	 player:setpos(bed_player_spawns[name])
	 return true
      end
   end)

default.log("mod:bed", "loaded")