--
-- Bed mod
-- By PilzAdam, thefamilygrog66
-- Tweaked by Kaadmy, for Pixture
--

local players_in_bed = {}

minetest.register_node(
   "bed:bed_foot",
   {
      description = "Bed",
      drawtype = "nodebox",
      paramtype = "light",
      paramtype2 = "facedir",
      sunlight_propagates = true,
      wield_image = "bed_bed_inventory.png",
      inventory_image = "bed_bed_inventory.png",
      tiles = {"bed_foot.png", "default_wood.png", "bed_side.png"},
      groups = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
      sounds = default.node_sound_wood_defaults(),
      node_box = {
	 type = "fixed",
	 fixed = {-0.5, -0.5, -0.5, 0.5, 2/16, 0.5}
      },
      selection_box = {
	 type = "fixed",
	 fixed = {-0.5, -0.5, -0.5, 0.5, 2/16, 1.5}
      },

      after_place_node = function(pos)
			    local node = minetest.get_node(pos)
			    local dir = minetest.facedir_to_dir(node.param2)
			    local head_pos = vector.add(pos, dir)
			    node.name = "bed:bed_head"
			    if minetest.registered_nodes[minetest.get_node(head_pos).name].buildable_to then
			       minetest.set_node(head_pos, node)
			    else
			       minetest.remove_node(pos)
			    end
			 end,

      on_destruct = function(pos)
		       local node = minetest.get_node(pos)
		       local dir = minetest.facedir_to_dir(node.param2)
		       local head_pos = vector.add(pos, dir)
		       if minetest.get_node(head_pos).name == "bed:bed_head" then
			  minetest.remove_node(head_pos)
		       end
		    end,

      on_rightclick = function(pos, node, clicker)
			 if not clicker:is_player() or not minetest.setting_getbool("bed_enabled") then
			    return
			 end

			 local name = clicker:get_player_name()
			 local meta = minetest.get_meta(pos)
			 local put_pos = vector.add(pos, vector.divide(minetest.facedir_to_dir(node.param2), 2))

			 if clicker:get_player_name() == meta:get_string("player") then
			    put_pos.y = put_pos.y - 0.5

			    clicker:setpos(put_pos)
			    player_effects.remove_effect(clicker, "inbed")
			    clicker:set_eye_offset(vector.new(0, 0, 0), vector.new(0, 0, 0))
			    clicker:set_local_animation({x=0, y=79}, {x=168, y=187}, {x=189, y=198}, {x=200, y=219}, 30)
			    default.player_set_animation(clicker, "stand", 30)

			    players_in_bed[name] = nil
			    default.player_attached[name] = false

			    meta:set_string("player", "")
			 elseif meta:get_string("player") == "" and not default.player_attached[name] and players_in_bed[name] == nil then
			    put_pos.y = put_pos.y + 0.6

			    clicker:setpos(put_pos)
			    player_effects.apply_effect(clicker, "inbed")
			    clicker:set_eye_offset(vector.new(0, -13, 0), vector.new(0, -13, 0))
			    clicker:set_local_animation({x=162, y=166}, {x=162, y=166}, {x=162, y=166}, {x=162, y=168}, 30)
			    default.player_set_animation(clicker, "lay", 30)

			    if node.param2 == 2 then
			       clicker:set_look_yaw(0)
			    else
			       clicker:set_look_yaw(node.param2 / 2 * math.pi)
			    end

			    players_in_bed[name] = true
			    default.player_attached[name] = true

			    meta:set_string("player", name)
			 end
		      end,

      can_dig = function(pos)
		   return minetest.get_meta(pos):get_string("player") == ""
		end
   })

minetest.register_node(
   "bed:bed_head",
   {
      drawtype = "nodebox",
      paramtype = "light",
      paramtype2 = "facedir",
      pointable = false,
      tiles = {"bed_head.png", "default_wood.png", "bed_side.png"},
      groups = {snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
      sounds = default.node_sound_wood_defaults(),
      node_box = {
	 type = "fixed",
	 fixed = {-0.5, -0.5, -0.5, 0.5, 2/16, 0.5}
      }
   })

minetest.register_alias("bed:bed", "bed:bed_foot")

minetest.register_craft(
   {
      output = "bed:bed",
      recipe = {
	 {"group:fuzzy", "group:fuzzy", "group:fuzzy"},
	 {"group:planks", "group:planks", "group:planks"}
      }
   })

bed_player_spawns = {}

local file = io.open(minetest.get_worldpath().."/bed.dat", "r")
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

      local sleeping_players = 0
      for _, i in pairs(players_in_bed) do
	 if i then
	    sleeping_players = sleeping_players + 1
	 end
      end

      local players = #minetest.get_connected_players()
      if players > 0 and players * 0.5 < sleeping_players then
	 if minetest.get_timeofday() < 0.2 or minetest.get_timeofday() > 0.8 then
	    if not wait then
	       minetest.chat_send_all("[zzz] "..sleeping_players.." of "..players.." players slept, skipping to day.")

	       wait = true
	       minetest.after(2, function()
				    minetest.set_timeofday(0.23)
				    wait = false
				 end)

	       for _, player in ipairs(minetest.get_connected_players()) do
		  bed_player_spawns[player:get_player_name()] = player:getpos()
	       end

	       local file = io.open(minetest.get_worldpath().."/bed.dat", "w")
	       file:write(minetest.serialize(bed_player_spawns))
	       file:close()
	    end
	 end
      end
   end)

player_effects.register_effect(
   "inbed",
   {
      title = "In bed",
      description = "If you're in a bed",
      duration = -1,
      physics = {
	 speed = 0,
	 jump = 0,
	 gravity = 0,
      }
   })

minetest.register_on_respawnplayer(
   function(player)
      local name = player:get_player_name()
      if bed_player_spawns[name] then
	 player:setpos(bed_player_spawns[name])
      end
   end)

minetest.register_on_leaveplayer(
   function(player)
      players_in_bed[player:get_player_name()] = nil
   end)

-- Achievements

achievements.register_achievement(
   "bedtime",
   {
      title = "Bed Time",
      description = "Craft a bed",
      times = 1,
      craftitem = "bed:bed_foot",
   })

default.log("mod:bed", "loaded")
