--
-- Gives initial stuff
-- By Kaadmy, for Pixture
--

local giveme = minetest.setting_getbool("give_initial_stuff")

local function give_initial_stuff(player)
   if giveme then
      local inv=player:get_inventory()

      inv:add_item("main", "default:pick_stone")
      inv:add_item("main", "default:torch_weak 10")
   end
end

minetest.register_on_newplayer(give_initial_stuff)

default.log("mod:give_initial_stuff", "loaded")