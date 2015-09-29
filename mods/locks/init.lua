--
-- Locks mod
-- By Kaadmy, for Pixture
--

locks = {}

function locks.is_locked(pos, player)
   local pos = pointed_thing.under
end

minetest.register_craftitem(
   "locks:pick",
   {
      description = "Lock Pick",
      
      inventory_image = "locks_pick.png",
      wield_image = "locks_pick.png",

      on_use = function(itemstack, user, pointed_thing)
		  local pos = pointed_thing.under

		  local meta = minetest.get_meta(pos)

		  
	       end,
   })