--
-- Gives initial stuff
-- By Kaadmy, for Pixture
--

local function give_initial_stuff(player)
   minetest.chat_send_player(player:get_player_name(), "Welcome to Pixture!")
   
   if minetest.setting_getbool("give_initial_stuff") then
      local inv=player:get_inventory()

      inv:add_item("main", "default:pick_stone")
      inv:add_item("main", "default:torch 10")
   end
end

minetest.register_on_newplayer(give_initial_stuff)
