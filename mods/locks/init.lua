--
-- Locks mod
-- By Kaadmy, for Pixture
--

locks = {}

local picked_time = tonumber(core.setting_get("locks_picked_time")) or 15 -- unlocked for 15 seconds
local all_unlocked = core.setting_getbool("locks_all_unlocked")

function locks.is_owner(meta, player)
   local name = player:get_player_name()
   local owner = meta:get_string("lock_owner")

   return name == owner
end

function locks.is_locked(meta, player)
   if all_unlocked then
      return false
   end

   if locks.is_owner(meta, player) then
      return false
   end

   local t = core.get_gametime()

   local lp = meta:get_float("last_lock_pick")

   if lp == -1 or lp == nil then
      lp = -1
   end

   if lp > t then
      return false
   else
      meta:set_float("last_lock_pick", -1)
   end

   return true
end

core.register_tool(
   "locks:pick",
   {
      description = "Lock Pick",

      inventory_image = "locks_pick.png",
      wield_image = "locks_pick.png",

      stack_max = 1,

      on_use = function(itemstack, player, pointed_thing)
         if math.random(1, 5) <= 1 then
            local pos = pointed_thing.under

            local meta = core.get_meta(pos)
            meta:set_float("last_lock_pick", core.get_gametime() + picked_time)

            local own = meta:get_string("lock_owner")
            if own then
               core.chat_send_player(
                  own,
                  core.colorize("#f00", player:get_player_name() .. " has broken into your locked chest!"))
            end
         end

         itemstack:add_wear(8200) -- about 8 uses
         return itemstack
      end,
})

core.register_craftitem(
   "locks:lock",
   {
      description = "Lock",

      inventory_image = "locks_lock.png",
      wield_image = "locks_lock.png",
})

core.register_craft(
   {
      output = "locks:pick",
      recipe = {
	 {"", "", "default:ingot_steel"},
	 {"", "default:stick", ""},
	 {"default:stick", "", ""},
      },
})

core.register_craft(
   {
      output = "locks:lock",
      recipe = {
	 {"", "default:ingot_steel", ""},
	 {"default:ingot_steel", "", "default:ingot_steel"},
	 {"group:planks", "group:planks", "group:planks"},
      },
})

core.register_node(
   "locks:chest",
   {
      description = "Locked Chest",
      tiles ={"default_chest_top.png", "default_chest_top.png", "default_chest_sides.png",
	      "default_chest_sides.png", "default_chest_sides.png", "locks_chest_front.png"},
      paramtype2 = "facedir",
      groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 2},
      is_ground_content = false,
      sounds = default.node_sound_wood_defaults(),
      on_construct = function(pos)
         local meta = core.get_meta(pos)
         meta:set_float("last_lock_pick", -1)

         local inv = meta:get_inventory()
         inv:set_size("main", 8 * 4)
      end,
      after_place_node = function(pos, player)
         local name = player:get_player_name()

         local meta = core.get_meta(pos)
         meta:set_string("infotext", "Locked Chest (Owned by " .. name .. ")")
         meta:set_string("lock_owner", name)
      end,
      on_rightclick = function(pos, node, player)
         local meta = core.get_meta(pos)

         if not locks.is_locked(meta, player) then
            if locks.is_owner(meta, player) then
               -- also unlock when owner opens for "sharing" locked stuff
               meta:set_float("last_lock_pick", core.get_gametime() + 5)
            end

            local np = pos.x .. "," .. pos.y .. "," .. pos.z
            local form = default.ui.get_page("core_2part")
            form = form .. "list[nodemeta:" .. np .. ";main;0.25,0.25;8,4;]"
            form = form .. "listring[nodemeta:" .. np .. ";main]"
            form = form .. default.ui.get_itemslot_bg(0.25, 0.25, 8, 4)

            form = form .. "list[current_player;main;0.25,4.75;8,4;]"
            form = form .. "listring[current_player;main]"
            form = form .. default.ui.get_hotbar_itemslot_bg(0.25, 4.75, 8, 1)
            form = form .. default.ui.get_itemslot_bg(0.25, 5.75, 8, 3)

            core.show_formspec(
               player:get_player_name(),
               "default_chest",
               form
            )
         end
      end,
      allow_metadata_inventory_move = function(pos, from_l, from_i, to_l, to_i, cnt, player)
         local meta = core.get_meta(pos)
         if locks.is_locked(meta, player) then
            return 0
         end
         return cnt
      end,
      allow_metadata_inventory_put = function(pos, listname, index, itemstack, player)
         local meta = core.get_meta(pos)
         if locks.is_locked(meta, player) then
            return 0
         end
         return itemstack:get_count()
      end,
      allow_metadata_inventory_take = function(pos, listname, index, itemstack, player)
         local meta = core.get_meta(pos)
         if locks.is_locked(meta, player) then
            return 0
         end
         return itemstack:get_count()
      end,
      can_dig = function(pos, player)
         local meta = core.get_meta(pos)
         local inv = meta:get_inventory()
         return inv:is_empty("main") and locks.is_owner(meta, player)
      end,
      write_name = function(pos, text)
         local meta = core.get_meta(pos)

         if text ~= "" then
            meta:set_string("infotext", text .. " (Owned by " .. meta:get_string("lock_owner") .. ")")
         else
            meta:set_string("infotext", "Locked Chest (Owned by " .. meta:get_string("lock_owner") .. ")")
         end
      end,
      on_blast = function() end,
})

core.register_craft(
   {
      output = "locks:chest",
      type = "shapeless",
      recipe = {"default:chest", "locks:lock"},
})

-- Achievements

achievements.register_achievement(
   "locksmith",
   {
      title = "Locksmith",
      description = "Craft a lock",
      times = 1,
      craftitem = "locks:lock",
})

achievements.register_achievement(
   "burglar",
   {
      title = "Burglar",
      description = "Craft a lock pick",
      times = 1,
      craftitem = "locks:pick",
})

default.log("mod:locks", "loaded")
