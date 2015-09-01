--
-- Door mod
-- By Kaadmy, for Pixture
--

door = {}

-- Registers a door
function door.register_door(name, def)
   def.groups.not_in_creative_inventory = 1

   local box = {{-0.5, -0.5, -0.5, 0.5, 0.5, -0.5+1.5/16}}

   if not def.node_box_bottom then
      def.node_box_bottom = box
   end
   if not def.node_box_top then
      def.node_box_top = box
   end
   if not def.selection_box_bottom then
      def.selection_box_bottom= box
   end
   if not def.selection_box_top then
      def.selection_box_top = box
   end

   if not def.sound_close_door then
      def.sound_close_door = "door_close"
   end
   if not def.sound_open_door then
      def.sound_open_door = "door_open"
   end
   
   
   minetest.register_craftitem(
      name, {
	 description = def.description,
	 inventory_image = def.inventory_image,

	 on_place = function(itemstack, placer, pointed_thing)
		       if not pointed_thing.type == "node" then
			  return itemstack
		       end

		       local ptu = pointed_thing.under
		       local nu = minetest.get_node(ptu)
		       if minetest.registered_nodes[nu.name].on_rightclick then
			  return minetest.registered_nodes[nu.name].on_rightclick(ptu, nu, placer, itemstack)
		       end

		       local pt = pointed_thing.above
		       local pt2 = {x=pt.x, y=pt.y, z=pt.z}
		       pt2.y = pt2.y+1
		       if
			  not minetest.registered_nodes[minetest.get_node(pt).name].buildable_to or
		       not minetest.registered_nodes[minetest.get_node(pt2).name].buildable_to or
		    not placer or
		    not placer:is_player()
		 then
		    return itemstack
		 end

		 local p2 = minetest.dir_to_facedir(placer:get_look_dir())
		 local pt3 = {x=pt.x, y=pt.y, z=pt.z}
		 if p2 == 0 then
		    pt3.x = pt3.x-1
		 elseif p2 == 1 then
		    pt3.z = pt3.z+1
		 elseif p2 == 2 then
		    pt3.x = pt3.x+1
		 elseif p2 == 3 then
		    pt3.z = pt3.z-1
		 end
		 if minetest.get_item_group(minetest.get_node(pt3).name, "door") == 0 then
		    minetest.set_node(pt, {name=name.."_b_1", param2=p2})
		    minetest.set_node(pt2, {name=name.."_t_1", param2=p2})
		 else
		    minetest.set_node(pt, {name=name.."_b_2", param2=p2})
		    minetest.set_node(pt2, {name=name.."_t_2", param2=p2})
		    minetest.get_meta(pt):set_int("right", 1)
		    minetest.get_meta(pt2):set_int("right", 1)
		 end

		 itemstack:take_item()

		 return itemstack
	      end,
      })

   local tt = def.tiles_top
   local tb = def.tiles_bottom
   
   local function after_dig_node(pos, name, digger)
      local node = minetest.get_node(pos)
      if node.name == name then
	 minetest.node_dig(pos, node, digger)
      end
   end

   local function on_rightclick(pos, dir, check_name, replace, replace_dir, params)
      pos.y = pos.y+dir
      if not minetest.get_node(pos).name == check_name then
	 return
      end
      local p2 = minetest.get_node(pos).param2
      p2 = params[p2+1]
      
      minetest.swap_node(pos, {name=replace_dir, param2=p2})
      
      pos.y = pos.y-dir
      minetest.swap_node(pos, {name=replace, param2=p2})

      local snd_1 = def.sound_close_door
      local snd_2 = def.sound_open_door 
      if params[1] == 3 then
	 snd_1 = def.sound_open_door 
	 snd_2 = def.sound_close_door
      end

      if minetest.get_meta(pos):get_int("right") ~= 0 then
	 minetest.sound_play(snd_1, {pos = pos, gain = 0.8, max_hear_distance = 10})
      else
	 minetest.sound_play(snd_2, {pos = pos, gain = 0.8, max_hear_distance = 10})
      end
   end

   local function check_player_priv(pos, player)
      if not def.only_placer_can_open then
	 return true
      end
      local meta = minetest.get_meta(pos)
      local pn = player:get_player_name()
   end

   minetest.register_node(
      name.."_b_1",
      {
	 tiles = {tb[2], tb[2], tb[2], tb[2], tb[1], tb[1].."^[transformfx"},
	 paramtype = "light",
	 paramtype2 = "facedir",
	 drop = name,
	 drawtype = "nodebox",
	 node_box = {
	    type = "fixed",
	    fixed = def.node_box_bottom
	 },
	 selection_box = {
	    type = "fixed",
	    fixed = def.selection_box_bottom
	 },
	 groups = def.groups,
	 
	 after_dig_node = function(pos, oldnode, oldmetadata, digger)
			     pos.y = pos.y+1
			     after_dig_node(pos, name.."_t_1", digger)
			  end,
	 
	 on_rightclick = function(pos, node, clicker)
			    if check_player_priv(pos, clicker) then
			       on_rightclick(pos, 1, name.."_t_1", name.."_b_2", name.."_t_2", {1,2,3,0})
			    end
			 end,
	 
	 can_dig = check_player_priv,
	 sounds = def.sounds,
	 sunlight_propagates = def.sunlight
      })

   minetest.register_node(
      name.."_t_1",
      {
	 tiles = {tt[2], tt[2], tt[2], tt[2], tt[1], tt[1].."^[transformfx"},
	 paramtype = "light",
	 paramtype2 = "facedir",
	 drop = "",
	 drawtype = "nodebox",
	 node_box = {
	    type = "fixed",
	    fixed = def.node_box_top
	 },
	 selection_box = {
	    type = "fixed",
	    fixed = def.selection_box_top
	 },
	 groups = def.groups,
	 
	 after_dig_node = function(pos, oldnode, oldmetadata, digger)
			     pos.y = pos.y-1
			     after_dig_node(pos, name.."_b_1", digger)
			  end,
	 
	 on_rightclick = function(pos, node, clicker)
			    if check_player_priv(pos, clicker) then
			       on_rightclick(pos, -1, name.."_b_1", name.."_t_2", name.."_b_2", {1,2,3,0})
			    end
			 end,
	 
	 can_dig = check_player_priv,
	 sounds = def.sounds,
	 sunlight_propagates = def.sunlight,
      })

   minetest.register_node(
      name.."_b_2",
      {
	 tiles = {tb[2], tb[2], tb[2], tb[2], tb[1].."^[transformfx", tb[1]},
	 paramtype = "light",
	 paramtype2 = "facedir",
	 drop = name,
	 drawtype = "nodebox",
	 node_box = {
	    type = "fixed",
	    fixed = def.node_box_bottom
	 },
	 selection_box = {
	    type = "fixed",
	    fixed = def.selection_box_bottom
	 },
	 groups = def.groups,
	 
	 after_dig_node = function(pos, oldnode, oldmetadata, digger)
			     pos.y = pos.y+1
			     after_dig_node(pos, name.."_t_2", digger)
			  end,
	 
	 on_rightclick = function(pos, node, clicker)
			    if check_player_priv(pos, clicker) then
			       on_rightclick(pos, 1, name.."_t_2", name.."_b_1", name.."_t_1", {3,0,1,2})
			    end
			 end,
	 
	 can_dig = check_player_priv,
	 sounds = def.sounds,
	 sunlight_propagates = def.sunlight
      })

   minetest.register_node(
      name.."_t_2",
      {
	 tiles = {tt[2], tt[2], tt[2], tt[2], tt[1].."^[transformfx", tt[1]},
	 paramtype = "light",
	 paramtype2 = "facedir",
	 drop = "",
	 drawtype = "nodebox",
	 node_box = {
	    type = "fixed",
	    fixed = def.node_box_top
	 },
	 selection_box = {
	    type = "fixed",
	    fixed = def.selection_box_top
	 },
	 groups = def.groups,
	 
	 after_dig_node = function(pos, oldnode, oldmetadata, digger)
			     pos.y = pos.y-1
			     after_dig_node(pos, name.."_b_2", digger)
			  end,
	 
	 on_rightclick = function(pos, node, clicker)
			    if check_player_priv(pos, clicker) then
			       on_rightclick(pos, -1, name.."_b_2", name.."_t_1", name.."_b_1", {3,0,1,2})
			    end
			 end,
	 
	 can_dig = check_player_priv,
	 sounds = def.sounds,
	 sunlight_propagates = def.sunlight
      })

end

door.register_door(
   "door:door_wood",
   {
      description = "Wooden Door",
      inventory_image = "door_wood.png",
      groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=2,door=1},
      tiles_top = {"door_wood_a.png", "door_brown.png"},
      tiles_bottom = {"door_wood_b.png", "door_brown.png"},
      sounds = default.node_sound_wood_defaults(),
      sunlight = false,
   })

minetest.register_craft(
   {
      output = "door:door_wood",
      recipe = {
	 {"default:fiber", "default:glass", "default:fiber"},
	 {"default:stick", "default:stick", "default:stick"},
	 {"default:fiber", "group:planks", "default:fiber"},
      }
   })

door.register_door(
   "door:door_stone",
   {
      description = "Stone Door",
      inventory_image = "door_stone.png",
      groups = {cracky=3,oddly_breakable_by_hand=1,door=1},
      tiles_top = {"door_stone_a.png", "door_brown.png"},
      tiles_bottom = {"door_stone_b.png", "door_brown.png"},
      sounds = default.node_sound_stone_defaults(),
      sunlight = false,
   })

minetest.register_craft(
   {
      output = "door:door_stone",
      recipe = {
	 {"default:fiber", "default:glass", "default:fiber"},
	 {"default:stick", "default:stick", "default:stick"},
	 {"default:fiber", "group:stone", "default:fiber"},
      }
   })

default.log("mod:door", "loaded")