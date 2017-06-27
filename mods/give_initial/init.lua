--
-- Gives initial stuff
-- By Kaadmy, for Pixture
--

local give_initial_enable = minetest.settings:get_bool("give_initial_enable")
local give_initial_items = util.split(minetest.settings:get("give_initial_items"), ",")

local function on_newplayer(player)
   if give_initial_enable then
      local inv = player:get_inventory()

      for _, itemstring in ipairs(give_initial_items) do
         inv:add_item("main", itemstring)
      end
   end
end

minetest.register_on_newplayer(on_newplayer)

default.log("mod:give_initial", "loaded")
