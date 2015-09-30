--
-- Locks mod
-- By Kaadmy, for Pixture
--

locks = {}

locks.picked_time = tonumber(minetest.setting_getbool("locks_picked_time")) or 15 -- unlocked for 15 seconds

local all_unlocked = minetest.setting_getbool("locks_all_unlocked")

function locks.is_locked(meta, player)
   if meta:get_float("last_lock_pick") > locks.picked_time then
   end
end

minetest.register_craftitem(
   "locks:pick",
   {
      description = "Lock Pick",
      
      inventory_image = "locks_pick.png",
      wield_image = "locks_pick.png",

      on_use = function(itemstack, user, pointed_thing)
		  
	       end,
   })

minetest.register_node(
   "locks:chest",
   {
      description = "Locked Chest",
      tiles ={"default_chest_top.png", "default_chest_top.png", "default_chest_sides.png",
	      "default_chest_sides.png", "default_chest_sides.png", "default_chest_front.png^default_ingot_steel.png"},
      paramtype2 = "facedir",
      groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
      is_ground_content = false,
      sounds = default.node_sound_wood_defaults(),
      after_place_node = function(pos, player)
			local form = default.ui.get_page("default_chest")

			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", form)
			meta:set_string("infotext", "Locked Chest (Owned by " .. player:get_player_name() .. ")")

			local inv = meta:get_inventory()
			inv:set_size("main", 8*4)
		     end,
      can_dig = function(pos, player)
		   local meta = minetest.get_meta(pos)
		   local inv = meta:get_inventory()
		   return inv:is_empty("main") and locks.is_owner(meta, player)
		end,
   })